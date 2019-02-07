#!/bin/bash

#
echo
echo "./unsorted_srna_bam.....sh   1.)srna_bam  2.)sorted_bam  3.)24nt bam  4.)bg w50  5.)bw w50  6.)genomecov bw  "
echo

#sorted bam out
samtools sort $1 > $2
#samtools rmdup $2 $3

#get number of mapped 18-27nt
mapped_reads=`samtools view -F 4  $2 |  perl -nla -e '$F[5]=~/(18M|19M|20M|21M|22M|23M|24M|25M|26M|27M)/ and print $_;' | wc -l`

echo
echo mapped 18-27nt reads in sample $1:
echo	$mapped_reads
echo


#24nt bam out
samtools view -h $2 | awk '$6 ~ /24M/ || $1 ~ /^@/' | samtools view -bS - > $3
#could add 21nt selection here too if you want

#produce w50 of sRNA and normalize to number mapped reads
###
###  need an appropriately named w50 file for -a  (not provided) 
###  I made this one with bedtools makewindows -w 50 -s 50, with the tair10 genome sizes file as -g
###
bedtools intersect -c -a w50.s50.nochr.bed -b $3 > tmp.bg

#add this script to your working directory and `chmod +x` it
./normalize_bedgraph.py $mapped_reads tmp.bg > $4

#these next 2 steps are needed to enable loading into my version of seqplots :-<
perl -wpl -i.bak -e 's/^/Chr/g;' $4
perl -wnl -i.bak -e '/Chr\d/ and print;' $4

#optional if you have bedgraph_to_bigwig available in your env
bedGraphToBigWig $4 /old_home/dave/bsgenome_tair9.txt $5

#rpm normalization
norm_factor=`echo 1/\($mapped_reads/1000000\)|bc -l`
echo $norm_factor

#separately convert to non-windowed normalized bigwig using bedtools genomecov shell script
##add this script to your working directory and `chmod +x` it
./bam_to_bigwig.sh $norm_factor $3 $6

rm tmp.bg
