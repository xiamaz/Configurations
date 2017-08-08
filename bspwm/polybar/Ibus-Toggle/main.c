#include <ibus.h>
#include <stdio.h>
#include <dconf.h>

int main (int *argc, char **argv)
{
	IBusBus *ibb = ibus_bus_new();
	const char *current_engine = ibus_engine_desc_get_name(ibus_bus_get_global_engine(ibb));

	GVariantIter *iter;
	gchar *str;
	DConfClient *dc = dconf_client_new();
	g_variant_get(dconf_client_read(dc, "/desktop/ibus/general/preload-engines"), "as", &iter);

	int first = 1;
	gchar *new;
	while (g_variant_iter_loop(iter, "s", &str)) {
		if (first) {
			g_free(new);
			new = g_strdup(str);
			first = 0;
		}
		if (!g_strcmp0(current_engine, str)) {
			first = 1;
		}
	}
	g_print("%s\n", new);
	ibus_bus_set_global_engine(ibb, new);
	return 0;
}
