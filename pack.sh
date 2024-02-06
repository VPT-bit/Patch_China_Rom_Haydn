#!/bin/bash
repack() {
  option=`sed -n '3p' ./config/$1_fs_options | cut -c28-`
  ./mkfs.erofs $option
  mv $1_repack.img $1.img
}
repack "system"
repack "product"
repack "vendor"
