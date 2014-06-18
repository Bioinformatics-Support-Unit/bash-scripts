sed -n '1~4p' stranded_mix.fastq | grep '/1$'| grep -A 3 --no-group-separator -F -x -f - stranded_mix.fastq > stranded_mix_1.fastq
sed -n '1~4p' stranded_mix.fastq | grep '/2$'| grep -A 3 --no-group-separator -F -x -f - stranded_mix.fastq > stranded_mix_2.fastq
