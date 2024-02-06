#!/bin/bash

#   grep size of images

system_size=`stat -c '%n %s' system.img | cut -d ' ' -f 2`
system_ext_size=`stat -c '%n %s' system_ext.img | cut -d ' ' -f 2`
product_size=`stat -c '%n %s' product.img | cut -d ' ' -f 2`
vendor_size=`stat -c '%n %s' vendor.img | cut -d ' ' -f 2`
odm_size=`stat -c '%n %s' odm.img | cut -d ' ' -f 2`
mi_ext_size=`stat -c '%n %s' mi_ext.img | cut -d ' ' -f 2`
sum_size=`echo "$system_size + $system_ext_size + $product_size + $vendor_size + $odm_size + $mi_ext_size" | bc`

#   run lpmake to build super.img

command="--metadata-size 65536 --super-name super --metadata-slots 3 --device super:9126805504 --group qti_dynamic_partitions_a:$sum_size --partition product_a:readonly:$product_size:qti_dynamic_partitions_a --image product_a=./product.img --partition system_a:readonly:$system_size:qti_dynamic_partitions_a --image system_a=./system.img --partition system_ext_a:readonly:$system_ext_size:qti_dynamic_partitions_a --image system_ext_a=./system_ext.img --partition vendor_a:readonly:$vendor_size:qti_dynamic_partitions_a --image vendor_a=./vendor.img --partition odm_a:readonly:$odm_size:qti_dynamic_partitions_a --image odm_a=./odm.img --partition mi_ext_a:readonly:$mi_ext_size:qti_dynamic_partitions_a --image mi_ext_a=./mi_ext.img --group qti_dynamic_partitions_b:0 --partition product_b:readonly:0:qti_dynamic_partitions_b --partition system_b:readonly:0:qti_dynamic_partitions_b --partition system_ext_b:readonly:0:qti_dynamic_partitions_b --partition vendor_b:readonly:0:qti_dynamic_partitions_b --partition odm_b:readonly:0:qti_dynamic_partitions_b --partition mi_ext_b:readonly:0:qti_dynamic_partitions_b --virtual-ab --output ./super"
./lpmake $command

if test ./super; then
   echo       file SUPER created successfully!
fi
#    compress super => super.zst

zstd super -o super.zst
rm super

#    check if super.zst exist

if test ./super.zst; then
   echo       file SUPER.ZST created successfully!
fi

#    remove source file image

for part in product system system_ext vendor odm mi_ext
do
  rm $part.img
done
