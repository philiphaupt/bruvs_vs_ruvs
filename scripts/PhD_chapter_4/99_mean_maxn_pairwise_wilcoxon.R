######################################################################################
#Hypothesis: Mean MAxN is higher in BRUVs than in RUVs
# overall means per sample including ZERO counts for absent species

# 1. Generate data:
#mean maxn baited
dat.maxn2.sp %>% dplyr::group_by(bait.treatment) %>%
        dplyr::summarise(maxn.trt.total = sum(maxn.sp.sum.vid), count.samples = n(), maxn.trt.mean = mean(maxn.sp.sum.vid), maxn.trt.se = std.error(maxn.sp.sum.vid), maxn.sd = sd(maxn.sp.sum.vid), max.maxn = max(maxn.sp.sum.vid)) %>%
        arrange(desc(maxn.trt.total), bait.treatment)

# generate data: if you want to exclude schooling species, set maxn <= 44 earlier where dat.maxn2.sp is created
tmp.opcodes <- dplyr::select(fish.df3, opcode = emopcode_db, partnerID) %>% distinct()
t.test.dat <- dplyr::left_join(dat.maxn2.sp, tmp.opcodes, by = "opcode") %>% group_by(opcode, partnerID, bait.treatment) %>% summarise(maxn = sum(maxn.sp.sum.vid)) %>% arrange(partnerID)

#
#remove outliers: schooling species and zero counts.
#t.test.dat <- dplyr::left_join(dat.maxn2.sp, tmp.opcodes, by = "opcode") %>% filter(maxn.sp.sum.vid > 0) %>% group_by(opcode, partnerID, bait.treatment) %>% summarise(maxn = sum(maxn.sp.sum.vid)) %>% arrange(partnerID)

library(vegan)
t.test.dat$maxn.log10 <- decostand(t.test.dat$maxn, logbase = 10, method = "log")

#summary of data
summary(t.test.dat$maxn.log10[t.test.dat$bait.treatment == "baited"])
SE(t.test.dat$maxn.log10[t.test.dat$bait.treatment == "baited"])
summary(t.test.dat$maxn.log10[t.test.dat$bait.treatment == "unbaited"])
SE(t.test.dat$maxn.log10[t.test.dat$bait.treatment == "unbaited"])
#test for normality
qqnorm(t.test.dat$maxn.log10) # data not normal - remove zero counts using filter - now embedded
shapiro.test(t.test.dat$maxn.log10) # data not normal - remove zero counts using filter - now embedded


#test for normality again
par(mfrow = c(2,2))
qqnorm(t.test.dat$maxn.log10)
qqline(t.test.dat$maxn.log10,lty=2)
boxplot(t.test.dat$maxn.log10)
hist(t.test.dat$maxn.log10)
plot(t.test.dat$maxn.log10)
shapiro.test(t.test.dat$maxn.log10) # data still not normal - removed ad repeated without schooling species counts - improved, but still non-normal - need non-parametric test.
#data not normal# CANNOT DO: t.test(x = t.test.dat$maxn.log10[t.test.dat$bait.treatment == "baited"], y = t.test.dat$maxn.log10[t.test.dat$bait.treatment == "unbaited"], paired = TRUE)

#Test variance are homoscedastic using Fisher test.
var.test(t.test.dat$maxn.log10[t.test.dat$bait.treatment == "baited"], t.test.dat$maxn.log10[t.test.dat$bait.treatment == "unbaited"]) # Fisher's test of variance test for homoscedasticity in the variance
#F test to compare two variances 

#data:  t.test.dat$maxn.log10[t.test.dat$bait.treatment == "baited"] and t.test.dat$maxn.log10[t.test.dat$bait.treatment == "unbaited"]
#F = 1.1738, num df = 60, denom df = 60, p-value = 0.5367
#alternative hypothesis: true ratio of variances is not equal to 1
#95 percent confidence interval:
#        0.704254 1.956552
#sample estimates:
#        ratio of variances 
#1.173844 
#THE VARIANCES ARE NOT SIGNIFICANTLY DIFFERENT! I.e the data are homoscedastic. & THE Variance in total maxn is slightly higher in baited videos.

# 4. Test for significance of difference using Wilcox test:
pairwise.wilcox.test(x = t.test.dat$maxn.log10, g = t.test.dat$bait.treatment, paired = TRUE, conf.level = 0.95) # Pairwise, Wilcox test one- sided as hypothesis is that BRUVs will have higher given higher mean.
#Pairwise comparisons using Wilcoxon signed rank test 

#data:  t.test.dat$maxn.log10 and t.test.dat$bait.treatment 

#baited 
#unbaited 1.9e-05

# P value adjustment method: holm
#Results are significantly different at the 0.95 conf interval (CI).
rm(tmp.opcodes, t.test.dat, wct)


##############################################################################