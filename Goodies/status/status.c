#define _GNU_SOURCE
#include<stdio.h>
#include<stdlib.h>
#include<unistd.h>
#include<string.h>
#include<ctype.h>
#include"status.h"

int main (int argc, char **argv) {
	char temp_raw[30];
	FILE *tempfp;
	unsigned int zone = 1;
	char *thermal_zone;
	unsigned int temp;

	FILE *cpufp;
	FILE *prev_cpufp;
	unsigned int a[8], b[2];
	unsigned int non_idle, total;
	long double percentage;


	FILE * loadfp;
	double loads[3];

	FILE * ramfp;
	int available;
	char tag[20];
	int count = 0;
	int dim;

	char out_string[800];
	cpufp = fopen(PROC_STAT, "r");
	if (!cpufp) perror("Could not open /proc/stat"), exit(1);
	/* user, nice, system, idle, iowait, irq, softirq, steal */
	fscanf(cpufp, "%*s %u %u %u %u %u %u %u %u",
	       &a[0], &a[1], &a[2], &a[3], &a[4],
	       &a[5], &a[6], &a[7]);
	fclose(cpufp);
	non_idle = a[0] + a[1] + a[2] + a[5] + a[6] + a[7];
	total = a[0] + a[1] + a[2] + a[3] + a[4] + a[5] + a[6] + a[7];
	if (access(STATUS_PSTAT, F_OK) == 0) {
		prev_cpufp = fopen(STATUS_PSTAT, "r");
		/* non-idle, total */
		fscanf(prev_cpufp, "%u %u", &b[0], &b[1]);
		fclose(prev_cpufp);
	} else {
		b[0] = 0.0;
		b[1] = 0.0;
	}
	prev_cpufp = fopen(STATUS_PSTAT, "w");
	fprintf(prev_cpufp, "%u %u\n", non_idle, total);
	fclose(prev_cpufp);
	percentage = ((double) (non_idle - b[0])) / ((double) (total - b[1]) ) * 100;

	/* temperature reading */
	if (!asprintf(&thermal_zone, "/sys/class/thermal/thermal_zone%u/temp", zone))
		perror("Could not generate path."), exit(1);
	tempfp = fopen(thermal_zone, "r");
	if (!tempfp) perror("Couldn't open file."), exit(1);
	fgets(temp_raw, 30, tempfp);
	fclose(tempfp);
	temp = TEMP_CALC(strtol(temp_raw, NULL, 10));

#if OPTIMUS == 1
	char *nv_status;
	FILE *bbsfp;
	char bbs_raw[30];
	/* nvidia optimus state */
	bbsfp = fopen(BBSWITCH, "r");
	if (!bbsfp) perror("Couldn't open file."), exit(1);
	fgets(bbs_raw, 30, bbsfp);
	fclose(bbsfp);
	strtok(bbs_raw, " \n");
	nv_status = strtok(NULL, " \n");
	for (char *p = nv_status; *p; ++p) *p = tolower(*p);
#endif

	/* ram information */
	ramfp = fopen(PROC_MEM, "r");
	while (fscanf(ramfp, "%s %d %*s", tag, &available) != EOF && count < 2)
		count++;
	fclose(ramfp);

	/* loadavg */
	loadfp = fopen(PROC_LOADAVG, "r");
	fscanf(loadfp, "%lf %lf %lf", &loads[0], &loads[1], &loads[2]);
	fclose(loadfp);


	for (dim = 0; available > 1000; dim++,available = available / 1000);

#if OPTIMUS == 1
	snprintf(out_string, sizeof(out_string), FORMAT_STRING, percentage, available,
	         SIZES[dim], temp, nv_status, loads[0], loads[1], loads[2]);
#else
	snprintf(out_string, sizeof(out_string), FORMAT_STRING, percentage, available,
	         SIZES[dim], temp, loads[0], loads[1], loads[2]);
#endif

	printf("%s\n", out_string);

	return 0;
}
