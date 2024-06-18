#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import re

def change_method_content(file_path, method_name, new_content):
    # Pattern to match method definition
    method_pattern = r'\.method [\w<>\/\[\];]+ {}\([\w<>\/\[\];]*\).*\n(.*\n)*?\.end method\n'.format(re.escape(method_name))

    # Read the content of the file
    with open(file_path, 'r', encoding='utf-8') as f:
        file_content = f.read()

    # Find the method based on the pattern
    match = re.search(method_pattern, file_content, re.DOTALL)

    if match:
        # Replace the old method content with new content
        updated_content = re.sub(method_pattern, match.group(0).split('\n')[0] + '\n' + new_content.strip() + '\n.end method\n', file_content)
        
        # Write the updated content back to the file
        with open(file_path, 'w', encoding='utf-8') as f:
            f.write(updated_content)
        
        print(f'Successfully updated method {method_name} in {file_path}')
    else:
        print(f'Method {method_name} not found in {file_path}')

# Example usage:
file_path = 'test.smali'
method_name = 'parseTopSmartAppFromDb'
new_method_content = '''
    .registers 4
    
    return-void
'''

change_method_content(file_path, method_name, new_method_content)
