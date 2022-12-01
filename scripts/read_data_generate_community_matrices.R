#Generate community matrices
# Aim: Create species/trophic group/class-size-trophic group matrices for each

#names(dat_subset_long_cln)
#subset species data
#abundance_dat_subset_long <- dat_subset_long_cln %>% dplyr::select(opcode, species, trophic_group, size_trophic_grp, maxn = maxn_sr ) 
# bruvs.df <- dat_subset_long_cln %>% filter(treatment == "baited") %>% dplyr::select(opcode, species, trophic_group, size_trophic_grp, maxn = maxn_sr ) %>% dplyr::arrange(opcode)
# ruvs.df <- dat_subset_long_cln %>% filter(treatment == "unbaited") %>% dplyr::select(opcode, species, trophic_group, size_trophic_grp, maxn = maxn_sr) %>% dplyr::arrange(opcode)

#species community matrix
species_community_matrix <- reshape2::acast(data = subset_dat, opcode ~ species, fill = 0, value.var = 'maxn_sr', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# spe.comm.b <- reshape2::acast(data = bruvs.df, opcode ~ species, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# write_rds(spe.comm.b, "./data/community_data/spe.comm.b.RDS")
# spe.comm.r <- reshape2::acast(data = ruvs.df, opcode ~ species, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# write_rds(spe.comm.r, "./data/community_data/spe.comm.r.RDS")

#fish TROPHIC GROUP guild community/trophic group
trophic_community_matrix <- reshape2::acast(data = subset_dat, opcode ~ trophic_group, fill = 0, value.var = 'maxn_sr', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# guild.comm.b <- reshape2::acast(data = bruvs.df, opcode ~ trophic_group, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# write_rds(guild.comm.b, "./data/community_data/guild.comm.b.RDS")
# guild.comm.r <- reshape2::acast(data = ruvs.df, opcode ~ trophic_group, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# write_rds(guild.comm.r, "./data/community_data/guild.comm.r.RDS")

# trophic size-class community matrix
size_trophic_community_matrix <- reshape2::acast(data = subset_dat, opcode ~ size_trophic_grp, fill = 0, value.var = 'maxn_sr', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# size.class.comm.b <- reshape2::acast(data = bruvs.df, opcode ~ size_trophic_grp, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# write_rds(size.class.comm.b, "./data/community_data/size.class.comm.b.RDS")
# size.class.comm.r <- reshape2::acast(data = ruvs.df, opcode ~ size_trophic_grp, fill = 0, value.var = 'maxn', fun.aggregate = sum) # critical function to genrate zero values for species not counted, and use sum, for conssitency with methods to aggeregate according to, used in trophic level and combined trophic level.
# write_rds(size.class.comm.r, "./data/community_data/size.class.comm.r.RDS")



