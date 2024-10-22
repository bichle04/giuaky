#ifndef PRINT_H
#define PRINT_H

#include <dirent.h>
#include <sys/stat.h>

void print_long_format(struct dirent *entry, struct stat *statbuf);

#endif