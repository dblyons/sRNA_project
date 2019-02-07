#!/bin/bash

echo
echo 'bam_to_bigwig.sh 1.normalization_factor  2:your_bam_file   3:output_file'
echo
start=$SECONDS


bedtools genomecov -bg -scale $1  -ibam $2 | perl -wnl -e '/^\d/ and print;' | perl -wpl -e 's/^/Chr/g;' > tmp1.bg

echo
echo 'converting to bigwig'
echo

bedGraphToBigWig tmp1.bg /old_home/dave/bsgenome_tair9.txt $3

echo 
echo 'removing tmp files'
echo 

rm tmp1.bg

duration=$(( SECONDS - start ))
echo 'elapsed time: '
echo $duration 'seconds'
echo

