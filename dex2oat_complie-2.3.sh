#!/bin/bash

print() { echo -e "$@"; }

dex2oat() {
    file_dir="./oat/arm64/${file_n%.*}"
    mkdir -p ./oat/arm64
    rm -rf $file_dir.art $file_dir.odex $file_dir.vdex
    print "\nStarting compilation of file $file_n"
    dex2oat --dex-file=./$file_n --compiler-filter=everything --instruction-set=arm64 --dex-location=./$file_n --app-image-file=$file_dir.art --cpu-set=0,1,2,3,4,5,6,7 --oat-file=$file_dir.odex
    print "Compilation of file $file_n completed"
}

rm_sh() {
    rm -rf "${0}" #Delete this script
}

hello() {
    file=$(ls *.jar *.apk 2>/dev/null)
    clear
    print "\nFile source: https://github.com/Weverses/FixNFC\n
------------------------------------------
--                                      --
--          Modified by:@YFTree_Meow    --
--         Shared by @cazymods          --
--                                      --
------------------------------------------
Files in this directory:

$file

Please place the files to be compiled in the same directory beforehand.
Now enter the full file name 
(or press Enter to use all the files in this directory):"
}

start() {
    input="PowerKeeper.apk"
    if [ -z "$input" ]; then
        for file_n in $file; do
            dex2oat
        done
    else
        file_n=$input
        if [ ! -f ./$file_n ]; then
            hello
            print "\nFile not found: $file_n\nPlease check if the input is correct and enter again:"
            start
        else
            dex2oat
        fi
    fi
}

hello
start
#rm_sh
