#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
from smali import Assembly
from smali import MethodDescriptor

def patch_method(smali_file, method_name, new_code):
    with open(smali_file, 'r', encoding='utf-8') as file:
        asm = Assembly(file)

    method = asm.get_method(method_name)
    if not method:
        print(f"Method '{method_name}' not found in '{smali_file}'")
        return False

    method.instructions.clear()
    method.instructions.append(new_code.strip())

    with open(smali_file, 'w', encoding='utf-8') as file:
        asm.write(file)

    return True

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print("Usage: python patch_method.py <smali_file> <method_name> <new_code>")
        sys.exit(1)

    smali_file = sys.argv[1]
    method_name = sys.argv[2]
    new_code = sys.argv[3]

    if patch_method(smali_file, method_name, new_code):
        print(f"Method '{method_name}' in '{smali_file}' patched successfully.")
    else:
        print(f"Failed to patch method '{method_name}' in '{smali_file}'.")
