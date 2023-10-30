---
title: "Hotspot R analysis"
output: html_notebook
---

#This is an [R Markdown](http://rmarkdown.rstudio.com) Notebook. 
#When you execute code within the notebook, the results appear beneath the code. 

#Try executing this chunk by clicking the *Run* button within the 
#chunk or by placing your cursor inside it and pressing *Ctrl+Shift+Enter*. 

#import packages (probably not all of these are necessary? 
#but at this point i don't know which those are...)


# R script to install required packages
required_packages <- c(
  "BiocManager", "ComplexHeatmap", "ComplexHeatmap", "cowplot",
  "corrplot", "corrr", "dplyr", "FactoMineR", "ggcorrplot",
  "ggplot2", "ggpubr", "gridExtra", "Hmisc", "ivmte",
  "palettetown", "pheatmap", "reshape2", "RColorBrewer", "svMisc",
  "stringr", "tidyr", "viridis", "Seurat"
)

# Check if each package is already installed, if not, install it
for (package in required_packages) {
  if (!require(package, character.only = TRUE)) {
    install.packages(package)
  }
}

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("ComplexHeatmap")

```{r}
suppressPackageStartupMessages(library("Seurat"))
suppressPackageStartupMessages(library("dplyr"))
suppressPackageStartupMessages(library("tidyr"))
suppressPackageStartupMessages(library("svMisc"))
suppressPackageStartupMessages(library("cowplot"))
suppressPackageStartupMessages(library("ggplot2"))
suppressPackageStartupMessages(library("pheatmap"))
suppressPackageStartupMessages(library("reshape2"))
suppressPackageStartupMessages(library("gridExtra"))
suppressPackageStartupMessages(library("RColorBrewer"))
suppressPackageStartupMessages(library("ivmte"))
suppressPackageStartupMessages(library("viridis"))
suppressPackageStartupMessages(library("palettetown"))
suppressPackageStartupMessages(library("ComplexHeatmap"))
suppressPackageStartupMessages(library(corrplot))
suppressPackageStartupMessages(library(Hmisc))
suppressPackageStartupMessages(library('corrr'))
suppressPackageStartupMessages(library(ggcorrplot))
suppressPackageStartupMessages(library("FactoMineR"))
suppressPackageStartupMessages(library(stringr))
suppressPackageStartupMessages(library(ggpubr))
suppressPackageStartupMessages(library(ComplexHeatmap))
```

import module data and metadata
```{r}
#all_cells <- read.csv("G:/My Drive/pateiv/seq_analysis/snseq_analysis/Hotspot/new_clusts_noTrh/ani_mod_scores_allcells.csv")

metadata <- read.csv("seq_beh_metadata.csv")
metadata$Group <- paste(metadata$sex, metadata$SS_OS, sep = "_")

read_csv_files <- function(data_file, metadata_file) {
  all_cells <- read.csv(data_file)
  metadata <- read.csv(metadata_file)
  
  return(list(all_cells = all_cells, metadata = metadata))
}

process_metadata <- function(metadata) {
  metadata$Group <- paste(metadata$sex, metadata$SS_OS, sep = "_")
  return(metadata)
}

#USAGE
data_files <- read_csv_files("ani_mod_scores_allcells.csv", "seq_beh_metadata.csv")
metadata <- process_metadata(data_files$metadata)
all_cells <- data_files$all_cells
```
merge meta and module data
```{r}
data <- merge(all_cells, metadata, on = "animal")

merged_dataframes <- function(df1, df2, common_column) {
  merged_data <- merge(df1, df2, by.x = common_column, by.y = common_column)
  return(merged_data)
}

#USAGE
merged_data <- merged_dataframes(all_cells, metadata, "animal")
```
import seurat object
```{r}
#SCT_norm <- readRDS("G:/My Drive/pateiv/seq_analysis/swe4s_seq_analysis/SCT_norm_clustnames_swe4s.rds")

read_rds_file <- function(file_path) {
  data <- readRDS(file_path)
  return(data)
}

#USAGE
#SCT_norm <- read_rds_file()
```

