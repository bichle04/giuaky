#!/bin/sh

# Dừng script nếu có bất kỳ lệnh nào trả về mã lỗi khác 0
set -e

# Tạo thư mục 'testdir' nếu chưa tồn tại
mkdir -p testdir
# Chuyển vào thư mục 'testdir'
cd testdir

# Tạo thư mục 'd'
mkdir d
# Tạo file rỗng có tên 'empty'
touch empty
# Tạo file có nội dung 'file'
echo file > file
# Tạo hard link 'file2' trỏ đến file 'file'
ln file file2
# Tạo symbolic link 'emptylink' trỏ đến chuỗi rỗng
ln -s "" emptylink
# Tạo symbolic link 'nowhere' trỏ đến đường dẫn không tồn tại
ln -s /nowhere
# Tạo symbolic link 'symlink' trỏ đến file 'file2'
ln -s file2 symlink
# Tạo file 'atime' và đặt thời gian truy cập là 2018-10-01 22:22
touch -a -t 201810012222 atime
# Tạo file 'longago' và đặt thời gian sửa đổi là 1969-12-01 00:00
touch -t 196912010000 longago
# Tạo file 'inthefuture' và đặt thời gian sửa đổi là 3000-11-11 11:11
touch -t 300011111111 inthefuture
# Tạo thư mục 'subdir'
mkdir subdir
# Đặt quyền truy cập cho thư mục 'subdir' là 1755 (rwxr-xr-t)
chmod 1755 subdir
# Tạo symbolic link 'loopdir' trỏ đến thư mục hiện tại (tạo vòng lặp)
ln -s . subdir/loopdir
# Tạo file 'executable'
touch executable
# Đặt quyền truy cập cho file 'executable' là 755 (rwxr-xr-x)
chmod 755 executable
# Tạo file 'suid:sgid'
touch suid:sgid
# Đặt quyền truy cập cho file 'suid:sgid' là 6755 (rwsr-sr-x)
chmod 6755 suid:sgid
# Tạo file 'missing-exec'
touch missing-exec
# Đặt quyền truy cập cho file 'missing-exec' là 4000 (rws------)
chmod 4000 missing-exec
# Tạo file có tên là một khoảng trắng
touch " "
# Tạo file có tên là một tab
touch "	"
# Tạo file có tên là 'foo' và nội dung là 'bar'
touch "foo
bar"

# Đổi chủ sở hữu của file 'file' thành 'nobody:operator'
su root -c "chown nobody:operator file"
# Đổi chủ sở hữu của thư mục 'd' thành 'games:daemon'
su root -c "chown games:daemon d"
# Tạo file 'noowner'
touch noowner
# Đổi chủ sở hữu của file 'noowner' thành UID 1234
su root -c "chown 1234 noowner"
# Tạo file 'nogroup'
touch nogroup
# Đổi nhóm sở hữu của file 'nogroup' thành GID 1234
su root -c "chown :1234 nogroup"
# Tạo symbolic link 'ls-LR' trỏ đến thư mục gốc
ln -s / "ls-LR"
# Sao chép file '/dev/null' vào thư mục hiện tại với tên 'null'
su root -c "cp -a /dev/null null"
# Tạo file có tên là chuỗi 'a' lặp lại 255 lần
touch $(yes a | head -255 | tr -d '\n')

# Tạo file 'hole.c' với nội dung sau
cat >hole.c <<EOF
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

char buf1[] = "abcdefghij";
char buf2[] = "ABCDEFGHIJ";

#define BIGNUM 10240000

int
main(void) {
    int fd;

    if ((fd = creat("file.hole", S_IRUSR | S_IWUSR)) < 0) {
        perror("creat error");
        return EXIT_FAILURE;
    }
    if (write(fd, buf1, strlen(buf1)) != (ssize_t)strlen(buf1)) {
        perror("error writing buf1");
        return EXIT_FAILURE;
    }

    if (lseek(fd, BIGNUM, SEEK_CUR) == -1) {
        perror("lseek error");
        return EXIT_FAILURE;
    }

    if (write(fd, buf2, strlen(buf2)) != (ssize_t)strlen(buf2)) {
        perror("error writing buf2");
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
EOF

# Biên dịch file 'hole.c' với các cờ '-Wall' và '-Werror'
cc -Wall -Werror hole.c
# Chạy chương trình vừa biên dịch
./a.out

# Tạo thư mục 'nested'
mkdir nested
# Chuyển vào thư mục 'nested'
cd nested
# Tạo 512 thư mục con lồng nhau
(
for i in jot 512; do
    mkdir $i
    cd $i
done
)

# Tạo 30 thư mục con lồng nhau với tên là chuỗi 'a' lặp lại 255 lần và symbolic link 'b' trỏ đến các thư mục này
(
for i in jot 30; do
    mkdir yes a | head -255 | tr -d '\n'
    ln -s a* b
    cd b
done
)