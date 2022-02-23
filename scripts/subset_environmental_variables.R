library(tidyverse)
# Filter to the BRUVs vs RUVs data set and Select fields needed to determine MaxN distribution
env_dat_susbet_long <- dat_subset_long_cln %>%
  select(
    site,
    opcode, # individual sample ID
    matched_site_id,# coupled/matched pairs of BRUVs & RUVs
    treatment, # change the comment field to treatment (what it actually contains)
    # environmental
    reef_zone,# needs recoding to zones used in analysis
    depth,
    temperature, # water temperature
    wave_energy,
    # other variables    
    sampled_area,
    percent_water_column,
    #------remaining variables to check.
    # circular_angle = to be added.
    habitat, # check representation? if not goo d enough use geomorphic reef zones
    #b_cl_6,
    habitat_rugosity, # check if done for ALL samples
    livecover,
    fishing_effort
  )  %>% mutate(depth_norm = depth/(max(depth)),
                rugosity_norm = habitat_rugosity/30, # recode habitat rugosity and live cover to 0 - 1 numerical values
                livecover_norm = livecover/5,
                temperature_norm = temperature/(max(temperature)), # water temperature
                wave_energy_norm = wave_energy/(max(wave_energy)),
                fishing_effort_norm = fishing_effort/(max(fishing_effort)),
                # other variables    
                sampled_area_norm = sampled_area/sampled_area/(max(sampled_area)),
                percent_water_norm = percent_water_column/(max(percent_water_column)),) %>% 
  select(-depth, -habitat_rugosity, -livecover, -fishing_effort, -temperature,-wave_energy,-sampled_area, -percent_water_column)



env_dat_per_site <- env_dat_susbet_long %>% distinct() %>% arrange(opcode) # it is neccessary to arange by opcode, becuase the matrix for species etc, is automatically arranged by opcode which becomes the row name!
