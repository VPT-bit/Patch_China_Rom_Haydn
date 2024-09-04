import re
import sys

def find_and_modify_method(file_path, method_name, new_content):
    with open(file_path, 'r') as file:
        content = file.read()

    method_pattern = re.compile(r'(.*?)(\.method\s+' + re.escape(method_name) + r'(.*?))(\.end\s+method)', re.DOTALL)

    match = method_pattern.search(content)
    if match:
        before_method = match.group(1)
        method_start = match.group(2)
        method_body = match.group(3)
        method_end = match.group(4)

        modified_method = method_start + new_content + method_end

        new_content = before_method + modified_method

        with open(file_path, 'w') as file:
            file.write(new_content)
        print("Method has been successfully modified.")
    else:
        print("Method not found.")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python script.py <file_path> <method_name> <new_content>")
        sys.exit(1)

    file_path = sys.argv[1]
    method_name = sys.argv[2]
    new_content = sys.argv[3]

    find_and_modify_method(file_path, method_name, new_content)
