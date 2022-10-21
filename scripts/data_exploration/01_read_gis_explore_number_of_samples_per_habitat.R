#explore B/RUVs samples in relation to the environmental variables assocaited with BRUVs

library(foreign)
library(sf)
library(tidyverse)

gis.dat <- read.dbf("./data/ald_bruvs_2013-2015_consol_utm38s_20170425.dbf")
gis.dat <- gis.dat %>% filter(project == "ALD", analysed == "y") 
gis_dat <- st_read("./data/ald_bruvs_2013-2015_consol_utm38s_20170425.shp") %>% 
  filter(project == "ALD", analysed == "y") 
names(gis.dat)
gis_dat %>% head(6)
ggplot2::ggplot()+
  geom_sf(data = gis_dat, aes(col = bait, alpha = 0.5, size = 2, shape = bait))
#number of samples per reef zone
gis.dat %>% group_by(reefzone, bait) %>% summarise(n())
ggplot2::ggplot()+
  geom_sf(data = gis_dat, aes(col = reefzone, alpha = 0.5, size = 2, shape = reefzone))
#number of samples per habitat type
gis.dat %>% group_by(brdhab, bait) %>% summarise(n())

# number of samples per fine habitat type
gis.dat %>% group_by(finehab, bait) %>% summarise(n())

