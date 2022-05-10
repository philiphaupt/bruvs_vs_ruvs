# Title: Test if the number of species per site are significantly different between baited and unbaited treatments at spatially matched sites
# Date: 207-05-30
# Author: Phil

# Objective: TEST FOR SIGNIFICANT DIFFERENCE BETWEEN the number of species in two treatments:

#read data
fish.df3 <- readRDS("E:/stats/aldabra/BRUVs/01_prep_data/03_schooling_species/output/data/fishdf3.rds") # reads data from cleaned emob and database,saved in RDS format


paired.nsp.per.troph <- fish.df3 %>% dplyr::filter(project_name == "Aldabra Baseline", !is.na(partnerID) == TRUE) %>%
        dplyr::select(opcode = emopcode_db, species = vsppname, pres.abs, treatment = comment, partnerID) %>%
        dplyr::group_by(opcode, treatment, partnerID) %>%
        summarise(number.of.species = sum(pres.abs)) %>%
        arrange(partnerID)


#summary of data
summary(paired.nsp.per.troph$number.of.species[paired.nsp.per.troph$treatment == "baited"])
SE(paired.nsp.per.troph$number.of.species[paired.nsp.per.troph$treatment == "baited"])
summary(paired.nsp.per.troph$number.of.species[paired.nsp.per.troph$treatment == "unbaited"])
SE(paired.nsp.per.troph$number.of.species[paired.nsp.per.troph$treatment == "unbaited"])



#test for normality
par(mfrow = c(2,2))
qqnorm(paired.nsp.per.troph$number.of.species) # data not normal - remove zero counts using filter - now embedded
qqline(paired.nsp.per.troph$number.of.species,lty=2)
boxplot(paired.nsp.per.troph$number.of.species)
hist(paired.nsp.per.troph$number.of.species)
plot(paired.nsp.per.troph$number.of.species)
shapiro.test(paired.nsp.per.troph$number.of.species) # data are not normal, p is significant


#Shapiro-Wilk normality test

#data:  paired.nsp.per.troph$number.of.species
#W = 0.94783, p-value = 0.0001313



#Test variance are homoscedastic using Fisher test.
var.test(paired.nsp.per.troph$number.of.species[paired.nsp.per.troph$treatment == "baited"], paired.nsp.per.troph$number.of.species[paired.nsp.per.troph$treatment == "unbaited"])

#	F test to compare two variances

#data:  paired.nsp.per.troph$number.of.species[paired.nsp.per.troph$treatment == "baited"] and paired.nsp.per.troph$number.of.species[paired.nsp.per.troph$treatment == "unbaited"]
#F = 0.94389, num df = 60, denom df = 60, p-value = 0.8238
#alternative hypothesis: true ratio of variances is not equal to 1
#95 percent confidence interval:
#        0.5662924 1.5732687
#sample estimates:
#        ratio of variances 
#0.9438909 

### Not significantly different variance, means you can still use Wilcoxon-pairwise, and, RUVS slightly higher variance

pairwise.wilcox.test(paired.nsp.per.troph$number.of.species, g = paired.nsp.per.troph$treatment, paired = TRUE, conf.level = 0.95, alternative = c("two.sided"))
#	Pairwise comparisons using Wilcoxon signed rank test 

#data:  paired.nsp.per.troph$number.of.species and paired.nsp.per.troph$treatment 

#       baited
#unbaited 0.32  

#P value adjustment method: holm


### Not significantly different number of species