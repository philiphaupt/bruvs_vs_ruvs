# Aim: Prepare data to send to Ant: select subset of the data, only matched pairs (61 paired samples), long format: species, abundance, trophic group, trophic-size group, sampled area, water column, temperature, depth, geomorphic zones, wave energy, ...

library(tidyverse) 

# Read data in (most advanced)
raw_dat <- read_rds("./data/fish.df4.rds")

# There were  a few empty cells with no data in the reef zone for site opcode: 13-10-22_ALD_W_256_#3 which should be 'base'
# gap fill missing values FOR REEF ZONE
raw_dat <- raw_dat %>% mutate(
  reef_zone = ifelse(opcode == '13-10-22_ALD_W_256_#3',"base",reef_zone)
)

fields <- raw_dat %>% names() %>% as_tibble() %>% arrange(desc(value))
# Filter to the BRUVs vs RUVs data set and Select fields needed to determine MaxN distribution
subset_dat <- raw_dat %>%
  filter(project_name == "Aldabra Baseline", # i.e. not tidal data study
         analysed == "TRUE") %>% # has to have been analysed
  select(
    date_sampled = Start.date,
    site,
    opcode, # individual sample ID
    matched_site_id = partnerID,# coupled/matched pairs of BRUVs & RUVs
    treatment = comment, # change the comment field to treatment (what it actually contains)
    species = vsppname,
    class = Class,
    trophic_group = trophwip4,
    size_trophic_grp = troph.class.size.2, #combination of class, size and trophic group
    maxn_sr  = maxn.sr,# Abundance per species restricted to a maximum of 44 *
# environmental
    reef_zone,# needs recoding to zones used in analysis
    depth,
    temperature, # water temperature
    wave_energy = we2_mean,
# other variables    
    sampled_area = sample.area,
    percent_water_column = perc_water_column,
    #------remaining variables to check.
    # circular_angle = to be added.
    habitat = majhab, # check representation? if not goo d enough use geomorphic reef zones
    #b_cl_6,
    habitat_rugosity = has_score, # check if done for ALL samples
    livecover,
    fishing_effort = f_effort # fishing effort ?
    # maxn, # raw maxn data - not included
    # species, abundance, trophic group, trophic-size group, sampled area, water column, temperature, depth, geomorphic zones, wave energy, ...
  ) %>% drop_na(matched_site_id) # removes samples that do not have a matched pairs ID number (these were assigned during data entry in GIS)



#---------Clean data: Replace deepwater values as done in Phd analysis
# Change the majhab benthic cover types that are "Deep Water" to their most apropriate habitat type
# maj.hab.rplc.df = read.csv ("./data/community_data/maj_hab_deepwater_replacement_20171122.csv", stringsAsFactors=F)
# names(maj.hab.rplc.df) <- c("opcode", "maj.hab.rplc")#make names same as table that you want to join to
# 
# subset_dat$habitat <- as.character(subset_dat$habitat)
# 
# tmp_df<- left_join(subset_dat,maj.hab.rplc.df, by = "opcode")
# #str(dat_df_2_or$maj.hab.rplc)
# #str(dat_df_2_or$majhab)
# 
# tmp_df %>% distinct(habitat, maj.hab.rplc)
# 
# dat_subset_long_cln <- within(tmp_df, habitat[habitat == "Deep water" & maj.hab.rplc == "Sand"] <- "Sand")
# dat_subset_long_cln <- within(dat_subset_long_cln, habitat[habitat == "Deep water" & maj.hab.rplc == "Hard coral"] <- "Hard coral")
# dat_subset_long_cln <- within(dat_subset_long_cln, habitat[habitat == "Deep water" & maj.hab.rplc == "Rubble"] <- "Rubble")
# dat_subset_long_cln$habitat <- as.factor(dat_subset_long_cln$habitat)
# dat_subset_long_cln <- within(dat_subset_long_cln, rm(maj.hab.rplc))
# dat_subset_long_cln %>% distinct(habitat)
# rm(maj.hab.rplc.df, subset_dat, tmp_df, raw_dat, fields)
# print("dat_subset_long_cln is the object to take forward. It can be used as is forthe gamm analysis. it is along format, cleaned version, only containing data from the paired samples. This should also be the basis for the multivariate analysis.")
# 
# 
# dat_subset_long_cln <- dat_subset_long_cln %>% mutate(geomorphic_reef_zone = ifelse(reef_zone == "", "base", as.character(reef_zone)))
# 
# # INSPECT DATA
# # NOT RUN {
# # check representation per habitat cover
# dat_subset_long_cln %>% group_by(habitat) %>% summarise(number_fish = n())
# dat_subset_long_cln %>% select(opcode, habitat) %>% distinct() %>%  group_by(habitat) %>% summarise(number_samples = n())
# dat_subset_long_cln %>% select(opcode, livecover) %>% distinct() %>%  group_by(livecover) %>% summarise(number_samples = n())
# dat_subset_long_cln %>% select(opcode, habitat_rugosity) %>% distinct() %>%  group_by(habitat_rugosity) %>% summarise(number_samples = n())
# dat_subset_long_cln %>% select(opcode, treatment, geomorphic_reef_zone) %>% distinct() %>%  group_by(treatment,geomorphic_reef_zone) %>% summarise(number_samples = n())
# 
# dat_subset_long_cln %>% select(opcode, treatment) %>% distinct() %>%  group_by(treatment) %>% summarise(number_samples = n())
# 
# 
# 
# #---
# # write data
# write_excel_csv(dat_subset_long_cln, "./data/clean_data/aldabra_bruvs_vs_ruvs_data.csv")
