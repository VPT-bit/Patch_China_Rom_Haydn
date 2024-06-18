#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys

def replace_method_content(file_path, method_name, new_content):
    with open(file_path, 'r') as file:
        file_content = file.read()

    methods = file_content.split('.method')

    for i in range(1, len(methods)):
        method = methods[i]
        end_index = method.find('.end method')
        if end_index != -1:
            method_header = method[:end_index]
            method_name_start = method_header.find(method_name)
            if method_name_start != -1:
                method_start_index = method.find('\n', method_name_start) + 1
                method_end_index = end_index

                new_method_content = method[:method_start_index] + new_content + method[method_end_index:]
                methods[i] = new_method_content
                break

    new_file_content = '.method'.join(methods)

    with open(file_path, 'w') as file:
        file.write(new_file_content)

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("Usage: python script.py <file_path> <method_name_to_replace> <new_method_content>")
        sys.exit(1)

    file_path = sys.argv[1]
    method_name_to_replace = sys.argv[2]
    new_method_content = sys.argv[3]

    replace_method_content(file_path, method_name_to_replace, new_method_content)