violin plots of module scores
```{r}
#setwd("G:/My Drive/pateiv/seq_analysis/swe4s_seq_analysis/hotspot_r/")

set_working_directory <- function(directory_path) {
  setwd(directory_path)
  cat("Working directory set to:", getwd(), "\n")
}

#USAGE
set_working_directory()

#my_comparisons <- list(c("F_SS", "F_OS"), c("M_SS", "M_OS"), 
#c("F_SS", "M_SS"), c("F_OS", "M_OS"))

set_column_comparisons <- function(groups, sexes) {
  comparisons <- list()
  for (sex in sexes) {
    for (group in groups) {
      comparisons <- c(comparisons, list(c(paste0(sex, "_SS"), paste0(sex,
                                                                     "_OS"))))
    }
  }
  return(comparisons)
}

#USAGE
groups <- c("F", "M")
sexes <- c("F", "M")

all_comparisons <- set_column_comparisons(groups, sexes)

#data$Group <- factor(data$Group, levels = c("F_SS", "F_OS", "M_SS", "M_OS"))

set_factor_variables <- function(dataset, chosen_column, levels_vector) {
  data[[column_name]] <- factor(data[[column_name]], levels = levels_vector)
  return(data)
}

#USAGE
data <- data.frame(
  Group = c("F_SS", "F_OS", "M_SS", "M_OS"),
  Rank = c(1, 2, 3, 4, 5)
)

levels_vector <- c("F_SS", "F_OS", "M_SS", "M_OS")

data <- set_factor_variables(data, "Group", levels_vector)

## group.levels = c("F_SS", "F_OS", "M_SS", "M_OS")

#mods <- colnames(data)[2:24]

generate_colnames <- function(dataset, first_column, last_column) {
  data_columns <- colnames(dataset)[first_column:last_column]
  return(data_columns)
}

#USAGE
mods <- generate_colnames(data, 2, 24)

## ggplot(data, aes(x = Group, y = Module.1)) + geom_violin() + geom_point()

#move functions into separate file
violin <- function(x) {
  #print(x)
   plt <- ggplot(data, aes_string(x = "Group", y = x, color = "Group", 
     fill = "Group", alpha = 0.8)) + 
     geom_violin(lwd = 0.5) + 
     geom_point(position = position_dodge(width = 0.75), 
     color = "slategrey", size = 2, alpha = 1) +
     stat_compare_means(comparisons = my_comparisons, 
                        paired = FALSE, method = "wilcox.test") + 

     #OG colors
  scale_fill_manual(values = c("F_SS" = "mediumpurple",
                                "F_OS"="darkorchid4",
                                "M_SS"="lightseagreen",
                                "M_OS"="deepskyblue4")) +
  scale_color_manual(values = c("F_SS" = "mediumpurple",
                                "F_OS"="darkorchid4",
                                "M_SS"="lightseagreen",
                                "M_OS"="deepskyblue4")) +
     

  ylab("Module Score") +
  ggtitle(x) +
  theme_classic() +
  theme(text = element_text(size = 40))
  print(plt)
  
  ggsave(paste(x, "_violin.png"), plt, bg = "white", height = 8, width = 10, 
         units = "in", device = "png")
}

lapply(mods, violin)
```
spearman correlation per module between partners
compare partners
```{r}

#setwd("G:/My Drive/pateiv/seq_analysis/swe4s_seq_analysis/hotspot_r/")
set_working_directory()

pairs <- function(dataset, metadataset, column1, column2, column3, 
                  column4, merge_on) {
  paired <- merge(all_cells, metadata[c('column1', 'column2)', 'column3', 
                                        'column4')], on = "merge_on")
  return(paired)
}
#USAGE
pair_dat <- pairs(all_cells, metadata, animal, pair, 
                  LT_phuddle, ST_phuddle, animal)
#pair_dat <- merge(all_cells, metadata[c('animal', 'pair', 'LT_phuddle', 
                                        #'ST_phuddle')], on ="animal")

# cor_df <- merge(all_cells, metadata[c('animal', 'LT_phuddle', 
#'ST_phuddle')], on ="animal")
#cor_df <- pair_dat %>% subset(columns = -c('animal'))

core_dataframe <- function(dataset, column) {
  core <- dataset %>% subset(columns = -c('column'))
  return(core)
}

cor_df <- core_dataframe(pair_dat, animal)

pair_dat <- core_dataframe(cor_df, animal)
#pair_dat <- cor_df %>% subset(columns = -c('animal'))

#set up df to hold correlation p-values
correlation_signif <- data.frame(Module = character(), pval = numeric())

#the only two modules that are significant are mod.6 and mod.11. 
#i used deeppink4 as color for mod.6 and chartreuse4 for mod.11
for (mod in mods) {
  print(mod)
  data_wide <- tidyr::pivot_wider(data, id_cols = "pair", 
                                  names_from = "color", values_from=mod) 
  #mod 10 is correlated btwn partners

  cor <- rcorr(data_wide$O, data_wide$B, type = "spearman") 
  #, use="complete.obs"
  print(cor$r[2])
  print(cor$P[2])
  
  lab <- paste("R = ", round(cor$r[2], digits = 4), 
               " p = ", round(cor$P[2], digits = 4), sep = "")
  p <- paste("p = ", cor$P[2])
  
  p <- ggplot(data_wide, aes(x = O, y = B, label = pair)) + 
    geom_point() + 
    xlab("Partner 1") +
    ylab("Partner 2") +
    geom_smooth(method = "lm", color = "deeppink4", fill = "deeppink4") + 
    #deeppink4 for Mod6, chartreuse4 for Mod11
    ggtitle(paste("correlation between partners ", mod, " ", lab)) +
    theme_classic()
  print(p)
  ggsave(paste(mod, "partner_corr.png"), p, bg = "white")
  
  corr_signif_mini <- data.frame(Module = mod, pval = cor$P[2])
  correlation_signif <- rbind(correlation_signif, corr_signif_mini)
}

correlation_signif$test <- "Spearman_Correlation"
```

