import re
import argparse

def replace_method_content(file_path, method_name, new_content):
    with open(file_path, 'r') as file:
        data = file.read()
    
    method_pattern = re.compile(
        rf'\.method.* {method_name}\(.*\).*?\n(.*?)\n\.end method',
        re.DOTALL | re.MULTILINE
    )
    
    def replacement(match):
        return match.group(0).replace(match.group(1), new_content)

    new_data = method_pattern.sub(replacement, data)

    with open(file_path, 'w') as file:
        file.write(new_data)

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Replace method content in a file.')
    parser.add_argument('file_path', type=str, help='Path to the file to be modified')
    parser.add_argument('method_name', type=str, help='Name of the method to replace content')
    parser.add_argument('new_content', type=str, help='New content to replace in the method')

    args = parser.parse_args()

    replace_method_content(args.file_path, args.method_name, args.new_content)
