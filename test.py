#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import re

def change_method_content(file_path, method_name, new_content):
    # Đọc nội dung từ file
    with open(file_path, 'r') as file:
        content = file.read()

    # Tạo pattern để tìm method cần thay đổi
    method_pattern = r'\.method .* {}\(.*\)\s*([\s\S]*?)\.end method'.format(re.escape(method_name))

    # Tìm tất cả các method trong file
    matches = re.finditer(method_pattern, content)

    # Duyệt qua từng method để thay đổi nội dung
    for match in matches:
        # Lấy vị trí bắt đầu và kết thúc của method
        start_index = match.start()
        end_index = match.end()

        # Thay đổi nội dung của method
        new_method_content = ".method * {}(*)\n{}\n.end method".format(method_name, new_content)
        content = content[:start_index] + new_method_content + content[end_index:]

    # Ghi lại nội dung mới vào file
    with open(file_path, 'w') as file:
        file.write(content)

# Sử dụng hàm change_method_content để thay đổi nội dung của method trong file test.smali
file_path = 'test.smali'
method_name = 'parseTopSmartAppFromDb'
new_content = (
    "    .registers 4\n"
    "    return-void\n"
)

change_method_content(file_path, method_name, new_content)
