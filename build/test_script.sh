#!/bin/sh
#set -e

COMMANDS="./ls
./ls -l
./ls -la
./ls -lai
./ls -lairt
./ls -lairtus
./ls -d
./ls -d .
./ls -d . .. /
./ls -n /home
./ls -l /dev
./ls -lsh
./ls -lF
./ls -A ~/testdir
./ls -w ~/testdir
./ls ~/testdir | more
./ls ~/testdir/d
./ls -l ~/testdir/d
./ls -la ~/testdir/d
BLOCKSIZE=bacon ./ls -ls
BLOCKSIZE=0 ./ls -ls
BLOCKSIZE=2048 ./ls -ls
BLOCKSIZE=-50 ./ls -ls
BLOCKSIZE=50 ./ls -ls
TZ=PST8PDT ./ls -lc
TZ=bacon ./ls -lc
./ls -lks
./ls / /tmp ~ .
./ls -?
./ls /does/not/exit
./ls /nowhere
./ls -A
./ls -a
./ls -c
./ls -d
./ls -F
./ls -f
./ls -h
./ls -i
./ls -k
./ls -l
./ls -n
./ls -q
./ls -R
./ls -r
./ls -S
./ls -s
./ls -t
./ls -u
./ls -w"

IFS="
"

for c in ${COMMANDS}; do
    echo ${c}
    timeout -- 60 sh -c "eval ${c}" || echo timed out
done

echo "./ls -lR /"
timeout 600 ./ls -lR / || echo timed out