#!/usr/bin/env python3
# -*- coding: utf-8 -*-
def replace_method_content(file_path, method_name, new_content):
    # Đọc nội dung của file smali
    with open(file_path, 'r') as file:
        file_content = file.read()

    # Tách các method bằng cách tìm từ khóa '.method'
    methods = file_content.split('.method')

    # Tìm method cần thay thế
    for i in range(1, len(methods)):  # bắt đầu từ 1 vì methods[0] là phần trước từ khóa đầu tiên
        method = methods[i]
        # Tìm dấu kết thúc method
        end_index = method.find('.end method')
        if end_index != -1:
            # Lấy tên của method từ ".method" đến kí tự đầu tiên là khoảng trắng
            method_header = method[:end_index]
            method_name_start = method_header.find(method_name)
            if method_name_start != -1:
                # Tìm thấy method cần thay thế
                # Tìm vị trí bắt đầu và kết thúc của nội dung method (giữa .method và .end method)
                method_start_index = method.find('\n', method_name_start) + 1
                method_end_index = end_index

                # Thay thế nội dung trong method này
                new_method_content = method[:method_start_index] + new_content + method[method_end_index:]
                methods[i] = new_method_content
                break

    # Ghép lại nội dung file
    new_file_content = '.method'.join(methods)

    # Ghi lại vào file
    with open(file_path, 'w') as file:
        file.write(new_file_content)

# Sử dụng hàm replace_method_content để thay đổi nội dung của method trong file test.smali
file_path = 'test.smali'
method_name_to_replace = 'displayControl'
new_method_content = '''
    .registers 4

    return-void
'''

replace_method_content(file_path, method_name_to_replace, new_method_content)
