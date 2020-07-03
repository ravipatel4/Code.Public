ddd= read.table("/workdir/rkp55/mpecSlec/lowlane_HWTC7BG/fastq/exon_MPEC-SLEC.featureCount_genbankList_counts", header = T, row.names = 1)[c(1:7,9:11)]
keep <- rowSums(cpm(ddd)>1) >= 2
ddd <- ddd[keep,]
#ddd = as.data.frame(log(cpm(ddd)+0.1,2))

tcounts=t(as.data.frame(log(cpm(ddd)+0.1, 2)))  # For an example of MPEC/SLEC data: Log transformation is good if the data has many outliers or the higher values have more variations. The PCA is affected by and biased towards more variations in higher values and outliers on higher value end. Therefore, log-transformation would help reducing such biases. (http://stats.stackexchange.com/questions/164381/why-log-transforming-the-data-before-performing-principal-component-analysis)
pca=prcomp(tcounts) # For an example of MPEC/SLEC data: scale.=T changes how the PCA is plotted. It is a good idea *not* to scale if all variables have a same unit or measured in a same way (https://www.researchgate.net/post/What_is_the_best_way_to_scale_parameters_before_running_a_Principal_Component_Analysis_PCA)

ttbb=as.data.frame(pca$x)
plot(ttbb$PC1, ttbb$PC2)
text(ttbb$PC1, ttbb$PC2, row.names(ttbb), pos = 4, cex=0.5)
round((pca$sdev)^2 / sum(pca$sdev^2)*100)
plot(pca)

percentVar = round((pca$sdev)^2 / sum(pca$sdev^2)*100)
pca_mod = as.data.frame(pca$x)
pca_mod$age = c(rep('Adult',2), rep('Neonate',2), rep('Adult',2), rep('Neonate',1), rep('Adult',0), rep('Neonate',0))
pca_mod$sex = c(rep('MPEC',3),rep('SLEC',3),rep('MPEC',1),rep('SLEC',3))
pca_mod$sex = c('MPEC', 'SLEC','MPEC', 'SLEC','MPEC', 'SLEC', 'SLEC')
pca_mod$age = c('1Day', '1Day', '28Day', '28Day', '28Day', '28Day', '28Day', '28Day')
pca_mod$age = c(rep(c('Fetal', 'Cord-blood', 'Adult'),4), 'Fetal')
pca_mod$sex = c(rep('Female',2), rep('Male',6), 'Female', 'Male', rep('Female',3))
pca_mod$type = c('MP', 'MP', 'MP', 'MP', 'TN', 'TN', 'Bulk', 'Bulk')
pca_mod$genotype = c(rep("WT",3),rep("KO",3),rep("WT",3),rep("KO",3),rep("WT",2),rep("KO",3))
pca_mod$miR = c(rep("miR-10b",6),rep("miR-143",6),rep("miR-16-2",5))
#pca_mod$type = c('1D-MP', '1D-MP', '28D-MP', '28D-MP', '28D-TN', '28D-TN', '28D-Bulk', '28D-Bulk')
ggplot(pca_mod, aes(PC1, PC2, color=age, shape=type)) + geom_point(size=5) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) +
  coord_fixed(ratio = 1) + 
  guides(colour = guide_legend(override.aes = list(shape = 15)))  # This line changes the shape of color key in legend to square instead of circles so that it doesn't create confusion with the circles in the plot.
