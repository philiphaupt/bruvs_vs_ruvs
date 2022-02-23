# Author: Phil
# Date: 2017-05-26
# Aim: Create a distance matrix which allows multivariate analysis to act upon in following steps.
# See log_transform_community_matrix.R that precedes this file

library(vegan)
library(labdsv)
# library("CommEcol")


# Read Data
#comm.ald.paired <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm.ald.paired.or.rds") #outlier removed
# comm.log.mGow.transform <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm.log.mGow.transform.rds") # not neccessary as can be done in one step as below.

# modified Gower of log transformed community data
dis.mgow.lb10 <- vegan::vegdist(x = comm.log.mGow.transform, method = "altGower") # does not include log(1+x)- see Anderson et al 2006, and Vegan manual
# saveRDS(dis.mgow.lb10,"E:/stats/aldabra/BRUVs/02_ALD/community/species_level/output/data/dis.mgow.lb10.rds", ascii = TRUE)
