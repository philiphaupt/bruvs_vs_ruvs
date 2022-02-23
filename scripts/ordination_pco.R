# Ordination PCO

# Title: Principal coordinate analysis (PCO) - ORDINATION ANALYSIS of relative abundance (MaxN) at the SPECIES LEVEL
# Author: Phil
# Date: 2017-05-26
# Note: NOT AGGEREGATED BY TROPHIC LEVEL!

# Objectives: 1) Generate principal coordinates from distance calculated at species level, using modified Gower distance
#			  2) Generate ordination plot of PCO, including relative contribution of axes (in grey scale), and goodness of fit (GOF)
#			  3) Fit and plot the relative contribution of the environmental variables as vectors on the PCO plot
#			  3) Exlpore PCO plots using the ither distance matrices calculated.

# Libraries
library(vegan)
library(tidyverse)

# Determine Principal Coordinates (PCO) from the above resemblance matrix
pco.dis.mgow.lb10 <- wcmdscale(dis.mgow.lb10, eig = TRUE, add = "lingoes") # make sureto add eigenvectors to allow calculation of axes contributions.


