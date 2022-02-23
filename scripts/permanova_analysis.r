# PERMANOVA SPECIES LEVEL --- see data exploration  - this is a repeat of what was done in data exploration, but here normalised environmental variables were used.
library(vegan)

#Here is where nesting becomes important!

#overall test
vegan::adonis2(dis.mgow.lb10 ~ sampled_area_norm + percent_water_norm + temperature_norm + wave_energy_norm + rugosity_norm + depth_norm + treatment , 
               data = env_dat_per_site, 
               blocks = env_dat_per_site$matched_site_id, 
               permutations = by_site,# permutations = 999, 
               by = NULL, 
               method = "altGower",
               add = "lingoes",  
               model = "reduced"
               ) # note normalised env vars used. use vegan::decostand(data, method = "normalize")
# you also need to explore the new variables: reef zone, habitat, fishing_effort, habitat rugosity, live cover
# See how function in vegan {permute}
##################################################
## permutation design
by_site <- how(#within = Within(type = "free"),
          blocks = Blocks(strata = env_dat_per_site$site),#type = "series"
          #plots = NA,
          nperm =  999)

##PERMANOVA by  term: sequential test

vegan::adonis2(dis.mgow.lb10 ~  sampled_area_norm + percent_water_norm + temperature_norm + wave_energy_norm + rugosity_norm + depth_norm + fishing_effort_norm+ treatment, 
               data = env_dat_per_site, 
               permutations = by_site, 
               by = "term", 
               add = "lingoes", 
               model = "reduced", 
               method = "AltGower")
env_dat_per_site$matched_site_id

#
#overall test
vegan::adonis2(dis.mgow.lb10 ~ sampled_area_norm + percent_water_norm + temperature_norm + wave_energy_norm + rugosity_norm + depth_norm + treatment , 
               data = env_dat_per_site, 
               blocks = env_dat_per_site$matched_site_id, 
               permutations = 999, 
               by = "term", 
               method = "altGower",
               add = "lingoes",  
               model = "full"
)

