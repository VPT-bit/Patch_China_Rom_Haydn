#!/bin/bash
extract() {
  ./extract.erofs -i ./$1.img -x
  rm $1.img
}
extract_avb() {
  ./vbmeta-disable-verification vbmeta.img
}
extract "system"
extract "product"
extract "vendor"
extract_avb
