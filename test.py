#!/usr/bin/env python3
# -*- coding: utf-8 -*-
def modify_smali_method(file_name, method_name, new_code):
    # Đọc dữ liệu từ file smali
    with open(file_name, 'r') as file:
        data = file.read()

    # Tìm kiếm method cần sửa đổi
    method_start = data.find(".method " + method_name)
    if method_start == -1:
        print("Không tìm thấy method " + method_name)
        return

    # Tìm kiếm kết thúc của method
    method_end = data.find(".end method", method_start)
    if method_end == -1:
        print("Không tìm thấy kết thúc của method " + method_name)
        return

    # Sửa đổi code của method
    modified_data = data[:method_start] + new_code + data[method_end:]

    # Ghi dữ liệu đã sửa đổi ra file
    with open(file_name, 'w') as file:
        file.write(modified_data)

    print("Đã sửa đổi method " + method_name)

# Sử dụng hàm để sửa đổi method có tên là "testMethod"
modify_smali_method("test.smali", "parseTopSmartAppFromDb", """
    .registers 4
    const/4 v0, 0x0
    return v0
""")
