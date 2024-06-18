#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import re

def replace_method_content(file_path, method_name, replacement_text):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            lines = file.readlines()

        output_lines = []
        method_found = False
        for line in lines:
            # Kiểm tra xem dòng hiện tại có phải là đầu của method cần thay thế không
            if not method_found and re.match(r'\.method[^\n]*{}\(.*\)'.format(re.escape(method_name)), line):
                method_found = True
                output_lines.append(line)
            elif method_found:
                # Nếu đã tìm thấy method, xử lý thay thế dòng .register và *** bằng replacement_text
                if line.strip().startswith('.register'):
                    output_lines.append(replacement_text)
                elif line.strip().startswith('.end method'):
                    output_lines.append(line)
                    method_found = False
                else:
                    continue
            else:
                output_lines.append(line)

        # Ghi kết quả vào file mới
        with open(file_path, 'w', encoding='utf-8') as file:
            file.writelines(output_lines)

        print(f'Đã thay thế nội dung của method {method_name} thành công.')
    
    except IOError:
        print(f'Không thể mở hoặc xử lý file {file_path}.')

# Sử dụng ví dụ:
file_path = 'test.txt'  # Đường dẫn đến file .smali
method_name = 'parseTopSmartAppFromDb'  # Tên của method cần thay thế
replacement_text = (
    '\t.register 4\n' +
    '\n\treturn-void\n' +
    '.end method\n'
)

replace_method_content(file_path, method_name, replacement_text)
