i=$1

cd input-${i}

for j in {1..22}
do 
/net/snowwhite/home/sarahgag/pheweb-rg-test/sumher/ldak5.linux --cut-weights sumsect$j --bfile /net/sardinia/sarahgag/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.$j --extract $i.nonamb --exclude $i.exclude --chr $j
/net/snowwhite/home/sarahgag/pheweb-rg-test/sumher/ldak5.linux --calc-weights-all sumsect$j --bfile /net/sardinia/sarahgag/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.$j --extract $i.nonamb --exclude $i.exclude --chr $j
done

#Merge weightings across chromosomes
mkdir sumsect_${i}
cat sumsect{1..22}/weights.short > sumsect_${i}/weights.short

#create tagging file
/net/snowwhite/home/sarahgag/pheweb-rg-test/sumher/ldak5.linux --calc-tagging sumanns --bfile net/sardinia/sarahgag/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.$j --weights sumsect_${i}/weights.short --power -0.25 --extract ${i}.nonamb --exclude ${i}.exclude --window-cm 1 --annotation-number 24 --annotation-prefix ../test_annotations/ann_snps.

#regress test statistics onto taagging file
/net/snowwhite/home/sarahgag/pheweb-rg-test/sumher/ldak5.linux --sum-hers sumanns --tagfile sumanns.tagging --summary ${i}.txt --check-sums NO
