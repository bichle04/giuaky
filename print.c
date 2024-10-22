#include <stdio.h>
#include <sys/stat.h>
#include <pwd.h>
#include <grp.h>
#include <time.h>
#include "print.h"

void print_long_format(struct dirent *entry, struct stat *statbuf) {
    char perms[11] = "----------";
    char timebuf[80];
    struct passwd *pwd;
    struct group *grp;
    struct tm *tm_info;

    if (S_ISDIR(statbuf->st_mode)) perms[0] = 'd';
    if (statbuf->st_mode & S_IRUSR) perms[1] = 'r';
    if (statbuf->st_mode & S_IWUSR) perms[2] = 'w';
    if (statbuf->st_mode & S_IXUSR) perms[3] = 'x';
    if (statbuf->st_mode & S_IRGRP) perms[4] = 'r';
    if (statbuf->st_mode & S_IWGRP) perms[5] = 'w';
    if (statbuf->st_mode & S_IXGRP) perms[6] = 'x';
    if (statbuf->st_mode & S_IROTH) perms[7] = 'r';
    if (statbuf->st_mode & S_IWOTH) perms[8] = 'w';
    if (statbuf->st_mode & S_IXOTH) perms[9] = 'x';

    pwd = getpwuid(statbuf->st_uid);
    grp = getgrgid(statbuf->st_gid);
    tm_info = localtime(&statbuf->st_mtime);
    strftime(timebuf, sizeof(timebuf), "%b %d %H:%M", tm_info);

    printf("%s %ld %s %s %5ld %s %s\n", perms, statbuf->st_nlink, pwd->pw_name, grp->gr_name, statbuf->st_size, timebuf, entry->d_name);
}