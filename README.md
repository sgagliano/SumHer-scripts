# SumHer-scripts

Pipeline to estimate ```heritability enrichment``` for overlapping "annotations" using summary statistics via SumHer (http://dougspeed.com/sumher/)


1. FormatSumstats.sh
2. Fileprep.sh
3. Heritability.sh
4. PartitionPrep.sh
5. Partition.sh
6. GetResults.sh

For massively-parallel estimation of ```genetic correlations``` using SumHer for binary traits see https://github.com/statgen/pheweb-rg-pipeline

#### Directory structure

main_directory/<br/>
  --> Fileprep.sh<br/>
  --> Heritability.sh<br/>
  --> PartitionPrep.sh<br/>
  --> Partition.sh<br/>
  --> GetResults.sh<br/>
  --> input-{i}/ #i is trait name<br/>
  --> test_annotations/<br/>
    --> genelist{1..k}/ #one directory for each test<br/>
      --> --> annot{1..n}.genefile #e.g. baseline annotations: annot1.genefile, annot2.genefile ..., plus annotation annot{n}.genefile<br/>
  --> susmstats/<br/>
    --> --> {i}.txt.gz #i is trait name<br/>
  --> sumher/<br/>
    --> --> ldak5.linux<br/>
  --> 1000G_EUR_Phase3_plink/<br/>
    --> --> 1000G.EUR.QC.{bed,bim,fam} #chr1-22 merged<br/>
    --> --> 1000G.EUR.QC.{1..22}.{bed,bim,fam}<br/>
  --> results/<br/>
  --> --> annotation.names/<br/> #1 column listing ordered annotation names corresponding to genelist1, genelist2 ..., 1 per line
