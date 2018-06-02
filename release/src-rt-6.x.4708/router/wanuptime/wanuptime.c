#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sys/sysinfo.h>
#include <linux/limits.h>

int main(int argc, char *argv[])
{
    char prefix[] = "wanXX_";
    if (argc > 1)
        strcpy(prefix, argv[1]);
    else
        strcpy(prefix, "wan");

    struct sysinfo si;
    time_t uptime;
    char *wantime_file;

    wantime_file = calloc(1, PATH_MAX);
    if (wantime_file == NULL) {
        /* calloc/malloc failed */
        return 1;
    }

    strlcpy(wantime_file, "/var/lib/misc/wan_time", PATH_MAX);

    if (sysinfo(&si) == -1) {
        free(wantime_file);
            return 1;
    }

    if (check_wanup(prefix) && f_read(wantime_file, &uptime, sizeof(time_t)) ==  sizeof(uptime)) {
        printf("%ld\n",si.uptime - uptime);
    }
    else
        printf("0\n");

    free(wantime_file);
    return 0;
}