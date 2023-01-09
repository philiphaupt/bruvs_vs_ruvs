# Ordination PCO

# Title: Principal coordinate analysis (PCO) - ORDINATION ANALYSIS of relative abundance (MaxN) at the SPECIES LEVEL
# Author: Phil
# Date: 2017-05-26
# Note: NOT AGGEREGATED BY TROPHIC LEVEL!

# Objectives: 1) Generate principal coordinates from distance calculated at species level, using modified Gower distance
#			  2) Generate ordination plot of PCO, including relative contribution of axes (in grey scale), and goodness of fit (GOF)
#			  3) Fit and plot the relative contribution of the environmental variables as vectors on the PCO plot
#			  3) Explore PCO plots using the other distance matrices calculated. (this was done in PhD)

# See https://ourcodingclub.github.io/tutorials/ordination/ and https://www.davidzeleny.net/anadat-r/doku.php/en:pcoa_nmds
# for some reasons why MDS PCoA was used. for the paper I will also revisit NMDS.

# Libraries
library(vegan)
library(tidyverse)

# Determine Principal Coordinates (PCO) from the above resemblance matrix
pco_dis_mgow_lb10 <- wcmdscale(dis_mgow_lb10, eig = TRUE, add = "lingoes") # make sure to add eigenvectors to allow calculation of axes contributions.


