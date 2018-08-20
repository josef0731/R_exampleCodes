#!/bin/R
########################################################
####     PCA Analysis of gene expression counts     ####
########################################################
# Joseph Ng, August 2018

#________________________
# Usage: Rscript --no-save --no-restore pca_genecounts.R <genecounts.txt> <pca_plot.png> <TRUE>
# Note that positions of arguments are important here.
# Arguments:
# (1) input table of gene counts (see below)
# (2) output PCA plot in png (see below)
# (3) (optional) turn on plotting the data with gene names as labels for the data points. Default FALSE.

# input: a tab-delimited table of gene counts, not normalised, 1 gene in each row, organised by samples (columns)
# with header indicating sample name. 
# Example:
# Gene  L1  L2  F1  F2
# Gene1 343 524 10  22
# Gene2 24  41  314 438
# ...

# output: a PCA bi-plot. optionally gene names can be shown as labels

#________________________
#Load packages. If not exist download and install them.
is.installed <- function(mypkg){
  is.element(mypkg, installed.packages()[,1])
} 

# check if package "hydroGOF" is installed
if (!is.installed("devtools")){
  install.packages("devtools", repos = "https://cloud.r-project.org")
}
if (!is.installed("ggbiplot")){
  require(devtools)
  install_github("ggbiplot", repos = "https://cloud.r-project.org")
}

#________________________
#put command-line arguments in place
print("Now read command-line arguments ...")
args <- commandArgs(trailingOnly = TRUE)
genecountfile <- args[1]
outputfile <- args[2]
if(length(args) > 2) {
  gene.label <- args[3]
} else gene.label <- FALSE

if(!grepl(".txt", genecountfile)){
  print("Gene count file has to be of extension '.txt'.")
  stop()
}

if(!grepl(".png", outputfile)){
  print("Output destination has to be of extension '.png'.")
  stop()
}

#________________________
#Load data.
genecounts <- read.table(genecountfile, sep = "\t", header = T, stringsAsFactors = F)

print("Data loaded ... ")
# log2 transform 
genecounts[, 2:ncol(genecounts)] <- log2(genecounts[, 2:ncol(genecounts)] + 1)

pca <- prcomp(as.matrix(genecounts[, 2:ncol(genecounts)]), center = TRUE, scale. = TRUE) 

print("PCA completed. Now plotting ...")
# Plot
library(ggbiplot)
png(outputfile, width = 2500, height = 1500, res = 300)
if(isTRUE(gene.label)){
  genelabels <- genecounts[, 1]
  g <- ggbiplot(pca, obs.scale = 1, var.scale = 1, labels = genelabels)
} else {
  g <- ggbiplot(pca, obs.scale = 1, var.scale = 1)
}
print(g)
dev.off()
print("Done. ")