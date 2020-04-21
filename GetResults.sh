i=$1 #trait

#interested in annotation 53 called "Enrich_A53" from sumanns.enrich (output from Partition.sh)
#Summarize enrichment results for 34 genelists tested (E.g. genelist1 to genelist34) into a csv table

grep "Enrich_A53" input-${i}/genelist1/sumanns.enrich > results/${i}.txt
grep "Enrich_A53" input-${i}/genelist2/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist3/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist4/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist5/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist6/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist7/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist8/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist9/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist10/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist11/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist12/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist13/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist14/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist15/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist16/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist17/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist18/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist19/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist20/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist21/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist22/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist22/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist23/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist24/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist25/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist26/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist27/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist28/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist29/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist30/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist31/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist32/sumanns.enrich >> results/${i}.txt
grep "Enrich_A53" input-${i}/genelist33/sumanns.enrich >> results/${i}.txt
paste results/annotation.names results/${i}.txt > results/${i}.prep
perl -p -i -e 's/\t/ /g' results/${i}.prep
cat results/head.txt results/${i}.prep > results/${i}.csv
perl -p -i -e 's/ /,/g' results/${i}.csv
rm results/${i}.txt results/${i}.prep
