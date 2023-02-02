# aim: read in and clean the raw data
library(tidyverse) 

# READ 
# Read data in (latest data set
raw_dat <- read_rds("./data/fish.df4.rds")



# CLEAN
## CORRECT REEF ZONE
# There were  a few empty cells with no data in the reef zone for site opcode: 13-10-22_ALD_W_256_#3 which should be 'base'
# gap fill missing values FOR REEF ZONE - Now corrected!
raw_dat <- raw_dat %>% mutate(
  reef_zone = if_else(opcode == '13-10-22_ALD_W_256_#3',"base",as.character(reef_zone))
) #13-10-22_ALD_W_256_#3


## CORRECT HABITAT (MAJOR/BROADSCALE) 
# Change the habitat benthic cover types that are "Deep Water" to their most apropriate habitat type
maj.hab.rplc.df = read.csv ("./scripts/maj_hab_deepwater_replacement_20171122.csv", stringsAsFactors=F)
names(maj.hab.rplc.df) <- c("opcode", "maj.hab.rplc")
#maj.hab.rplc$maj.hab.rplc <- as.character(maj.hab.rplc$maj.hab.rplc)
#maj.hab.rplc$opcode <- as.character(maj.hab.rplc$opcode)
raw_dat$habitat <- as.character(raw_dat$habitat)
#str(raw_dat_cln, list.len=ncol(raw_dat_cln))
#str(raw_dat_cln$habitat)

raw_dat_cln <- left_join(raw_dat,maj.hab.rplc.df, by = "opcode")
#str(raw_dat_cln$maj.hab.rplc)
#str(raw_dat_cln$habitat)

raw_dat_cln %>% distinct(habitat, maj.hab.rplc)

raw_dat_cln <- within(raw_dat_cln, habitat[habitat == "Deep water" & maj.hab.rplc == "Sand"] <- "Sand")
raw_dat_cln <- within(raw_dat_cln, habitat[habitat == "Deep water" & maj.hab.rplc == "Hard coral"] <- "Hard coral")
raw_dat_cln <- within(raw_dat_cln, habitat[habitat == "Deep water" & maj.hab.rplc == "Rubble"] <- "Rubble")
raw_dat_cln$habitat <- as.factor(raw_dat_cln$habitat)
raw_dat_cln <- within(raw_dat_cln, rm(maj.hab.rplc))
raw_dat_cln %>% distinct(habitat)
rm(maj.hab.rplc.df)
