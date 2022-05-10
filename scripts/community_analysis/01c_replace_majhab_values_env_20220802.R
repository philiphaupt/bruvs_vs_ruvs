# Change the majhab benthic cover types that are "Deep Water" to their most apropriate habitat type

maj.hab.rplc.df = read.csv ("./data/community_data/raw/maj_hab_deepwater_replacement_20171122.csv", stringsAsFactors=F)
names(maj.hab.rplc.df) <- c("opcode", "maj.hab.rplc")
#maj.hab.rplc$maj.hab.rplc <- as.character(maj.hab.rplc$maj.hab.rplc)
#maj.hab.rplc$opcode <- as.character(maj.hab.rplc$opcode)
env_df_2_or <- env.df.2.or
env_df_2_or$majhab <- as.character(env_df_2_or$majhab)
#str(env_df_2_or, list.len=ncol(env_df_2_or))
#str(env_df_2_or$majhab)

env_df_2_or <- left_join(env_df_2_or,maj.hab.rplc.df, by = "opcode")
str(env_df_2_or$maj.hab.rplc)
str(env_df_2_or$majhab)

env_df_2_or %>% group_by(majhab) %>% distinct(majhab, maj.hab.rplc)

env_df_2_or <- within(env_df_2_or, majhab[majhab == "Deep water" & maj.hab.rplc == "Sand"] <- "Sand")
env_df_2_or <- within(env_df_2_or, majhab[majhab == "Deep water" & maj.hab.rplc == "Hard coral"] <- "Hard coral")
env_df_2_or <- within(env_df_2_or, majhab[majhab == "Deep water" & maj.hab.rplc == "Rubble"] <- "Rubble")
env_df_2_or$majhab <- as.factor(env_df_2_or$majhab)
env_df_2_or <- within(env_df_2_or, rm(maj.hab.rplc))
env_df_2_or %>% group_by(majhab)%>% distinct(majhab)
rm(maj.hab.rplc.df, env.df.2.or)
write_rds(env_df_2_or, "./data/community_data/env_df_2_or.RDS")
