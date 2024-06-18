#!/usr/bin/env python3
# -*- coding: utf-8 -*-
def change_method_content(file_path, method_name, new_content):
    # Read the content of the file
    with open(file_path, 'r', encoding='utf-8') as f:
        file_content = f.read()

    # Locate the beginning and ending positions of the method
    method_start_pattern = f'.method .* {method_name}(\(.*\))?\n'
    method_end_pattern = '.end method\n'

    start_match = re.search(method_start_pattern, file_content)
    end_match = re.search(method_end_pattern, file_content)

    if start_match and end_match:
        start_pos = start_match.start()
        end_pos = end_match.end()

        # Construct the updated content with new method body
        updated_content = file_content[:start_pos] + start_match.group(0)
        updated_content += new_content.strip() + '\n'
        updated_content += file_content[end_pos:]

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
    const v0, 123
    return v0
'''

change_method_content(file_path, method_name, new_method_content)
