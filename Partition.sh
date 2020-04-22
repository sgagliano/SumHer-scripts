i=$1 #trait, e.g. PD, AD, or AOO
k=$2 #annot_directory
n=$3 #annotation number, e.g. 53

cd input-${i}
mkdir ${k}
cd ${k}

#create tagging file
#--annotation-number correpsonds to number of annotation files: ../../test_annotations/${k}/ann_snps.* ((--annotation-prefix)
sumher/ldak5.linux --calc-tagging sumanns --bfile 1000G_EUR_Phase3_plink/1000G.EUR.QC --weights ../sumsect_${i}/weights.short --power -0.25 --extract ../${i}.nonamb --exclude ../${i}.exclude --window-cm 1 --annotation-number ${n} --annotation-prefix ../../test_annotations/${k}/ann_snps.
#can only use --background YES when specifying "partitions"

#regress test statistics onto tagging file
sumher/ldak5.linux --sum-hers sumanns --tagfile sumanns.tagging --summary ../${i}.txt --check-sums NO
