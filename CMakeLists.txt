# phiên bản tối thiểu của CMake yêu cầu để chạy dự án
cmake_minimum_required(VERSION 3.10)

# Đặt tên cho dự án là "ls_project"
project(ls_project)

# Đặt tiêu chuẩn ngôn ngữ C là C99
set(CMAKE_C_STANDARD 99)

# Đặt các cờ biên dịch cho trình biên dịch C, gồm các cờ hiển thị cảnh báo và coi cảnh báo là lỗi
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -Werror")

# Tạo một tệp thực thi từ các tệp nguồn ls.c và print.c, và đặt tên tệp thực thi là "ls"
add_executable(ls ls.c print.c)