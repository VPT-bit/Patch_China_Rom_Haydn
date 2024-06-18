#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import re

def thay_doi_method(file_path, ten_method, noi_dung_moi):
    with open(file_path, 'r', encoding='utf-8') as file:
        smali_content = file.read()

    pattern = r'\.method .*? ' + re.escape(ten_method) + r'.*?\.end method'
    match = re.search(pattern, smali_content, re.DOTALL)

    if match:
        method_content = match.group(1)

        new_method_content = f".method {match.group(0)}\n{noi_dung_moi}\n.end method"
        
        smali_content = re.sub(pattern, new_method_content, smali_content, flags=re.DOTALL)

        with open(file_path, 'w', encoding='utf-8') as file:
            file.write(smali_content)

        print(f"Đã thay đổi nội dung của method '{ten_method}' thành công.")
    else:
        print(f"Không tìm thấy method '{ten_method}' trong file.")

ten_method = "parseTopSmartAppFromDb"
noi_dung_moi = """
    .registers 4
    
    return-void
"""
file_path = "test.smali"

thay_doi_method(file_path, ten_method, noi_dung_moi)
