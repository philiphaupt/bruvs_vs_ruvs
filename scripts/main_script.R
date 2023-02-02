# main script
rm(list = ls())
#clean the major habitat categories, like in the example below.*

# this script calls the scripts n a sequence to help workflow and void huge long scripts

# Common libraries
library(tidyverse)
## SECTION - PRESTART: DATA READING AND CLEANING
source("./scripts/read_clean_raw_data.R")
rm(raw_dat)

#Subset data for analysis - which columns to include, and assign new easy to use names.
source("./scripts/subset_data_for_analysis.R") 
#-------------------------------------------------------------
## SECTION 1) GAMM analysis - this may be saved as a separate project for each component??

### Prepare the data for gamm analysis


### Data cleaning - as in PhD - replace major habitat values that are coded as Deep Water to correct habitats if there wasa more suitable alternative
# major habitat type replacement: Replace Deep water with actual benthic cover/appears as numerical values rather than the actual values
# file.edit("./scripts/replace_majhab_values_comm_matrix.R") NOT NEEDED ANYMORE - cleaned earleir - delete script



#-------------------------------------------------
# SECTION 2: Community analysis
# Below shows how the data was prepared.
source("./scripts/read_data_generate_community_matrices.R")

## Further Data preparation (TO DO: if gamm and community analysis are the same, this step can be movedearleir and done once!)
# Subset environmental variables and simplify unique to each site- for community analysis that uses vegan as writing equations easier when these are in different data frames.
source("./scripts/subset_environmental_variables.R")
# Check reef zone for 3-10-22_ALD_W_256_#3 - complete it in the file itself, then see next:

# note to self: Data should now be prepared, and I should be able to start analysis: date: 20/02/2022
#-------------------------------------------------------------

# Log transform community matrix - required for (Modified) Alt Gower analysis
source("./scripts/log_transform_community_matrix.R") # See note re outlier - reducing sample size by one paired sample, as comment from PhD.
# Create a community dissimilarity matrix
source("./scripts/dissimilarity_distance.R")
# PCO ordination
source("./scripts/ordination_pco.R", echo = TRUE)

#PERMANOVA using adonis2
file.edit("./scripts/permanova_analysis.r")





