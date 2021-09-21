
# Run PCA analysis and make PCA plot
library(edgeR)
library(ggplot2)
library(ggrepel)
library(tidyverse)

runNPlotPCA <- function(rawCountMat, colAnnot1=NULL, colAnnot2=NULL, pcOnX=1, pcOnY=2, labels=NULL, returnPCAObj=F) {
  # rawCountMat can be a matrix or a data.frame of raw read counts with genes as rows and samples as columns. Lowly expressed genes should be removed before running this function.
  # colAnnot1 and colAnnot2 are vectors indicating column annotations - are used for assigning different colors and shapes, respectively, to different categories. (e.g. colAnnot1 = c("WT","WT","Cdk2","Cdk2"))
  # pcOnX and pcOnY lets the uses select specific PC to plot on each of the axis.
  # labels is a vector indicating sample names/identifiers that will be displaced next to each sample on the PCA plot.
  # returnPCAObj=T returns the PCA object that can be used for any further analysis.
  tcounts = t(as.data.frame(log(cpm(rawCountMat)+1)))  # Log transformation is good if the data has many outliers or the higher values have more variations (found using an example dataset (MPEC/SLEC data)). The PCA is affected by and biased towards more variations in higher values and outliers on higher value end. Therefore, log-transformation would help reducing such biases. (http://stats.stackexchange.com/questions/164381/why-log-transforming-the-data-before-performing-principal-component-analysis)
  pcaObj = prcomp(tcounts) # scale.=T changes how the PCA is plotted. It is a good idea *not* to scale if all variables have a same unit or measured in a same way (https://www.researchgate.net/post/What_is_the_best_way_to_scale_parameters_before_running_a_Principal_Component_Analysis_PCA)

  # Calculate percent var for all PCs
  percentVar = round((pcaObj$sdev)^2 / sum(pcaObj$sdev^2)*100)
  pca_mod = as.data.frame(pcaObj$x)
  p = pca_mod[,c(pcOnX,pcOnY)] %>% setNames(c("x","y")) %>% ggplot( aes(x, y)) + 
    xlab(paste0("PC",pcOnX,": ",percentVar[pcOnX],"% variance")) +
    ylab(paste0("PC",pcOnY,": ",percentVar[pcOnY],"% variance")) +
    coord_fixed(ratio = 1)
  if(! is.null(colAnnot1) & ! is.null(colAnnot2) ) {
    p = p + geom_point( aes(color=colAnnot1, shape=colAnnot2), size=5)
  } else if(! is.null(colAnnot1) ) {
    p = p + geom_point( aes(color=colAnnot1), size=5)
  } else if(! is.null(colAnnot2) ) {
    p = p + geom_point( aes(shape=colAnnot2), size=5)
  } else {
    p = p + geom_point(size=5)
  }
  p = p + guides(colour = guide_legend(override.aes = list(shape = 15)))  # This line changes the shape of color key in legend to square instead of circles so that it doesn't create confusion with the circles in the plot.
  if(! is.null(labels) ) {
    p = p + geom_text_repel(aes(label=labels), size=4)
  }
  print(p)
  if(returnPCAObj) {
    return(pcaObj)
  }
}
