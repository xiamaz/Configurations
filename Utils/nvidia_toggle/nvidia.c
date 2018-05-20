#define _POSIX_C_SOURCE 200112L
#include<stdio.h>
#include<sys/types.h>
#include<unistd.h>
#define BBSWITCH_PATH "/proc/acpi/bbswitch"
#define OFF_CMD "OFF"
#define ON_CMD "ON"
#define OFF_MSG "off\n"
#define ON_MSG "on\n"

int switch_state(char c, int state) {
	switch(c) {
	case 'O':
		state = -2;
		break;
	case 'F':
		if (state == -2 || state == 0) {
			state = 0;
		} else {
			state = -1;
		}
		break;
	case 'N':
		if (state == -2) {
			state = 1;
		} else {
			state = -1;
		}
		break;
	}
	return state;
}

int get_status() {
	char c;
	int state = -1;
	FILE *status_file = fopen(BBSWITCH_PATH, "r");
	if (status_file) {
		while ((c = getc(status_file)) != EOF) {
			state = switch_state(c, state);
		}
		fclose(status_file);
	} else {
		printf("Error opening file\n");
	}
	return state;
}

void set_status(int status) {
	FILE *status_file = fopen(BBSWITCH_PATH, "w");
	if (status_file) {
		switch(status) {
		case 0:
			fputs(OFF_CMD, status_file);
			break;
		case 1:
			fputs(ON_CMD, status_file);
			break;
		}
		fclose(status_file);
	} else {
		printf("Error opening file\n");
	}
}



int main(int argc, char **argv) {
	if (argc < 2) {
		printf("Usage: t (toggle status) g (get status) s (set status)\n");
		return 0;
	}
	switch (*argv[1]) {
	case 't':
		printf("Toggle\n");
		switch(get_status()) {
		case 0:
			set_status(1);
			break;
		case 1:
			set_status(0);
			break;
		}
		break;
	case 'g':
		switch(get_status()) {
		case 0:
			printf(OFF_MSG);
			break;
		case 1:
			printf(ON_MSG);
			break;
		}
		break;
	case 's':
		if (argc != 3) {
			printf("Usage set: 0 - off, 1 - on\n");
			return 0;
		}
		printf("Set to %c\n", *argv[2]);
		set_status(*argv[2] - '0');
		break;
	}
}
