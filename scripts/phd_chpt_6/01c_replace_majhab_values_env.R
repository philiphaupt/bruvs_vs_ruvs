# Change the majhab benthic cover types that are "Deep Water" to their most apropriate habitat type

maj.hab.rplc.df = read.csv ("./scripts/phd_chpt_6/maj_hab_deepwater_replacement_20171122.csv", stringsAsFactors=F)
names(maj.hab.rplc.df) <- c("opcode", "maj.hab.rplc")
#maj.hab.rplc$maj.hab.rplc <- as.character(maj.hab.rplc$maj.hab.rplc)
#maj.hab.rplc$opcode <- as.character(maj.hab.rplc$opcode)
env.df.2.or$majhab <- as.character(env.df.2.or$majhab)
#str(env.df.2.or, list.len=ncol(env.df.2.or))
#str(env.df.2.or$majhab)

env.df.2.or <- left_join(env.df.2.or,maj.hab.rplc.df, by = "opcode")
str(env.df.2.or$maj.hab.rplc)
str(env.df.2.or$majhab)

env.df.2.or %>% group_by(majhab) %>% distinct(majhab, maj.hab.rplc)

env.df.2.or <- within(env.df.2.or, majhab[majhab == "Deep water" & maj.hab.rplc == "Sand"] <- "Sand")
env.df.2.or <- within(env.df.2.or, majhab[majhab == "Deep water" & maj.hab.rplc == "Hard coral"] <- "Hard coral")
env.df.2.or <- within(env.df.2.or, majhab[majhab == "Deep water" & maj.hab.rplc == "Rubble"] <- "Rubble")
env.df.2.or$majhab <- as.factor(env.df.2.or$majhab)
env.df.2.or <- within(env.df.2.or, rm(maj.hab.rplc))
env.df.2.or %>% group_by(majhab)%>% distinct(majhab)
rm(maj.hab.rplc.df)
saveRDS(env.df.2.or, "E:/stats/aldabra/BRUVs/04_fish_hab/env.df.2.or.RDS", ascii = T, compress = F)
