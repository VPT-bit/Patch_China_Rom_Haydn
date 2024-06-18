#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import re

def thay_doi_method(file_path, ten_method, noi_dung_moi):
    # Đọc nội dung từ file smali
    with open(file_path, 'r', encoding='utf-8') as file:
        content = file.read()

    # Tạo biểu thức chính quy để tìm method
    pattern = re.compile(r'(\.method .* ' + re.escape(ten_method) + r'\(.*?\)\s*.*?)\.end method', re.DOTALL)

    # Tìm kiếm method trong nội dung
    match = re.search(pattern, content)
    if match:
        # Lấy nội dung của method cần thay đổi
        old_method_content = match.group(1)

        # Thay đổi nội dung của method
        new_method_content = old_method_content + noi_dung_moi
        new_content = content.replace(old_method_content, new_method_content)

        # Ghi lại nội dung đã thay đổi vào file
        with open(file_path, 'w', encoding='utf-8') as file:
            file.write(new_content)
        
        print(f"Đã thay đổi nội dung của method '{ten_method}' thành công.")
    else:
        print(f"Không tìm thấy method '{ten_method}' trong file '{file_path}'.")

# Ví dụ sử dụng hàm thay_doi_method:
file_path = 'test.smali'
ten_method_can_thay_doi = 'parseTopSmartAppFromDb'
noi_dung_moi = '''
    .registers 4

    return-void
'''

thay_doi_method(file_path, ten_method_can_thay_doi, noi_dung_moi)
