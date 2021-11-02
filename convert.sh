#!/bin/bash

INPUT="$1"

if [ $# -lt 2 ]; then
    echo Usage:
    echo "	$0 <input> <type>"
    echo
    echo "		input - input image"
    echo "		type  - partition type. supported: haos, armbian"
    exit
fi

TMP=`mktemp -d`

EXT="${INPUT:${#INPUT}-3:3}"
if [[ ".xz" == "${EXT}" ]]; then
    INPUT="${INPUT::-3}"
    echo unzip "$INPUT$EXT"
    xzcat "$INPUT$EXT" >"$INPUT"
fi


#LOOP="$(sudo losetup -f)"

#echo Mount loop device "$LOOP"

#sudo losetup "$LOOP" "$INPUT"

#sudo losetup -d "$LOOP"


cpp -nostdinc -I . -I ./include -I arch  -undef -x assembler-with-cpp $1 -o $1.preprocess

dtc -I dts -O dtb -p 0x1000 $1.preprocess -o $1.dtb


rm -fr $TMP
