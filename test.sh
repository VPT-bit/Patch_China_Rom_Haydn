#!/bin/bash

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
    axel -n $(nproc) $2
    ;;
  "nhant2" )
    echo "Bạn đã chọn nhãn 2"
    ;;
  * )
    echo "Nhãn không hợp lệ: $option"
    exit 1
    ;;
esac

exit 0
