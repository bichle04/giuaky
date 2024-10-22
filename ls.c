#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>
#include <string.h>
#include "ls.h"
#include "print.h"

void list_directory(const char *path, int flags) {
    DIR *dir;
    struct dirent *entry;
    struct stat statbuf;

    if ((dir = opendir(path)) == NULL) {
        perror("opendir");
        return;
    }

    while ((entry = readdir(dir)) != NULL) {
        if (flags & FLAG_A || entry->d_name[0] != '.') {
            if (flags & FLAG_L) {
                char fullpath[1024];
                snprintf(fullpath, sizeof(fullpath), "%s/%s", path, entry->d_name);
                if (stat(fullpath, &statbuf) == -1) {
                    perror("stat");
                    continue;
                }
                print_long_format(entry, &statbuf);
            } else {
                printf("%s\n", entry->d_name);
            }
        }
    }
    closedir(dir);
}

int main(int argc, char *argv[]) {
    int flags = 0;
    int opt;

    while ((opt = getopt(argc, argv, "AacdFfhiklnoqRrSstuw")) != -1) {
        switch (opt) {
            case 'A': flags |= FLAG_A; break;
            case 'a': flags |= FLAG_a; break;
            case 'c': flags |= FLAG_c; break;
            case 'd': flags |= FLAG_d; break;
            case 'F': flags |= FLAG_F; break;
            case 'f': flags |= FLAG_f; break;
            case 'h': flags |= FLAG_h; break;
            case 'i': flags |= FLAG_i; break;
            case 'k': flags |= FLAG_k; break;
            case 'l': flags |= FLAG_L; break;
            case 'n': flags |= FLAG_n; break;
            case 'o': flags |= FLAG_o; break;
            case 'q': flags |= FLAG_q; break;
            case 'R': flags |= FLAG_R; break;
            case 'r': flags |= FLAG_r; break;
            case 'S': flags |= FLAG_S; break;
            case 's': flags |= FLAG_s; break;
            case 't': flags |= FLAG_t; break;
            case 'u': flags |= FLAG_u; break;
            case 'w': flags |= FLAG_w; break;
            default:
                fprintf(stderr, "Usage: %s [-AacdFfhiklnoqRrSstuw] [file...]\n", argv[0]);
                exit(EXIT_FAILURE);
        }
    }

    if (optind == argc) {
        list_directory(".", flags);
    } else {
        for (int i = optind; i < argc; i++) {
            list_directory(argv[i], flags);
        }
    }

    return 0;
}