RANK-BASED DISTANCE BETWEEN PARTNERS
here i am comparing the rank-distance between partners 
compared to what's expected by chance (13)
```{r}
#setwd("G:/My Drive/pateiv/seq_analysis/swe4s_seq_analysis/hotspot_r/")

set_working_directory()

#mods <- colnames(data)[2:24]

mods <- generate_colnames(data, 2, 24)

unique_pairs <- function(dataset, pairset, exclusion) {
  pairs1 <- unique(dataset$pairset)
  pairs2 <- pairs1[pairs1!=exclusion]
  return(pairs2)
}

pairs <- unique_pairs(data, pair, "4918x4967")
#pairs <- unique(data$pair)
#pairs <- pairs[pairs!="4918x4967"]

#my_comparisons <- list( c("FF_real", "FM_real"), c("FF_real", "MM_real"), 
#                        c("FM_real", "MM_real"))

make_comparisons <- function(comp1a, comp1b, comp2a, comp2b, comp3a, comp3b) {
  compare <- list(c("comp1a", "comp1b"), c("comp2a", "comp2b"), 
                  c("comp3a", "comp3b"))
  return(compare)
}

my_comparisons <- make_comparisons(FF_real, FM_real, 
                                   FF_real, MM_real, FM_real, MM_real)

make_dist_df <- function(pairdata, datatype, realorfake, distance) {
  all.dists <- data.frame(pairdata = character(), datatype = character(), 
                           realorfake = character(), distance = numeric())
  return(all.dists)
}
all.dists.df <- make_dist_df(pair, type, fake_real, dist)
#all.dists.df <- data.frame(pair = character(), type = character(), 
#                           fake_real = character(), dist = numeric())
for (mod in mods) {
  print(mod)
  data_matrix <- as.matrix(data[,mod])
  rank_matrix <- rank(data_matrix)
  distance_matrix <- as.matrix(dist(rank_matrix))
  distance_df <- as.data.frame(distance_matrix)
  
  rownames(distance_df) <- data$animal
  colnames(distance_df) <- rownames(distance_df)
  
  dist.df.rank <- make_dist_df(pair, type, fake_real, dist)
  
  #dist.df.rank <- data.frame(pair = character(), type = character(), 
  #                           fake_real = character(), dist = numeric())
  colnames(dist.df.rank) <- c("pair", "dist")
  for (pair in pairs) {
    ani1 <- str_split_i(pair, "x", 1)
    ani2 <- str_split_i(pair, "x", 2)
    
    distance <- distance_df[ani1, ani2]
    type <- data$pair_type[data$pair==pair][1]
    type <- paste(type, "real", sep = "_")
    mini.df <- data.frame("pair" = pair, "type" = type, 
                          "fake_real" = "real", "dist" = distance)
    
    dist.df.rank <- rbind(dist.df.rank, mini.df)
  }
  
  #see if different between groups
  plot <- ggplot(dist.df.rank, aes(x = type, y = dist, fill = type)) + 
    geom_violin() + geom_point() + ggtitle(mod) + 
    stat_compare_means(comparisons = my_comparisons, 
                       paired = FALSE, method = "wilcox.test")
  print(plot)
  
make_t_mod(rank_distance_data, distance, mu_value, alt_value) {
  t_test_mod <- wilcox.test(rank_distance_data$distance, mu = mu_value,
                            alternative = "alt_value")
  return(t_test_mod)
}

t.mod <- make_t_mod(dist.df.rank, dist, 13, two.sided)
#t.mod <- wilcox.test(dist.df.rank$dist, mu = 13, alternative = "two.sided")
print(t.mod)

rank_module_combo -> function(rank_distance_data, module, modvar, 
                              all_dist_data) {
  rank_distance_data$module <- modvar
  all_dists_combo <- rbind(all_dist_data, rank_distance_data)
  return(all_dists_combo)
}  
all.dists.df <- rank_module_combo(dist.df.rank, Module, mod, all_dists.df)
#dist.df.rank$Module <- mod
#all.dists.df <- rbind(all.dists.df, dist.df.rank)
}

#reorder modules for plotting

generate_module_order <- function(num_modules) {
  module_names <- paste0("Module.", 1:num_modules)
  return(module_names)
}

num_modules <- 23
mod.order <- generate_module_order(num_modules)

all.dists.df$Module <- factor(all.dists.df$Module, levels = mod.order)


plot <- ggplot(all.dists.df, aes(x = Module, y = dist, fill = Module)) + 
  geom_boxplot() + geom_point(position = position_jitter(w=0.2, h=0)) + 
  geom_abline(slope = 0, intercept = 13) + theme_classic() + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) + 
  ylab("Rank-based distance") +
  scale_fill_manual(values = c("Module.1" = "gainsboro",
                               "Module.2" = "gainsboro",
                               "Module.3" = "gainsboro",
                               "Module.4" = "gainsboro",
                               "Module.5" = "gainsboro",
                               "Module.6" = "deeppink4", 
                               #colored bc significant
                               "Module.7" = "gainsboro",
                               "Module.8" = "gainsboro",
                               "Module.9" = "gainsboro",
                               "Module.10" = "gainsboro",
                               "Module.11" = "chartreuse4",
                               #colored bc significant
                               "Module.12" = "gainsboro",
                               "Module.13" = "gainsboro",
                               "Module.14" = "gainsboro",
                               "Module.15" = "gainsboro",
                               "Module.16" = "gainsboro",
                               "Module.17" = "gainsboro",
                               "Module.18" = "gainsboro",
                               "Module.19" = "gainsboro",
                               "Module.20" = "gainsboro",
                               "Module.21" = "gainsboro",
                               "Module.22" = "gainsboro",
                               "Module.23" = "gainsboro"))
# ggsave("rank_based_partner_dists.png", plot, device = "png", width = 15, 
#height = 8, units = "in", bg = "white")
print(plot)
ggsave("rank_based_partner_dists.png", plot, width = 12, height = 8, 
       units = "in", bg = "white", device = png)
expected_dist <- dist(1:38)
mean_expected_dist <- mean(expected_dist) 
#equals 13. so is actual dists between partners less than 13?

```

