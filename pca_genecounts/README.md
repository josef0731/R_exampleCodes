## R code to perform Principal Component Analysis (PCA) on RNAseq gene counts data

Usage: 
```
Rscript --no-save --no-restore pca_genecounts.R <genecounts.txt> <pca_plot.png> <TRUE>
```
Note that positions of arguments are important here.
# Arguments:
1. input table of gene counts (see below)
2. output PCA plot in png (see below)
3. (optional) turn on plotting the data with gene names as labels for the data points. Default FALSE.

*input*: a tab-delimited table of gene counts, not normalised, 1 gene in each row, organised by samples (columns)
with header indicating sample name.
```
# Example:
Gene  L1  L2  F1  F2
Gene1 343 524 10  22
Gene2 24  41  314 438
...
```

*output*: a PCA bi-plot (filename indicated as argument, see above). optionally gene names can be shown as labels
