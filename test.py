#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys

def patch_method(file_name, method_name, new_code):
    with open(file_name, 'r') as file:
        data = file.readlines()

    with open(file_name, 'w') as file:
        in_method = False
        for line in data:
            if line.strip().startswith('.method ' + method_name):
                in_method = True
                file.write(line)
            elif in_method and line.strip().startswith('.end method'):
                in_method = False
                file.write(new_code)
                file.write('\n')
                file.write(line)
            elif in_method:
                continue
            else:
                file.write(line)

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python patch_method.py <file_name> <method_name> <new_code>")
    else:
        file_name = sys.argv[1]
        method_name = sys.argv[2]
        new_code = sys.argv[3]
        patch_method(file_name, method_name, new_code)
