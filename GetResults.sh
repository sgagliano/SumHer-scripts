i=$1 #trait

#interested in annotation 53 called "Enrich_A53" from sumanns.enrich (output from Partition.sh)
#Summarize enrichment results for 34 genelists tested (E.g. genelist1 to genelist34) into a csv table

for annot in `seq 1 34`
do
grep "Enrich_A53" input-${i}/genelist${annot}/sumanns.enrich >> results/${i}.txt
done

paste results/annotation.names results/${i}.txt > results/${i}.prep
perl -p -i -e 's/\t/ /g' results/${i}.prep
cat results/head.txt results/${i}.prep > results/${i}.csv
perl -p -i -e 's/ /,/g' results/${i}.csv
rm results/${i}.txt results/${i}.prep
