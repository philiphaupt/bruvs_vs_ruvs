# main script
rm(list = ls())
#clean the major habitat categories, like in teh example below.*

# this script calls the scripts n a sequence to help workflow and void huge long scripts

#Common libraries
library(tidyverse)

## SECTION 1) GAMM analysis - this amy be saved as a separate project for each component??

# Prepare the data
source("./scripts/subset_data_for_gamm_analysis.R") 

# Data cleaning - as in phd - replace major habitat values taht are coded as Deep Water to correct habitats if there wasa more suitable alternative
# major habitat type replacement: Replace Deep water with actual benthic cover
source("./scripts/replace_majhab_values_comm_matrix.R") 
# see to do
# ISSUE: The data needs reef zone sorting - looking to Chapter 6 data

# SECTION 2: Community analysis
# Below shows how the data was prepared.
source("./scripts/read_data_generate_community_matrices.R")

# Subset environmental variables and simplify unique to each site- for community analysis that uses vegan as writing equations easier when these are in different data frames.
source("./scripts/subset_environmental_variables.R")
# Check reef zone for 3-10-22_ALD_W_256_#3 - complete it in the file itself, then see next:

# Data should now be prepared, and I should be able to start analysis. 20/02/2022

#log transform community matrix - required for Alt Gower analysis
source("./scripts/log_transform_community_matrix.R") # See note re outlier - reducing sample size by one paired sample, as comment from PhD.
# Create a community dissimilarity matrix
source("./scripts/dissimilarity_distance.R")
# PCO ordination
source("./scripts/ordination_pco.R", echo = TRUE)

#PERMANOVA using adonis2
file.edit("./scripts/permanova_analysis.r")



