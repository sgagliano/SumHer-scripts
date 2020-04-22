##CODE WRITTEN BY REGINA H. REYNOLDS: https://github.com/RHReynolds##
##visualize .enrich output (Share/Share_SD and Enrichment/Enrichment_SD) and .share output (Share/Share_SD and Influence/Influence_SD)

library('magrittr')
library('stringr')
library('tidyverse')
library('ggpubr')

#file paths to the .csv output files
file_paths <- list.files(path = "results/",
                         pattern = ".csv",
                         full.names = T)

results <- setNames(vector(mode = "list", length = 2),
                    c("enrich", "share")) 

for(i in 1:length(file_paths)){
  
    GWAS <- file_paths[[i]] %>% 
      str_replace(".*/", "") %>% 
      str_replace("\\.csv", "")
    
#csv files are called PD.csv, AAO.csv and AD.csv; specify the headers in the plot
    file <- read_csv(file_paths[[i]]) %>% 
      dplyr::mutate(GWAS = case_when(GWAS == "PD" ~ "PD2019_ex23andMe",
                                     GWAS == "AAO" ~ "PD2018_AOO",
				     GWAS == "AD" ~ "AD2019",
                                     TRUE ~ GWAS)) %>% 
      tidyr::separate(Annot, into = c("comparison", "cell_type"), sep = ":") #first column (Annot) is in format comparison:celltype    
    
    enrich <- file %>% 
      dplyr::select(GWAS, comparison, cell_type, Component, Share, Share_SD = SD, Expected, Enrichment, Enrichment_SD = SD_1)
    
    share <- file %>% 
      dplyr::select(GWAS, comparison, cell_type, Component = Component_1, Share = Share_1, Share_SD = SD_2, Expected = Expected_1, Influence, Influence_SD = SD_3)
    
    if(i == 1){
      
      results[["enrich"]] <- enrich
      results[["share"]] <- share
      
    } else{
      
      results[["enrich"]] <- results[["enrich"]] %>% 
        dplyr::bind_rows(enrich)
      results[["share"]] <- results[["share"]] %>% 
        dplyr::bind_rows(share)
      
    }

}


# Create plotting function
plot_function <- function(df, x, y, fill, sd){
  
  arg <- match.call()
  
  p <- ggplot(df, aes(x = fct_rev(eval(arg$x)),
                      y = eval(arg$y),
                      fill = eval(arg$fill)))
  
  p + geom_bar(aes(fill = direction),
               stat = "identity", 
               color = "black", 
               position = position_dodge()) +
    geom_errorbar(aes(ymin = eval(arg$y)-eval(arg$sd), 
                      ymax = eval(arg$y)+eval(arg$sd)), 
                  width = 0.2, position = position_dodge(0.9)) +
    facet_grid(comparison ~ GWAS, scales = "free_y", space = "free_y") +
    labs(x = as.character(arg$x), y = as.character(arg$y)) +
    #theme_rhr +
    theme(strip.text.y = element_text(angle = 0)) +
    scale_fill_discrete(name = as.character(arg$fill)) +
    coord_flip()

}

##PLOT RESULTS FROM .enrich OUTPUT
#six "comparisons" in this dataset: first six rows in comparison (and then repeats for the cell_types):
#c("Control_vs_PD", "Control_vs_PDD", "Control_vs_DLB", "PD_vs_PDD", "PD_vs_DLB", "PDD_vs_DLB")  
#use in plotting function below; modify as needed for other datasets
png('visualize/enrich.png', width=8, height=11, unit="in", res=1000)
a <- 
  results$enrich %>% 
  dplyr::mutate(comparison = fct_relevel(comparison,
                                         c("Control_vs_PD", "Control_vs_PDD", "Control_vs_DLB", "PD_vs_PDD", "PD_vs_DLB", "PDD_vs_DLB")),
                direction = case_when(Share >= 0 ~ "positive",
                                      Share < 0 ~ "negative")) %>% 
  plot_function(., x = cell_type, y = Share, fill = direction, sd = Share_SD)


b <- 
  results$enrich %>% 
  dplyr::mutate(comparison = fct_relevel(comparison,
                                         c("Control_vs_PD", "Control_vs_PDD", "Control_vs_DLB", "PD_vs_PDD", "PD_vs_DLB", "PDD_vs_DLB")),
                direction = case_when(Enrichment >= 0 ~ "positive",
                                      Enrichment < 0 ~ "negative")) %>% 
  plot_function(., x = cell_type, y = Enrichment, fill = direction, sd = Enrichment_SD)

ggarrange(a, b,
          labels = c("a", "b"),
          ncol = 1,
          common.legend = TRUE)


dev.off()

##PLOT RESULTS FROM .share OUTPUT
png('visualize/share.png', width=8, height=11, unit="in", res=1000)
a <- 
  results$share %>% 
  dplyr::mutate(comparison = fct_relevel(comparison,
                                         c("Control_vs_PD", "Control_vs_PDD", "Control_vs_DLB", "PD_vs_PDD", "PD_vs_DLB", "PDD_vs_DLB")),
                direction = case_when(Share >= 0 ~ "positive",
                                      Share < 0 ~ "negative")) %>% 
  plot_function(., x = cell_type, y = Share, fill = direction, sd = Share_SD)


b <- 
  results$share %>% 
  dplyr::mutate(comparison = fct_relevel(comparison,
                                         c("Control_vs_PD", "Control_vs_PDD", "Control_vs_DLB", "PD_vs_PDD", "PD_vs_DLB", "PDD_vs_DLB")),
                direction = case_when(Influence >= 0 ~ "positive",
                                      Influence < 0 ~ "negative")) %>% 
  plot_function(., x = cell_type, y = Influence, fill = direction, sd = Influence_SD)

ggarrange(a, b,
          labels = c("a", "b"),
          ncol = 1,
          common.legend = TRUE)

dev.off()
