#!/bin/bash
dir=$(pwd)
get_file_dir()
{
	if [[ $1 ]]; then
		sudo find $dir/ -name $1 
	else 
		return 0
	fi
}


jar_util() 
{

	if [[ ! -d $dir/jar_temp ]]; then
		mkdir $dir/jar_temp
	fi

	#binary
	bak="java -jar $dir/bin/baksmali.jar d"
	sma="java -jar $dir/bin/smali.jar a"

	if [[ $1 == "d" ]]; then
		echo -ne "====> Patching $2 : "

		if [[ $(get_file_dir $2 ) ]]; then
			sudo mv $(get_file_dir $2 ) $dir/jar_temp
			sudo chown $(whoami) $dir/jar_temp/$2
			unzip $dir/jar_temp/$2 -d $dir/jar_temp/$2.out  >/dev/null 2>&1
			if [[ -d $dir/jar_temp/"$2.out" ]]; then
				rm -rf $dir/jar_temp/$2
				for dex in $(sudo find $dir/jar_temp/"$2.out" -maxdepth 1 -name "*dex" ); do
						if [[ $4 ]]; then
							if [[ "$dex" != *"$4"* && "$dex" != *"$5"* ]]; then
								$bak $dex -o "$dex.out"
								[[ -d "$dex.out" ]] && rm -rf $dex
							fi
						else
							$bak $dex -o "$dex.out"
							[[ -d "$dex.out" ]] && rm -rf $dex		
						fi

				done
			fi
		fi
	else 
		if [[ $1 == "a" ]]; then 
			if [[ -d $dir/jar_temp/$2.out ]]; then
				cd $dir/jar_temp/$2.out
				for fld in $(sudo find -maxdepth 1 -name "*.out" ); do
					if [[ $4 ]]; then
						if [[ "$fld" != *"$4"* && "$fld" != *"$5"* ]]; then
							echo $fld
							$sma $fld -o $(echo ${fld//.out})
							[[ -f $(echo ${fld//.out}) ]] && rm -rf $fld
						fi
					else 
						$sma $fld -o $(echo ${fld//.out})
						[[ -f $(echo ${fld//.out}) ]] && rm -rf $fld	
					fi
				done
				7za a -tzip -mx=0 $dir/jar_temp/$2_notal $dir/jar_temp/$2.out/. >/dev/null 2>&1
				#zip -r -j -0 $dir/jar_temp/$2_notal $dir/jar_temp/$2.out/.
				zipalign -p -v 4 $dir/jar_temp/$2_notal $dir/jar_temp/$2 >/dev/null 2>&1
				if [[ -f $dir/jar_temp/$2 ]]; then
					rm -rf $dir/jar_temp/$2.out $dir/jar_temp/$2_notal 
					#sudo cp -rf $dir/jar_temp/$2 $(get_file_dir $2) 
					echo "Succes"
				else
					echo "Fail"
				fi
			fi
		fi
	fi
}

patch_smali()
{
  filepath=$(find . -type f -name PowerKeeper.apk)
  cp $filepath $dir
  jar_util d "PowerKeeper.apk"
  for file_smali in $(find $dir/jar_temp/*.out -type f -name *.smali);
  do
    if grep -q "$1" "$file_smali"; then
    # Nếu chuỗi được tìm thấy, hiển thị đường dẫn của tệp
    echo "Tìm thấy chuỗi trong $file_smali"
    
    # Thực hiện thay thế chuỗi chỉ định bằng chuỗi khác
    sed -i "s/$1/$2/g" "$file_smali"

    echo "Đã thay thế '$1' bằng '$2' trong $file_smali"
    fi
  done
}

patch_smali "Lmiui/os/Build;->IS_INTERNATIONAL_BUILD:Z" "Lmiuix/os/Build;->IS_INTERNATIONAL_BUILD:Z"


  
