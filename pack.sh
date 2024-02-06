#!/bin/bash
repack() {
  option=`sed -n '3p' ./config/$1_fs_options | cut -c28-`
  ./mkfs.erofs $option
  rm -rf $1/*
  mv $1_repack.img $1.img
}
repack "system"
repack "product"
repack "vendor"
