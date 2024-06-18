#!/usr/bin/env python3
# -*- coding: utf-8 -*-
def replace_method_content(file_path, method_name, new_content):
    try:
        # Đọc nội dung từ file smali
        with open(file_path, 'r', encoding='utf-8') as file:
            file_lines = file.readlines()
        
        # Biến cờ để đánh dấu khi tìm thấy method cần thay thế
        inside_method = False
        method_found = False
        new_file_lines = []

        for line in file_lines:
            if inside_method:
                if line.strip() == ".end method":
                    inside_method = False
                    new_file_lines.append(line)
                else:
                    # Bỏ qua nội dung cũ của method
                    continue
            else:
                if line.strip().startswith(".method "):
                    method_signature = line.strip().split()[-1]
                    if method_signature == method_name:
                        inside_method = True
                        method_found = True
                        # Thay thế nội dung mới của method
                        new_file_lines.append(line)  # Giữ lại dòng .method
                        new_file_lines.append(new_content)  # Thêm nội dung mới
                    else:
                        new_file_lines.append(line)
                else:
                    new_file_lines.append(line)

        if not method_found:
            print(f"Không tìm thấy method có tên '{method_name}' trong file.")
            return
        
        # Ghi lại nội dung mới vào file
        with open(file_path, 'w', encoding='utf-8') as file:
            file.writelines(new_file_lines)
        
        print(f"Đã thay thế nội dung của method '{method_name}' thành công.")

    except FileNotFoundError:
        print(f"File '{file_path}' không tồn tại.")
    except Exception as e:
        print(f"Lỗi xảy ra: {str(e)}")

# Sử dụng đoạn mã
file_path = "test.smali"  # Đường dẫn đến file smali cần thao tác
method_name = "parseTopSmartAppFromDb"  # Tên của method cần thay thế
new_content = """
    .locals 1
    const-string v0, "Hello, World!"
    return-object v0
.end method
"""  # Nội dung mới của method

replace_method_content(file_path, method_name, new_content)