see if pairs cluster by genes and are closer 
in euclidean distance in modules (in loop)
```{r}
mod_genes <- read.csv("G:/My Drive/pateiv/seq_analysis/snseq_analysis/
                Hotspot/new_clusts_noTrh/new_clusts_hotspot-gene-modules.csv")

set_working_directory()
#setwd("G:/My Drive/pateiv/seq_analysis/swe4s_seq_analysis/hotspot_r/")

#create df to hold p-values for euclidean distance between partners test
euclidean_signif <- data.frame(Module = character(), pval = numeric())

for (mod in mods) {
  return(mod)
  mod_num <- strsplit(mod, "Module.")[[1]][2]
  return(mod_num)
  #olig_genes is a bad (holdover) variable name and should be changed
  olig_genes <- mod_genes$Gene[mod_genes$Module == mod_num]

  Idents(SCT_norm) <- "Ani"
  #olig_expression is a bad (holdover) variable name and should be changed
  #this finds avg expression of for each gene in that module
  gene_expression_per_module <- AverageExpression(SCT_norm, 
                                                  features = olig_genes, 
                                       assays = "SCT", slot = "counts")
  gene_expression_per_module <- gene_expression_per_module[1] %>% as.data.frame()
  gene_expression_per_module <- t(gene_expression_per_module)
  rownames(olig_expression) <- sub("SCT.", "", rownames(olig_expression))
  olig_expression <- olig_expression %>% as.data.frame()
  olig_expression <- olig_expression[!(row.names(olig_expression) %in% "4918"),]
  
  
  olig_scale <- scale(olig_expression) %>% as.data.frame()
  rownames(olig_scale) <- rownames(olig_expression)
  olig_scale$animal <- rownames(olig_scale)
  olig_scale <- merge(olig_scale, metadata[,c("animal", "pair", 
                                              "pair_type")], on = "animal")

  annot <- HeatmapAnnotation(Pair = olig_scale$pair, Group = olig_scale$Group)
  
  #find euclidean distances between partners based on genes from each module
  olig_mat <- olig_expression
  olig_dist <- dist(olig_expression) %>% as.matrix()
  
  #distance between true pairs
  #pairs <- unique(data$pair)
  #get rid of pair that one animal isn't in dataset
  #pairs <- pairs[pairs!="4918x4967"]
  
  pairs <- unique_pairs(data, pair, "4918x4967")
  
  #dist.df <- data.frame(pair = character(), type = character(), 
  #                      fake_real = character(), dist = numeric())
  
  dist.df <- make_dist_df(pair, type, fake_real, dist)
  
  
  colnames(dist.df) <- c("pair", "dist")
  for (pair in pairs) {
    ani1 <- str_split_i(pair, "x", 1)
    ani2 <- str_split_i(pair, "x", 2)
    
    distance <- olig_dist[ani1, ani2]
    print(distance)
    type <- data$pair_type[data$pair==pair][1]
    type <- paste(type, "real", sep = "_")
    mini.df <- data.frame("pair" = pair, "type" = type, 
                          "fake_real" = "real", "dist" = distance)
    
    dist.df <- rbind(dist.df, mini.df)
  }
  
  #for fake pairs and to plot
  
  all_animals <- data$animal
  l <- crossing(var1 = all_animals, var2= all_animals)
  
  #for not-true (fake) pairs - as a control!!!
  #remove true pairs from crossing matrix 
  #(there must be a better way to do this)
  l <- l %>% 
    filter(!(var1 == "4905" & var2 == "4975" | var2 == "4905" & var1 == "4975")) %>%
    filter(!(var1 == "4918"| var2 == "4918")) %>%
    filter(!(var1 == "4921" & var2=="4909" | var2 == "4921" & var1=="4909")) %>%
    filter(!(var1 == "4968" & var2=="4931" | var2 == "4968" & var1=="4931")) %>%
    filter(!(var1 == "5021" & var2=="5204" | var2 == "5021" & var1=="5204")) %>%
    filter(!(var1 == "4940" & var2=="4916" | var2 == "4940" & var1=="4916")) %>%
    filter(!(var1 == "4960" & var2=="4928" | var2 == "4960" & var1=="4928")) %>%
    filter(!(var1 == "5225" & var2=="5121" | var2 == "5225" & var1=="5121")) %>%
    filter(!(var1 == "4896" & var2=="4894" | var2 == "4896" & var1=="4894")) %>%
    filter(!(var1 == "5227" & var2=="5122" | var2 == "5227" & var1=="5122")) %>%
    filter(!(var1 == "4947" & var2=="923" | var2 == "4947" & var1=="923")) %>%
    filter(!(var1 == "4958" & var2=="4901" | var2 == "4958" & var1=="4901")) %>%
    filter(!(var1 == "4898" & var2=="4920" | var2 == "4898" & var1=="4920")) %>%
    filter(!(var1 == "4893" & var2=="4910" | var2 == "4893" & var1=="4910")) %>%
    filter(!(var1 == "4919" & var2=="4933" | var2 == "4919" & var1=="4933")) %>%
    filter(!(var1 == "4917" & var2=="4932" | var2 == "4917" & var1=="4932")) %>%
    filter(!(var1 == "4908" & var2=="4970" | var2 == "4908" & var1=="4970")) %>%
    filter(!(var1 == "5023" & var2=="4963" | var2 == "5023" & var1=="4963")) %>%
    filter(!(var1 == "4976" & var2=="5124" | var2 == "4976" & var1=="5124")) %>%
    filter(!(var1 == "5209" & var2=="4974" | var2 == "5209" & var1=="4974")) %>%
    filter(!(var1==var2))
  
  fm.list <- list()
  for (i in (1:nrow(l))) {
    row <- l[i,]
    ani1 <- row[1] %>% as.character()
    ani2 <- row[2] %>% as.character()
    pairname <- paste(ani1, ani2, sep = "x")
    distance <- olig_dist[ani1, ani2]
    revpair <- paste(ani2, ani1, sep = "x")
    if (revpair %in% names(fm.list)) {
    } else {
        fm.list[pairname] <- distance
      }
      
  }
  
  fm.list <- fm.list %>% unlist()
  
  fm.df <- data.frame(fm.list)
  fm.df$pair <- rownames(fm.df)
  fm.df$type <- "all_fake"
  fm.df$fake_real <- "fake"
  colnames(fm.df)[1] ="dist"
  
    wil <- wilcox.test(fm.df$dist, dist.df$dist)
  print(wil)
  
  dist.df$fr <- "real"
  fm.df$fr <- "fake"
  
  all.fr.dists <- rbind(dist.df, fm.df)

  plt <- ggplot(all.fr.dists, aes(x = fr, y = dist, color = fr, 
                                  fill = fr, alpha = 0.8)) + 
    geom_violin() + 
    geom_jitter(width = 0.2, height = 0, color = "slategrey") +
    stat_compare_means() +
    # # colors for Module.6
    # scale_fill_manual(values = c("fake" = "palevioletred1",
    #                   "real" = "deeppink4")) +
    # scale_color_manual(values = c("fake" = "palevioletred1",
    #                   "real" = "deeppink4")) +
    # colors for Module.11
    scale_fill_manual(values = c("fake" = "palegreen2",
                      "real" = "chartreuse4")) +
    scale_color_manual(values = c("fake" = "palegreen2",
                      "real" = "chartreuse4")) +
    ggtitle(paste(mod, "Euclidean Distance Between Parnters")) +
    xlab("Fake or Real Pair") +
    ylab("Euclidean Distance") +
    theme_classic()
  print(plt)
  
  ggsave(paste(mod, "euclidean dist.png"), bg = "white", width = 8, 
         height = 8, units = "in", device = png)
  
  euclidean_signif_mini <- data.frame(Module = mod, pval = wil$p.value)
  euclidean_signif <- rbind(euclidean_signif, euclidean_signif_mini)

}

euclidean_signif$test <- "Euclidean_Dist"

```

Add a new chunk by clicking the *Insert Chunk* 
button on the toolbar or by pressing *Ctrl+Alt+I*.

When you save the notebook, an HTML file containing the code 
and output will be saved alongside it (click the *Preview* button or 
press *Ctrl+Shift+K* to preview the HTML file).

The preview shows you a rendered HTML copy of the contents of the editor. 
Consequently, unlike *Knit*, *Preview* does not run any R code chunks. 
Instead, the output of the chunk when it was 
last run in the editor is displayed.
