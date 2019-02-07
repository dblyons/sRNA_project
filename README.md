# sRNA_project
small RNA collaboration with Jaemyung

dave's approach:

get sRNA fastqs

trim_galore (which uses cutadapt)

map with bowtie -v 1 -m 4 -S

convert sam to bam (samtools view -bS -h)

then use the wrapper "unsort_srna_bam_to_bg_and_bw.sh" from the same directory you have the other 2 scripts
(I know it's not pretty/elegant but works on my end, and at least serves as a beginning for us to harmonize our analysis)

  to use the script, enter your output file names as items 1-6 on the command line

output will be 

a. normalized w50 bigwig

b. normalized genomecov (unwindowed) bigwig
