# PERMANOVA SPECIES LEVEL --- see data exploration  - this is a repeat of what was done in daa exploration, but here nomralised environemntal variables were used.
library(vegan)

# Resemblance distance - modified Gower logbase 10 of 8 species groups
# READ DATA
## read dissimilarity matrix from species community matrix data:
dis.mgow.lb10 <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/community/species_level/output/data/dis.mgow.lb10.rds")

# Environmental data
## below #-out is the FULL set, further below is the outleir removed set, after 2017-08-03
# read environemtnal data, full set (to access treatment, and nomralised real number subset)
#env.ald.paired <- readRDS('E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env_ald_paired.RDS') # for graphics
#env.vars.norm <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env_ald_paired_vars_continuous_norm.RDS")
## generate CAP environemtnal data
#env.adonis <- env.vars.norm
#env.adonis$treatment <- env.ald.paired$treatment

#THE OUTLIER REMOVED SET READ IN
env.vars.or.norm <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env.ald.or.norm.RDS")

# PERMANOVA: overall test
#overall test
vegan::adonis2(dis.mgow.lb10 ~ sample.area + percent.water.column + temperature + wave.energy + depth + treatment, data = env.vars.or.norm, permutations = 4999, by = NULL, add = "lingoes",  model = "reduced") # note normalised env vars used. use vegan::decostand(data, method = "normalize")

#Permutation test for adonis under reduced model
#Permutation: free
#Number of permutations: 4999

#vegan::adonis2(formula = dis.mgow.lb10 ~ sample.area + percent.water.column + temperature + wave.energy + depth + treatment, data = env.vars.or.norm, permutations = 4999, add = "lingoes", by = NULL, model = "reduced")
#               Df SumOfSqs     F Pr(>F)    
#       Model      6   11.486 3.182  2e-04 ***
#       Residual 113   67.982                 
#       ---
#       Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


##################################################
##PERMANOVA by  term: sequential test

vegan::adonis2(dis.mgow.lb10 ~  sample.area + percent.water.column + temperature +  wave.energy  + depth +treatment, data = env.vars.or.norm, permutations = 4999, by = "term", add = "lingoes", model = "reduced")


#OUTLIERS REMOVED RESULTS:

#Permutation test for adonis under reduced model
#Terms added sequentially (first to last)
#Permutation: free
#Number of permutations: 4999

#vegan::adonis2(formula = dis.mgow.lb10 ~ sample.area + percent.water.column + temperature + wave.energy + depth + treatment, data = env.vars.or.norm, permutations = 4999, add = "lingoes", by = "term", model = "reduced")
#                               Df SumOfSqs      F Pr(>F)    
#        sample.area            1    1.005 1.6700 0.0102 *  
#        percent.water.column   1    0.774 1.2865 0.0836 .  
#        temperature            1    1.478 2.4568 0.0006 ***
#        wave.energy            1    3.114 5.1758 0.0002 ***
#        depth                  1    3.520 5.8507 0.0002 ***
#        treatment              1    1.596 2.6524 0.0002 ***
#        Residual             113   67.982                  
#---
#        Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1














# Older results
# USING ALL DATA (OUTLIERS INCLUDED)

#Permutation test for adonis under reduced model
#Terms added sequentially (first to last)
#Permutation: free
#Number of permutations: 4999

#vegan::adonis2(formula = dis.mgow.lb10 ~ sample.area + percent.water.column + temperature + wave.energy + depth + treatment, data = env.vars.or.norm, permutations = 4999, add = "lingoes", by = "term", model = "reduced")
#                               Df SumOfSqs      F Pr(>F)    
#        sample.area            1    1.039 1.7659 0.0060 ** 
#        percent.water.column   1    0.755 1.2835 0.0802 .  
#        temperature            1    1.395 2.3705 0.0004 ***
#        wave.energy            1    3.087 5.2471 0.0002 ***
#        depth                  1    3.421 5.8133 0.0002 ***
#        treatment              1    1.571 2.6696 0.0002 ***
#        Residual             115   67.668                  
#---
#        Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1








###USING VEGAN:NORMALISED  Environmental data - incorrect - should vegan standardised
#Permutation test for adonis under reduced model
#Terms added sequentially (first to last)
#Permutation: free
#Number of permutations: 999

#       vegan::adonis2(formula = dis.mgow.lb10 ~ sample.area + percent.water.column + temperature + wave.energy + depth + treatment, data = env.vars.or.norm, permutations = 999, add = "lingoes", by = "term")
#                              Df  SumOfSqs    F  Pr(>F)    
#       sample.area            1    0.909 1.5303  0.025 *  
#       percent.water.column   1    1.272 2.1401  0.001 ***
#       temperature            1    2.127 3.5792  0.001 ***
#       wave.energy            1    0.835 1.4056  0.044 *  
#       depth                  1    3.955 6.6545  0.001 ***
#       treatment              1    1.494 2.5141  0.001 ***
#       Residual             115   68.343                  
#---
#       Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1


