#Generate community matrices

# dat_subset_long_cln <- read_csv("./data/clean_data/aldabra_bruvs_vs_ruvs_data.csv")
dat_subset_long_cln$tsize_trophic_grp <- as.factor(paste(dat_subset_long_cln$Class,dat_subset_long_cln$size.class.2, sep = "."))

# major habitat type replacement: Replace Deep water with actual benthic cover
file.edit("./scripts/community_analysis/01b_replace_majhab_values_comm_matrix.R") 

#names(dat_subset_long_cln)
#subset species data
bruvs.df <- dat_subset_long_cln %>% filter(comment == "baited") %>% dplyr::select(opcode, species = vsppname, family, taxa.class_size.class = tsize_trophic_grp, taxa.class_guild_size.class = troph.class.size.2, trophic.guild = trophwip4, maxn = maxn.sr, ) %>% dplyr::arrange(opcode)
ruvs.df <- dat_subset_long_cln %>% filter(comment == "unbaited") %>% dplyr::select(opcode, species = vsppname, family, taxa.class_size.class = tsize_trophic_grp, taxa.class_guild_size.class = troph.class.size.2,trophic.guild = trophwip4, maxn = maxn.sr) %>% dplyr::arrange(opcode)

#species community matrix
spe.comm.b <- reshape2::acast(data = bruvs.df, opcode ~ species, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
write_rds(spe.comm.b, "./data/community_data/spe.comm.b.RDS")
spe.comm.r <- reshape2::acast(data = ruvs.df, opcode ~ species, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
write_rds(spe.comm.r, "./data/community_data/spe.comm.r.RDS")


#size-class community matrix
size.class.comm.b <- reshape2::acast(data = bruvs.df, opcode ~ taxa.class_size.class, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
write_rds(size.class.comm.b, "./data/community_data/size.class.comm.b.RDS")
size.class.comm.r <- reshape2::acast(data = ruvs.df, opcode ~ taxa.class_size.class, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
write_rds(size.class.comm.r, "./data/community_data/size.class.comm.r.RDS")

#fish guild community
guild.comm.b <- reshape2::acast(data = bruvs.df, opcode ~ trophic.guild, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
write_rds(guild.comm.b, "./data/community_data/guild.comm.b.RDS")
guild.comm.r <- reshape2::acast(data = ruvs.df, opcode ~ trophic.guild, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
write_rds(guild.comm.r, "./data/community_data/guild.comm.r.RDS")

# Combined taxonomic class, guild and size class community
class.guild.size.comm.b <- reshape2::acast(data = bruvs.df, opcode ~ taxa.class_guild_size.class, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
write_rds(class.guild.size.comm.b, "./data/community_data/class.guild.size.comm.b.RDS")
class.guild.size.comm.r <- reshape2::acast(data = ruvs.df, opcode ~ taxa.class_guild_size.class, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
write_rds(class.guild.size.comm.r, "./data/community_data/class.guild.size.comm.r.RDS")

#read environmental data
env.df.2.or <- read_rds("./data/community_data/raw/env.df.2.or.RDS") #%>% arrangge(opcode)
# major habitat type replacement: Replace Deep water with actual benthic cover
source("./scripts/community_analysis/01c_replace_majhab_values_env_20220802.R") 
env_df_2_or %>% group_by(majhab)%>% distinct(majhab) # check there are no deep water values

env.factors <- env_df_2_or[,c(1:6,14,40)]
env.factors$reef.zone <- as.factor(env.factors$reef.zone)
env.c.vars.std.or <- read_rds("./data/community_data/env.c.vars.std.or.RDS") #%>% arrange()
env.tmp <- env.c.vars.std.or
env.tmp$opcode <- row.names(env.c.vars.std.or)
env.perm <- left_join(env.factors, env.tmp, by = "opcode") 
env.perm <- env.perm %>% rename(medium.benthic.cover = majhab, fishing.effort = f_effort, percent.water.column = perc.water.column, fine.benthic.cover = p.tree.cl12)
env.perm.b <- env.perm %>% filter(treatment == "baited")
env.perm.r <- env.perm %>% filter(treatment == "unbaited")



rm(env.tmp)
