#Prepare MHC SNPs from 1000G EUR ref
#awk < /net/sardinia/sarahgag/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC.6.bim '($1==6 && $4>25000000 && $4<34000000){print $2}'> mhc.snps

cd input-${i}

###PREPARE EACH TRAIT
#First format the summary statistics
#Follow FormatSumstats.sh
#Check for and remove duplicates;
awk < ${i}.txt '{print $1}' | sort | uniq -d | head
mv ${i}.txt ${i}v2.txt
awk '!seen[$1]++' ${i}v2.txt > ${i}.txt
#To identify the non-ambiguous predictors, use
awk < ${i}.txt '( ($2=="A"&&$3=="C") || ($2=="A"&&$3=="G") || ($2=="C"&&$3=="A") || ($2=="C"&&$3=="T") || ($2=="G"&&$3=="A") || ($2=="G"&&$3=="T") || ($2=="T"&&$3=="C") || ($2=="T"&&$3=="G") ){print $1}' > ${i}.nonamb
#To identify predictors inside the MHC, and those which individually explain >1% of phenotypic variance, or are in LD with predictor that is
#i.e. `$5 / ($5 + $6) > 1 / 100` =>  `$5 * 100 > $5 + $6`  => `$5 * 99 > $6` => `$5 > $6 / 99`
awk < ${i}.txt '(NR>1 && $5>$6/99){print $1}' > ${i}.big
#if big is empty, omit next line, cp big to out, and run last line
../../../sumher/ldak5.linux --remove-tags ${i} --bfile /net/sardinia/sarahgag/LDSC/1000G_EUR_Phase3_plink/1000G.EUR.QC --top-preds ${i}.big --window-cm 1 --min-cor .1
cat ../mhc.snps ${i}.out > ${i}.exclude
