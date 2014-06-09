#! /bin/bash

# download required .gmt files from MSigDB here:
# http://www.broadinstitute.org/gsea/downloads.jsp
# GSEA jar can be downloaded from same URL
MSIGDB="/path/to/MSigDB"
GSEA="/path/to/gsea2-2.0.14.jar"
# six command line arguments
# geneset to analyse (i.e. kegg) - only needs to be the variable bit of the name
# before the version etc. Common examples = kegg, bp, cc, mf etc
geneset=$1
# path (full or relative) to expression data in gct format
res=$2
# path to class file (sample classification)
cls=$3
# path to chip file (map probe ids to genes)
chip=$4
# label will be the name of the output
# (with some additional stuff like timestamp)
label=$5
# out is the directory in which to put the output
out=$6

#gets the full file name for the geneset file
gmx=$(find ${MSIGDB} -name \*${geneset}.v4.0.symbols.gmt)

# run GSEA - a number of default options are set
# permute: change to gene_set if rep number small
# sort: absolute ordering - alternative = real
java -cp ${GSEA} \
     -Xmx1024m xtools.gsea.Gsea \
     -res ${res} \
     -cls ${cls} \
     -gmx ${gmx} \
     -chip ${chip} \
     -collapse true \
     -mode Max_probe \
     -norm meandiv \
     -nperm 1000 \
     -permute phenotype \
     -rnd_type no_balance \
     -scoring_scheme weighted \
     -rpt_label ${label} \
     -metric Signal2Noise \
     -sort abs \
     -order descending \
     -include_only_symbols true \
     -make_sets true \
     -median false \
     -num 100 \
     -plot_top_x 20 \
     -rnd_seed timestamp \
     -save_rnd_lists false \
     -set_max 500 \
     -set_min 15 \
     -zip_report false \
     -out ${out} \
     -gui false
