#!/bin/bash

TMP=`mktemp -d`

cpp -nostdinc -I . -I ./include -I arch  -undef -x assembler-with-cpp $1 -o $1.preprocess

dtc -I dts -O dtb -p 0x1000 $1.preprocess -o $1.dtb


rm -fr $TMP
