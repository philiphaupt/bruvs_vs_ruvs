# AIM: To test the distribution of MaxN data for the BRUVS and RUVs
# Author: Philip Haupt
# Date: 2020-05-10

# libraries
library(tidyverse)

# Read data in
raw_dat <- read_rds("./data/raw/fish.df4.rds")

# Filter to the BRUVs vs RUVs data set and Select fields needed to determine MaxN distribution
subset_dat <- raw_dat %>%
        filter(project_name == "Aldabra Baseline",
               analysed == "TRUE") %>%
        select(
                opcode,
                matched_pair_id = partnerID,
                treament = comment,
                # maxn,
                maxn.sr # Abundance per species restricted to a maximum of 44 *
                # trophwip4
        ) %>% 
        drop_na(matched_pair_id)

# Determine TOTAL MaxN per sample using max.sr (which has an upper limit of 44)
sample_dat <- subset_dat %>% group_by(matched_pair_id,
                                      opcode,
                                      treament) %>%
        summarise(total_maxn_per_sample = sum(maxn.sr))

# Plot the data distributions for total_maxn_per_sample for each of the treaments
# for (i in seq(along(levels(sample_dat$treament))) {
#         sample_dat[sample_dat$treament[i]] %>% 
#                 ggplot(aes(x = total_maxn_per_sample))+
#                 ggplot2::geom_density()
#                 
# }

# Baited normality tests
sample_dat %>% 
        filter(treament == "baited") %>% 
        ggplot(aes(x = total_maxn_per_sample))+
        ggplot2::geom_density()


sample_dat %>% 
        filter(treament == "baited") %>% 
        ggplot(aes(sample = total_maxn_per_sample))+
        stat_qq() +
        ggplot2::geom_qq_line()

# Baited sample data
baited_sample_dat <- sample_dat %>% 
        filter(treament == "baited") %>%
        ungroup() %>% 
        select(total_maxn_per_sample) 
# test for normality with  p> 0.05 being not significantly differnt from normal and p <0.05, the data are significantly different from Normal
shapiro.test(baited_sample_dat$total_maxn_per_sample)


# UNBAITED
# UNbaited sample data
unbaited_sample_dat <- sample_dat %>% 
        filter(treament == "unbaited") %>%
        ungroup() %>% 
        select(total_maxn_per_sample) 


sample_dat %>% 
        filter(treament == "unbaited") %>% 
        ggplot(aes(sample = total_maxn_per_sample))+
        stat_qq() +
        ggplot2::geom_qq_line()


sample_dat %>% 
        filter(treament == "unbaited") %>% 
        ggplot(aes(x = total_maxn_per_sample))+
        ggplot2::geom_density()

# test for normality with  p> 0.05 being not significantly differnt from normal and p <0.05, the data are significantly different from Normal
shapiro.test(unbaited_sample_dat$total_maxn_per_sample)

# Paired t test
# prep t test dat
t.test(x = sample_dat$total_maxn_per_sample[sample_dat$treament == "baited"], y = sample_dat$total_maxn_per_sample[sample_dat$treament == "unbaited"], paired = TRUE, alternative = "two.sided")
t.test(x = baited_sample_dat$total_maxn_per_sample, y = unbaited_sample_dat$total_maxn_per_sample, paired = TRUE, alternative = "two.sided")
pairwise.t.test(sample_dat$total_maxn_per_sample, 
                g = sample_dat$treament, 
                paired = TRUE, 
                alternative = "two.sided")
