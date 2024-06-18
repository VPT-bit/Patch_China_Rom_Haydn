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
            if not method_found and re.match(r'\.method[^\n]*{}\(.*\)'.format(re.escape(method_name)), line):
                method_found = True
                output_lines.append(line)
            elif method_found:
                if line.strip().startswith('.register'):
                    output_lines.append(replacement_text)
                elif line.strip().startswith('.end method'):
                    output_lines.append(line)
                    method_found = False
                else:
                    continue
            else:
                output_lines.append(line)

        with open(file_path + '.new', 'w', encoding='utf-8') as file:
            file.writelines(output_lines)

        print(f'Đã thay thế nội dung của method {method_name} thành công.')
    
    except IOError:
        print(f'Không thể mở hoặc xử lý file {file_path}.')

if __name__ == "__main__":
    import sys

    if len(sys.argv) < 3:
        print("Usage: python script.py <file_path> <method_name>")
        sys.exit(1)

    file_path = sys.argv[2]
    method_name = sys.argv[1]

    replacement_text = (
        '\t.registers 4\n' +
        '\n\treturn-void\n' +
        '.end method\n'
    )

    replace_method_content(file_path, method_name, replacement_text)
