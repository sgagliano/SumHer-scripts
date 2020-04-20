i=$i
cd input-${i} 

gunzip -c ../sumstats/${i}.txt.gz | awk '(NR>1){snp=$3;a1=$5;a2=$4;dir=$10;stat=($10/$11)^2;n=$8+$9}(NR==1){print "Predictor A1 A2 Direction Stat n"}(NR>1 && (a1=="A"||a1=="C"||a1=="G"||a1=="T") && (a2=="A"||a2=="C"||a2=="G"||a2=="T")){print snp, a1, a2, dir, stat, n}' > ${i}.txt


#i=AAO
gunzip -c ../sumstats/${i}.txt.gz | awk '(NR>1){snp=$3;a1=$4;a2=$5;dir=$10;stat=($10/$11)^2;n=17415}(NR==1){print "Predictor A1 A2 Direction Stat n"}(NR>1 && (a1=="a"||a1=="c"||a1=="g"||a1=="t") && (a2=="a"||a2=="c"||a2=="g"||a2=="t")){print snp, a1, a2, dir, stat, n}' > ${i}.txt

#i=PD
gunzip -c ../sumstats/${i}.txt.gz | awk '(NR>1){snp=$3;a1=$4;a2=$5;dir=$7;stat=($7/$8)^2;n=($10+$11)}(NR==1){print "Predictor A1 A2 Direction Stat n"}(NR>1 && (a1=="A"||a1=="C"||a1=="G"||a1=="T") && (a2=="A"||a2=="C"||a2=="G"||a2=="T")){print snp, a1, a2, dir, stat, n}' > ${i}.txt

#i=base_DEMENTIA_hg38, and the others
gunzip -c ../sumstats/${i}.txt.gz | awk '(NR>1){snp=$1;a1=$4;a2=$5;dir=$7;stat=($7/$8)^2;n=$10}(NR==1){print "Predictor A1 A2 Direction Stat n"}(NR>1 && (a1=="A"||a1=="C"||a1=="G"||a1=="T") && (a2=="A"||a2=="C"||a2=="G"||a2=="T")){print snp, a1, a2, dir, stat, n}' > ${i}.txt
