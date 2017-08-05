#include <libwnck/libwnck.h>
#include <signal.h>
#include <stdlib.h>

GMainLoop *loop;
WnckScreen *screen;

static int stop_pid(int pid)
{
	kill((pid_t) pid, SIGSTOP);
	return pid;
}

static int cont_pid(int pid)
{
	kill((pid_t) pid, SIGCONT);
	return pid;
}

static void on_active_window_changed(WnckScreen *screen,
		WnckWindow *previously_active_window,
		gpointer user_data)
{
	GList *window_l;
	WnckWindow *active_window = wnck_screen_get_active_window(screen);
	WnckWorkspace *active_workspace = wnck_screen_get_active_workspace(screen);
	GList *pids_current = NULL;
	GList *pids_other = NULL;

	for (window_l = wnck_screen_get_windows(screen); window_l != NULL; window_l = window_l->next) {
		WnckWindow *window = WNCK_WINDOW(window_l->data);
		WnckApplication *app = wnck_application_get(wnck_window_get_group_leader(window));
		WnckWorkspace *w_workspace = wnck_window_get_workspace(window);
		if (!w_workspace)
			continue;
		GList *app_window_l;

		int w_pid = wnck_application_get_pid(app);
		if (w_workspace == active_workspace) {
			GList *g = g_list_find(pids_current, GINT_TO_POINTER(w_pid));
			if (!g) pids_current = g_list_append(pids_current, GINT_TO_POINTER(w_pid));
		} else {
			GList *g = g_list_find(pids_other, GINT_TO_POINTER(w_pid));
			if (!g) pids_other = g_list_append(pids_other, GINT_TO_POINTER(w_pid));
		}
	}
	for (; pids_other != NULL; pids_other = pids_other->next) {
		GList *g = g_list_find(pids_current, pids_other->data);
		if (g)
			g_print("Another window of this application is active\n");
		else
			g_print("PID: %d\n", stop_pid(GPOINTER_TO_INT(pids_other->data)));
	}
	for (; pids_current != NULL; pids_current = pids_current->next) {
		cont_pid(GPOINTER_TO_INT(pids_current->data));
	}
	g_print("-----\n");
}

static void continue_all(WnckScreen *screen)
{
	GList *window_l;
	for (window_l = wnck_screen_get_windows(screen); window_l != NULL; window_l = window_l->next) {
		WnckWindow *window = WNCK_WINDOW(window_l->data);
		int pid = wnck_window_get_pid(window);
		cont_pid(pid);
	}
}

static void stop_application()
{
	continue_all(screen);
	g_main_loop_unref(loop);
	exit(0);
}

void INThandler(int sig)
{
	g_print("Exiting program");
	stop_application();
}

int main (int argc, char **argv)
{

  gdk_init (&argc, &argv);

  loop = g_main_loop_new (NULL, FALSE);
  screen = wnck_screen_get_default ();

  signal(SIGINT, INThandler);


  g_signal_connect(screen, "active-window-changed",
  		  G_CALLBACK(on_active_window_changed), NULL);

  g_main_loop_run (loop);

  stop_application();

  return 0;
}
