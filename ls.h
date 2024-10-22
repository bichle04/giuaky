#ifndef LS_H
#define LS_H

#define FLAG_A 1
#define FLAG_a 2
#define FLAG_c 4
#define FLAG_d 8
#define FLAG_F 16
#define FLAG_f 32
#define FLAG_h 64
#define FLAG_i 128
#define FLAG_k 256
#define FLAG_L 512
#define FLAG_n 1024
#define FLAG_o 2048
#define FLAG_q 4096
#define FLAG_R 8192
#define FLAG_r 16384
#define FLAG_S 32768
#define FLAG_s 65536
#define FLAG_t 131072
#define FLAG_u 262144
#define FLAG_w 524288

void list_directory(const char *path, int flags);

#endif