# PERMANOVA SPECIES LEVEL --- see data exploration  - this is a repeat of what was done in data exploration, but here normalised environmental variables were used.
library(vegan)
library(tidyverse)


################
# 3 drop one sample to make it even by area
# env_dat_per_site %>% group_by(site) %>% sample_n(30)
nrow(comm.log.mGow.transform)
env_dat_per_site <- env_dat_per_site %>% filter(matched_site_id != "63") # drop  sample
tmp <- as_tibble(comm.log.mGow.transform)
tmp$opcode  = row.names(comm.log.mGow.transform)
tmp2 <- tmp %>% dplyr::filter(opcode != "13-10-23_ALD_W_256_17-2") %>% filter(opcode != "13-10-22_ALD_W_256_#3")
comm.log.mGow.transform <- as.matrix(tmp2 %>% select (-opcode))
row.names(comm.log.mGow.transform) <- tmp2$opcode
env_dat_per_site <-  env_dat_per_site %>% dplyr::filter(opcode != "13-10-23_ALD_W_256_17-2") %>% filter(opcode != "13-10-22_ALD_W_256_#3")
species_community_df <- species_community_matrix %>% as_tibble() %>% mutate(opcode = row.names(species_community_matrix)) %>% dplyr::filter(opcode != "13-10-23_ALD_W_256_17-2") %>% filter(opcode != "13-10-22_ALD_W_256_#3")
##PERMANOVA by  term: sequential test
vegan::adonis(comm.log.mGow.transform ~  sampled_area_norm + percent_water_norm + temperature_norm + wave_energy_norm + rugosity_norm + depth_norm + fishing_effort_norm+ treatment, 
              data = env_dat_per_site, 
              #permutations = by_site, 
              strata = env_dat_per_site$site,
              by = "term", 
              add = "lingoes", 
              model = "reduced", 
              method = "altGower")


# Test using only treatment nested in each sampling site (matched_site_id)
#Here is where nesting becomes important!
##PERMANOVA by  term: sequential test
vegan::adonis(comm.log.mGow.transform ~  matched_site_id/treatment, 
              data = env_dat_per_site, 
              #permutations = by_site, 
              strata = env_dat_per_site$matched_site_id,
              by = "term", 
              add = "lingoes", 
              model = "reduced", 
              method = "altGower")
# See how function in vegan {permute}
##################################################
aldabra_areas <- as_factor(c("Aldabra East", "Aldabra North", "Aldabra South", "Aldabra West"))
## permutation design
by_site <- how(within = Within(type = "free"),
               blocks = Blocks(strata = env_dat_per_site$site,
               nperm =  999))
# h <- how(blocks = env$block, nperm = 999)
by_site <- how(blocks = env_dat_per_site$site, nperm =  999)

#overall test (needs doing in adonis2)
vegan::adonis2(comm.log.mGow.transform ~ sampled_area_norm + percent_water_norm + temperature_norm + wave_energy_norm + rugosity_norm + depth_norm + treatment , 
               data = env_dat_per_site, 
               #blocks = env_dat_per_site$site, 
               permutations = by_site,# permutations = 999, 
               # by = NULL, 
               method = "altGower",
               add = "lingoes",  
               model = "reduced"
               ) # note normalised env vars used. use vegan::decostand(data, method = "normalize")
# you also need to explore the new variables: reef zone, habitat, fishing_effort, habitat rugosity, live cover

# Error in check(sn, control = control, quietly = quietly) : 
#   Number of observations and length of Block 'strata' do not match.
env_dat_per_site %>% dplyr::group_by(site, treatment) %>% dplyr::summarise(n()) # Not clear why - because this shows that there are 30 per site, totalling 120, and ther eare 120 in comm.log.mGow.transform, with 15 of each treatment
comm.log.mGow.transform

#overall test
vegan::adonis2(dis.mgow.lb10 ~ sampled_area_norm + percent_water_norm + temperature_norm + wave_energy_norm + rugosity_norm + depth_norm + treatment , 
               data = env_dat_per_site, 
               #blocks = ,env_dat_per_site$site 
               permutations = by_site, 
               #by = "term", 
               method = "altGower",
               add = "lingoes",  
               model = "full"
)

#overall test
vegan::adonis(dis.mgow.lb10 ~ sampled_area_norm + percent_water_norm + temperature_norm + wave_energy_norm + rugosity_norm + depth_norm + treatment, 
               data = env_dat_per_site, 
               #blocks = ,env_dat_per_site$site 
               permutations = by_site, 
               #by = "term", 
               method = "altGower",
               add = "lingoes",  
               model = "full"
)
