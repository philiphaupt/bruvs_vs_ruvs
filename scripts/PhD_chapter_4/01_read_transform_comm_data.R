# Title: Community data matrix data transformation - only applied to abundance data
# Author: Phil
# Date: 2017-05-26
# Objectives: TRANSFORM community data matrix to downweight the importance of the most abundant species and increase that of the rarer species

# Description: Transform data for use in modified Gower (Anderson et al 2006) (known as "altGower" in vegan), which uses a special case of log transformation described in that paper an in vegan package, Oksanen et al 2016.
# Many options were explored e.g. Squareroot, root-root, and log, which could accompany Morista Horn distance (Jost et al 2011). Ultimately modified Gower was opted, and this has to be log transformed, using a base to decide on how severe the transformation should be. Log 2 means doubling of fish is considered the same as adding a  species, while log 10 means that an exponential increase is equivalent to  adding a species. Logbase 10 therefore favours rare species, and places emphasis on species numbers, while logbase 2 empahsis the more abundant species. 

# Due to the significant effect that the abudnant species have on the results, logbase 10 was used (even after schooling fish/outliers were removed) given that some species occurring at lower numbers can havea significant ecological impact, e.g. large predators.



library(vegan)

#read community data matrix
#comm.ald.paired <- readRDS('E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm_ald_paired.RDS')
#write.csv(comm.ald.paired, 'E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm_ald_paired.csv')

#NOW OUTLIER REMOVED (120 samples...)
comm.ald.paired <- readRDS('E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm.ald.paired.or.RDS')

# TRANSFORM data
# Special cases of log (X)+1, and 0 remains zero, as per Anderson et al 2001, and available in decostand, vegan used:
comm.log.mGow.transform <- decostand(comm.ald.paired, "log", logbase = 10)
# Save as RDS for later recall
saveRDS(comm.log.mGow.transform, "E:/stats/aldabra/BRUVs/02_ALD/community/species_level/output/data/comm.log.mGow.transform.rds", ascii = TRUE)


############################################################
# Other options explored

#Log transformations - more severe similar to root-root transformation: below explored:
#comm.ald.paired.log10<- log10(1+ comm.ald.paired) #VEGAN:  Community data matrix arranged data, log transformed, and aranged with species as column names and sites as row names, for use in vegan
#comm.ald.paired.log2 <- log2(1+ comm.ald.paired)
#saveRDS(comm.ald.paired.log,'E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/log_sp_sites_ALD.RDS', ascii = TRUE)

## square root transform - suitable with most inices, where difference in high and low abudnance is not very great.
#comm.ald.paired.sqrt <- sqrt(comm.ald.paired)
#comm.ald.paired.t.sqrt <- sqrt(comm.ald.paired.t)

## wisconsin double transform - see vegan manual, recommended transformation for nmds plots - a standard method often used with Bray-Curtis distance
#comm.ald.paired.wisc <- wisconsin(comm.ald.paired)
#saveRDS(comm.ald.paired.wisc,'E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm_ald_paired_wisc.RDS', ascii = TRUE)

#transpose data for use in spadeR - See spade R files
#comm.ald.paired.t.log <- data.frame(t(comm.ald.paired.log)) # spadeR: Community data matrix, log transformed, and arranged with species in rows, and sites in columns for use in SpadeR.
#comm.ald.paired.t <- t(comm.ald.paired)
#comm.ald.paired.t.wisc <- wisconsin(comm.ald.paired.t)
