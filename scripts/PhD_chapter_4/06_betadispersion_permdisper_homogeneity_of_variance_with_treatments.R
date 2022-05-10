# Test analysis of multivariate homogeneity of group dispersions (variances)
# Author: Phil
# Date: 2017-05-31

# Objective test for homogeneity of group (treatment) dispersion in data

library(vegan)
library(plotrix)
library(dplyr)

# Resemblance distance - modified Gower logbase of species level data
# READ DATA

# Read dissimilarity matrix (modified Gower, logbase 10) data (resemblance matrix): 
dis.mgow.lb10 <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/community/species_level/output/data/dis.mgow.lb10.rds")
# read environmental data, full set (to access treatment, and nomralised real number subset)
#env.ald.paired <- readRDS('E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env_ald_paired.RDS') # for graphics
#env.vars.norm <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env_ald_paired_vars_continuous_norm.RDS")
#trt <- env.adonis$treatment
#THE OUTLIER REMOVED SET READ IN
env.vars.or.norm <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env.ald.or.norm.RDS")

#Calculate multivariate dispersion
disp.sp <- betadisper(d = dis.mgow.lb10, trt, type = c("centroid"), bias.adjust = FALSE,
                         sqrt.dist = FALSE, add = "lingoes")
disp.sp

centroid.dist <- as.data.frame(disp.sp$distances)
colnames(centroid.dist) <- "distance"
centroid.dist$group <- disp.sp$group
centroid.dist %>% group_by(group) %>% summarise(mean.dist.to.centriod = mean(distance), se.dist.to.centroid = std.error(distance))


# Perform test
anova(disp.sp)

# Permutation test for F
permutest(disp.sp, pairwise = TRUE, permutations = 4999)

## Tukey's Honest Significant Differences
(disp.sp.HSD <- TukeyHSD(disp.sp))
plot(disp.sp.HSD)


# Graphical preporties
# Generate graphical properties for pco plot: grey circles and black squares according to treatment - using environemtnal data, full set - check that sequence of opcode site names match those in community data matrix
pco.lbls <- env.vars.or.norm %>% dplyr::select(treatment)
pco.lbls$pch[pco.lbls$treatment == "baited"] <- 0
pco.lbls$pch[pco.lbls$treatment == "unbaited"] <- 1
pco.lbls$clr[pco.lbls$treatment == "baited"] <- "black"
pco.lbls$clr[pco.lbls$treatment == "unbaited"] <- "grey44"
#pco axes contribution
sp.axis1.contr <- round(sp.pco.dis.mgow.lb10$eig[1]/sum(sp.pco.dis.mgow.lb10$eig)*100,2)
sp.axis2.contr <- round(sp.pco.dis.mgow.lb10$eig[2]/sum(sp.pco.dis.mgow.lb10$eig)*100,2)



## Plot the groups and distances to centroids on the first two PCoA axes
par(mfrow = c(1,1), mar = c(6, 4.5,1,1)+0.1, cex = 1.5)
plot(disp.sp, segments = FALSE, ellipse = FALSE, hull = TRUE, conf = 0.95, pch = c(pco.lbls$pch[pco.lbls$treatment == "baited"] <- 0, pco.lbls$pch[pco.lbls$treatment == "unbaited"] <- 1), col = c(pco.lbls$clr[pco.lbls$treatment == "baited"] <- "black", pco.lbls$clr[pco.lbls$treatment == "unbaited"] <- "grey44"), main = "", label = FALSE, xlab = paste("PCo-A1 (",sp.axis1.contr,"% of total variation)", sep = ""), ylab = paste("PCo-A2 (",sp.axis2.contr,"% of total variation)", sep = ""))
legend(-0.75,0.65, c("BRUVs (baited)","RUVs (unbaited)", "centriod baited", "centriod unbaited"), lty=c(1,1,0,0), pch = c(0,1,19,19), lwd=c(2.5,2.5,0,0),col=c("black","grey44"), cex = 0.75, bty = "n")
#sp.env.fit <- envfit(sp.pco.dis.mgow.lb10, env.vars.norm, perm = 999); #KEY function to add environmental fit!!
#plot(sp.env.fit, col = "grey60", cex = 0.75)

## can also specify which axes to plot, ordering respected
plot(disp.sp, axes = c(3,1), seg.col = "forestgreen", seg.lty = "dashed")


## Draw a boxplot of the distances to centroid for each group
boxplot(disp.sp)


# scores and eigenvectors
scrs <- scores(disp.sp)
str(scrs)
head(scores(disp.sp, 1:4, display = "sites"))
# group centroids/medians
scores(disp.sp, 1:4, display = "centroids")
# eigenvalues from the underlying principal coordinates analysis
eigenvals(disp.sp)
