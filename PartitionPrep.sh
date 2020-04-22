#for j in {1..52}; do
#sumher/ldak5.linux --cut-genes test_annotations/ann$j --bfile 1000G_EUR_Phase3_plink/1000G.EUR.QC --genefile test_annotations/ann$j.genefile --ignore-weights YES
#mv test_annotations/ann$j/genes.predictors.used test_annotations/ann_snps.$j
#done

#The lists will be saved in ann_snps.1, ann_snps.2, ..., ann_snps.24

i=$1

cd input-${i}

for j in {1..22}
do 
sumher/ldak5.linux --cut-weights sumsect$j --bfile 1000G_EUR_Phase3_plink/1000G.EUR.QC.$j --extract $i.nonamb --exclude $i.exclude --chr $j
sumher/ldak5.linux --calc-weights-all sumsect$j --bfile 1000G_EUR_Phase3_plink/1000G.EUR.QC.$j --extract $i.nonamb --exclude $i.exclude --chr $j
done

#Merge weightings across chromosomes
mkdir sumsect_${i}
cat sumsect{1..22}/weights.short > sumsect_${i}/weights.short
