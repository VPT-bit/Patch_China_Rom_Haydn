import re
import argparse

def modify_smali_file(filename, method_name, new_content):
    with open(filename, 'r') as file:
        content = file.read()

    method_pattern = re.compile(r'(method\s+{}\s*\([^\)]*\)[^\s]*)\n((?:.|\n)*?)(\.end\s+method)'.format(re.escape(method_name)))
    
    def replace_method(match):
        method_signature = match.group(1)
        method_content = match.group(2)
        method_end = match.group(3)
        
        new_method = f"{method_signature}\n{new_content}\n{method_end}"
        return new_method

    modified_content = re.sub(method_pattern, replace_method, content)

    with open(filename, 'w') as file:
        file.write(modified_content)

def main():
    parser = argparse.ArgumentParser(description="Modify method content in a .smali file.")
    parser.add_argument('filename', type=str, help='Path to the .smali file')
    parser.add_argument('method_name', type=str, help='Name of the method to modify')
    parser.add_argument('new_content', type=str, help='New content to insert into the methods')

    args = parser.parse_args()
    
    modify_smali_file(args.filename, args.method_name, args.new_content)

if __name__ == "__main__":
    main()
