#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import re

def modify_smali_method(file_name, method_name, new_code):
    # Đọc dữ liệu từ file smali
    with open(file_name, 'r') as file:
        data = file.read()

    # Sử dụng biểu thức chính quy để tìm kiếm và sửa đổi code của method
    pattern = re.compile(r'\.method .* ' + method_name + r'\(.*?\)(.*?)\.end method', re.DOTALL)
    match = pattern.search(data)
    if match:
        start_index = match.start(1)
        end_index = match.end(1)
        modified_data = data[:start_index] + new_code + data[end_index:]
        with open(file_name, 'w') as file:
            file.write(modified_data)
        print("Đã sửa đổi method " + method_name)
    else:
        print("Không tìm thấy method " + method_name)

# Sử dụng hàm để sửa đổi method có tên là "testMethod"
modify_smali_method("test.smali", "parseTopSmartAppFromDb", "\t.registers 4\n\n\treturn-void\n")
