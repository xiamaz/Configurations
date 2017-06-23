#include <stdio.h>

int keyboardStatus(char * path) {
	FILE* bklight;
	int status;

	bklight = fopen(path, "r");
	//bklight = fopen("test", "r");

	if (bklight == NULL) {
		printf("Could not open source file\n");
		return -1;
	} else {
		fscanf (bklight, "%i", &status);
		fclose(bklight);
		return status;
	}
}

void kbdWrite(int wval, char * path){
	FILE* wfile;
	wfile = fopen(path, "w");
	fprintf(wfile, "%d", wval);
}

int main() {
	int result;
 	char * path = "/sys/devices/LNXSYSTM:00/LNXSYBUS:00/TOS6208:00/kbd_backlight_mode";
	result = keyboardStatus(path);
	printf("%i", result);
	switch(result) {
		case 16:
			// our keyboard backlight is off, turn it on
			kbdWrite(8, path);
			break;
		case 8:
			// backlight on, turn it off
			kbdWrite(16, path);
			break;
		default:
			break;
	}
	return 0;
}
