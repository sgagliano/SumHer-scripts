i=$1 #trait

#summarize sumanns.enrich and sumanns.share outputs across annotations (34 in this case, see below) into a single CSV file per trait

#code is hard-coded to the following:
#interested in annotation 53 called "Enrich_A53" from sumanns.enrich and "Share_A53" from sumanns.share (outputs from Partition.sh)
#34 genelists tested (E.g. genelist1 to genelist34)

echo 'Annot Component Share SD Expected Enrichment SD' > results/head-enrich.txt
echo 'Component Share SD Expected Influence SD' > results/head-share.txt

for annot in `seq 1 34`
do
grep "Enrich_A53" input-${i}/genelist${annot}/sumanns.enrich >> results/${i}.enrich
done
paste results/annotation.names results/${i}.enrich > results/${i}.enrich.prep
perl -p -i -e 's/\t/ /g' results/${i}.enrich.prep
cat results/head-enrich.txt results/${i}.enrich.prep > results/${i}.enrich.csv

for annot in `seq 1 34`
do
grep "Share_A53" input-${i}/genelist${annot}/sumanns.share >> results/${i}.share
done
perl -p -i -e 's/\t/ /g' results/${i}.share
cat results/head-share.txt results/${i}.share > results/${i}.share.csv

paste results/${i}.enrich.csv results/${i}.share.csv > results/${i}.csv
perl -p -i -e 's/\t/ /g' results/${i}.csv
perl -p -i -e 's/ /,/g' results/${i}.csv
rm results/${i}.enrich results/${i}.share results/${i}.enrich.csv results/${i}.share.csv results/${i}.*.prep
