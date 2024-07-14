#!/bin/bash
git clone https://github.com/android/platform_art.git
cd platform_art/art/compiler/
g++ -o dex2oat64 dex2oat.cc
dex_path=$(find . -type f -name dex2oat64)
cp -f dex_path .
while getopts ":n:" opt; do
  case ${opt} in
    n )
      option=$OPTARG
      ;;
    \? )
      echo "Sử dụng: $0 -n <giá trị>"
      exit 1
      ;;
    : )
      echo "Tùy chọn -$OPTARG yêu cầu một đối số."
      exit 1
      ;;
  esac
done

case "$option" in
  "download" )
    axel -n $(nproc) $3
    ;;
  "optimize" )
    sudo bash dex2oat_complie-2.3.sh
    ;;
  * )
    echo "Nhãn không hợp lệ: $option"
    exit 1
    ;;
esac

exit 0
