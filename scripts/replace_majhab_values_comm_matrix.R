# Change the habitat benthic cover types that are "Deep Water" to their most apropriate habitat type

maj.hab.rplc.df = read.csv ("./scripts/maj_hab_deepwater_replacement_20171122.csv", stringsAsFactors=F)
names(maj.hab.rplc.df) <- c("opcode", "maj.hab.rplc")
#maj.hab.rplc$maj.hab.rplc <- as.character(maj.hab.rplc$maj.hab.rplc)
#maj.hab.rplc$opcode <- as.character(maj.hab.rplc$opcode)
subset_dat$habitat <- as.character(subset_dat$habitat)
#str(dat_subset_long_cln, list.len=ncol(dat_subset_long_cln))
#str(dat_subset_long_cln$habitat)

dat_subset_long_cln <- left_join(subset_dat,maj.hab.rplc.df, by = "opcode")
#str(dat_subset_long_cln$maj.hab.rplc)
#str(dat_subset_long_cln$habitat)

dat_subset_long_cln %>% distinct(habitat, maj.hab.rplc)

dat_subset_long_cln <- within(dat_subset_long_cln, habitat[habitat == "Deep water" & maj.hab.rplc == "Sand"] <- "Sand")
dat_subset_long_cln <- within(dat_subset_long_cln, habitat[habitat == "Deep water" & maj.hab.rplc == "Hard coral"] <- "Hard coral")
dat_subset_long_cln <- within(dat_subset_long_cln, habitat[habitat == "Deep water" & maj.hab.rplc == "Rubble"] <- "Rubble")
dat_subset_long_cln$habitat <- as.factor(dat_subset_long_cln$habitat)
dat_subset_long_cln <- within(dat_subset_long_cln, rm(maj.hab.rplc))
dat_subset_long_cln %>% distinct(habitat)
rm(maj.hab.rplc.df)

