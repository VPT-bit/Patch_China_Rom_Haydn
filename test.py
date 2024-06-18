#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import re

# Hàm thay đổi nội dung của method
def change_method(file_path, method_name, new_content):
    with open(file_path, 'r') as file:
        content = file.read()
        pattern = r'\.method\s+(.*?)' + re.escape(method_name) + '\((.*?)\)\s*\n((?:.|\n)*?)\.end method'
        match = re.search(pattern, content, re.DOTALL)
        
        if match:
            old_method = match.group(0)
            new_method = '.method ' + match.group(1) + method_name + '(' + match.group(2) + ')\n' + new_content + '\n.end method'
            new_content = content.replace(old_method, new_method)
            
            with open(file_path, 'w') as file:
                file.write(new_content)
            return True
        else:
            return False

# Sử dụng hàm
file_path = 'test.smali'
method_name = 'parseTopSmartAppFromDb'
new_content = '''
    .registers 4
    
    return-void
'''

if change_method(file_path, method_name, new_content):
    print('Thay đổi nội dung của method thành công!')
else:
    print('Không tìm thấy method cần thay đổi')
