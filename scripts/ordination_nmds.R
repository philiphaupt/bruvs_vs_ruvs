# Ordination NMDS
# Title: NMDS abundance (MaxN) at the SPECIES LEVEL
# Author: Phil
# Date: 2022-01-09

# Objectives: 1) Generate NMDS from modified Gower distance at SPECIES LEVEL
#			  2) Generate ordination plot of NMDS including relative contribution of axes (in grey scale), and goodness of fit (GOF)
#			  3) Fit and plot the relative contribution of the environmental variables as vectors on the NMDS plot
#			  3) Explore NMDS plots using the other distance matrices calculated. (this was done in PhD)

# See https://ourcodingclub.github.io/tutorials/ordination/ and https://www.davidzeleny.net/anadat-r/doku.php/en:pcoa_nmds
# for some reasons why MDS PCoA was used. for the paper I will also revisit NMDS.

# Libraries
library(vegan)
library(tidyverse)
# NMDS
nmds_dis_mgow_lb10 <- metaMDS (sp_log_transform, "altGower", scaling = 1)
plot (nmds_dis_mgow_lb10, main = 'NMDS',  type = 'n', display = 'si')
points (nmds_dis_mgow_lb10, 
        display = 'si', 
        col = env_dat_per_site$treatment, 
        pch = env_dat_per_site$treatment
)
text (nmds_dis_mgow_lb10, display = 'sp', col = "#FF000080", cex = 0.6, 
      select = colSums (species_community_matrix>0)>20)#only species occurring in at least 20 sites are displayed
#wascores(env_dat_per_site, species_community_matrix)