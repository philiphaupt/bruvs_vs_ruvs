#Prepare data for PRIMER and PERMANOVA

library("tidyverse")
env_dat_per_site %>% names()
env_dat_per_site %>% group_by(reef_zone) %>% count() # exclude
env_dat_per_site %>% group_by(habitat) %>% count() # exclude
env_dat_primer <- env_dat_per_site %>% select(-c(reef_zone,habitat)
  
)


# community matrices:
# include site name as column for export data 
#species
species_community_df <- species_community_matrix %>% as.data.frame()
species_community_df$opcode <- row.names(species_community_df)
species_community_df <- species_community_df %>% as_tibble()

# size trophic community
size_trophic_community_df <- size_trophic_community_matrix %>% as.data.frame()
size_trophic_community_df$opcode <- row.names(size_trophic_community_df)
size_trophic_community_df <- size_trophic_community_df %>% as_tibble()
# write data to file csv for primer
write_excel_csv(env_dat_primer, "./data/primer/env_dat_primer.csv")
write_excel_csv(species_community_df, "./data/primer/species_community_primer.csv")
write_excel_csv(size_trophic_community_df, "./data/primer/size_trophic_community_primer.csv")
