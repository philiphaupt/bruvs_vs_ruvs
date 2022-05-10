# Title: The Modified Gower dissimilarity distance ( Resemblance matrix special case log transforamed (logbase 10))  & others
# See 02_transform_comm_data.R that precedes this file
# Author: Phil
# Date: 2017-05-26


library(vegan)
library(labdsv)
library("CommEcol")


# Read Data
comm.ald.paired <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm.ald.paired.or.rds") #outlier removed
# comm.log.mGow.transform <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm.log.mGow.transform.rds") # not neccessary as can be done in one step as below.

# modified Gower of log transformed community data
dis.mgow.lb10 <- vegan::vegdist(x = decostand(comm.ald.paired, "log", logbase = 10), method = "altGower") # does not include log(1+x)- see Anderson et al 2006, and Vegan manual
saveRDS(dis.mgow.lb10,"E:/stats/aldabra/BRUVs/02_ALD/community/species_level/output/data/dis.mgow.lb10.rds", ascii = TRUE)

#can also do log base 2 or 5.


###########other distance measures follow: #################

# Morisita Horn Distance

#dis.horn.log <- vegan::vegdist(x= comm.ald.paired.log,method = "horn") # calculate dissimilarity distance using horn-morsita method in vegan
#dis.horn.wisc <- vegan::vegdist(x= comm.ald.paired.wisc,method = "horn") # can be done using double Wisconsin as here.

#export file for primer for check - not needed now.
#dis.horn.log.3column <- data.frame(t(combn(rownames(comm.ald.paired.log),2)), as.numeric(dis.horn.log))
#names(dis.horn.log.3column) <- c("sample_name", "sample_name", "distance")
#dis.horn.log.3column$distance <- dis.horn.log.3column$distance*100
#write.csv(dis.horn.log.3column, "E:/stats/aldabra/BRUVs/02_ALD/data_exploration/primer_permanova/data/dis_horn_log_3column.csv", row.names = FALSE)
######################################################################################


# Chao distance (2005), using Jaccard/Sorensen index 

#install.packages("CommEcol")
#dis.chao.log10 <- dis.chao(comm.ald.paired.log)
#REsults similar to Modified Gower

#######################################################################################