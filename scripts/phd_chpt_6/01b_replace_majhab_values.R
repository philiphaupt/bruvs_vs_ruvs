# Change the majhab benthic cover types that are "Deep Water" to their most apropriate habitat type
library(dplyr)

maj.hab.rplc.df = read.csv ("./data/community_data/maj_hab_deepwater_replacement_20171122.csv", stringsAsFactors=F)
names(maj.hab.rplc.df) <- c("opcode", "maj.hab.rplc")
#maj.hab.rplc$maj.hab.rplc <- as.character(maj.hab.rplc$maj.hab.rplc)
#maj.hab.rplc$opcode <- as.character(maj.hab.rplc$opcode)
dat_df_2_or$majhab <- as.character(dat_df_2_or$majhab)
#str(dat_df_2_or, list.len=ncol(dat_df_2_or))
#str(dat_df_2_or$majhab)

dat_df_2_or <- left_join(dat_df_2_or,maj.hab.rplc.df, by = "opcode")
#str(dat_df_2_or$maj.hab.rplc)
#str(dat_df_2_or$majhab)

dat_df_2_or %>% distinct(majhab, maj.hab.rplc)

dat_df_2_or <- within(dat_df_2_or, majhab[majhab == "Deep water" & maj.hab.rplc == "Sand"] <- "Sand")
dat_df_2_or <- within(dat_df_2_or, majhab[majhab == "Deep water" & maj.hab.rplc == "Hard coral"] <- "Hard coral")
dat_df_2_or <- within(dat_df_2_or, majhab[majhab == "Deep water" & maj.hab.rplc == "Rubble"] <- "Rubble")
dat_df_2_or$majhab <- as.factor(dat_df_2_or$majhab)
dat_df_2_or <- within(dat_df_2_or, rm(maj.hab.rplc))
dat_df_2_or %>% distinct(majhab)
rm(maj.hab.rplc.df)
