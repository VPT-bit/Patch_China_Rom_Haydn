
import re
import sys

def replace_method_content(file_path, method_name, new_content):
    with open(file_path, 'r') as f:
        file_content = f.read()

    method_pattern = re.compile(r'\.method <.*> ' + re.escape(method_name) + r'\(.*\)(.|\n)*?\.end method')
    method_matches = method_pattern.findall(file_content)

    modified_content = file_content
    for method_match in method_matches:
        modified_content = modified_content.replace(method_match, new_content)

    with open(file_path, 'w') as f:
        f.write(modified_content)

if __name__ == "__main__":
    file_smali = sys.argv[1]
    ten_method_can_tim = sys.argv[2]
    noi_dung_moi = sys.argv[3]
    replace_method_content(file_smali, ten_method_can_tim, noi_dung_moi)
