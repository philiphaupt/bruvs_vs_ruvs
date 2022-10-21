# species list

library(tidyverse) 

# Read data in (most advanced)
raw_dat <- read_rds("./data/fish.df4.rds")

species_list <- raw_dat %>% distinct(vsppname) %>% rename(species = vsppname) %>% arrange(species)


write_csv(species_list, "./data/species_list_result.csv")
