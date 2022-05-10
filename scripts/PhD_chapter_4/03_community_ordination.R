# Title: Principal coordinate analysis (PCO) - ORDINATION ANALYSIS of relative abundance (MaxN) at the SPECIES LEVEL
# Author: Phil
#Date: 2017-05-26
# Note: NOT AGGEREGATED BY TROPHIC LEVEL!

# Objectives: 1) Generate principal coordinates from distance calculated at species level, using modified Gower distance
#			  2) Generate ordination plot of PCO, including relative contribution of axes (in grey scale), and goodness of fit (GOF)
#			  3) Fit and plot the relative contribution of the environmental variables as vectors on the PCO plot
#			  3) Exlpore PCO plots using the ither distance matrices calculated.


# Libraries
library(vegan)
library(dplyr)

# Read community martix
comm.ald.paired <- readRDS('E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/comm.ald.paired.or.RDS')


# Read dissimilarity matrix (modified Gower, logbase 10) data (resemblance matrix): 
dis.mgow.lb10 <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/community/species_level/output/data/dis.mgow.lb10.rds")

# Read environmental data, and subset continuous set of data to fit to PCO.
#env.vars.norm <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env_ald_paired_vars_continuous_norm.RDS")
# Read environemtnal varaibles to set graphical properties to:
#env.ald.paired <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env_ald_paired.rds")
# Generate environmental variables for PCO ordination
#env.vars.pco$treatment <- env.ald.paired$treatment

env.vars.or.norm <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env.ald.or.norm.RDS")
env.ald.paired <- readRDS("E:/stats/aldabra/BRUVs/02_ALD/environment/output/data/env_ald_paired.RDS")


# Determine Principal Coordinates (PCO) from the above resemblance matrix
pco.dis.mgow.lb10 <- wcmdscale(dis.mgow.lb10, eig = TRUE, add = "lingoes") # make sureto add eigenvectors to allow calculation of axes contributions.

# Calculate pco axes contribution
axis1.contr <- round(pco.dis.mgow.lb10$eig[1]/sum(pco.dis.mgow.lb10$eig)*100,2)
axis2.contr <- round(pco.dis.mgow.lb10$eig[2]/sum(pco.dis.mgow.lb10$eig)*100,2)

# Determine Goodness of Fit (GOF)
pco.dis.mgow.lb10$GOF #(see help file for details)

# Generate graphical properties for pco plot (set shape and colou accrding to bait treatment, in black and white)
pco.lbls <- env.ald.paired %>% dplyr::select(opcode, treatment)
pco.lbls$pch[pco.lbls$treatment == "baited"] <- 0
pco.lbls$pch[pco.lbls$treatment == "unbaited"] <- 16
pco.lbls$clr[pco.lbls$treatment == "baited"] <- "black"
pco.lbls$clr[pco.lbls$treatment == "unbaited"] <- "grey44"

# Plot PCO, with ordiellipses, and relative contributions of environemtnal variables 
png(filename = paste0("E:/stats/aldabra/BRUVs/02_ALD/community/species_level/output/plots/pco_species_ord_plot_mgow_lb10_lingoes_convexhull_bw_",Sys.Date(),".png"), width = 16, height = 16,units = "cm", res = 300)
par(mfrow = c(1,1), mar = c(4.5,4.5,1,1), cex = 1)
plot.pco <- plot(pco.dis.mgow.lb10$points, type = "p",  col=pco.lbls$clr, pch = pco.lbls$pch, xlab = paste("PCO1 (",axis1.contr,"% of total variation)", sep = ""), ylab = paste("PCO2 (",axis2.contr,"% of total variation)", sep = ""), asp = 1/1)
#ordiellipse(pco.dis.mgow.lb10$points, groups = env.ald.paired$treatment, kind = "ehull", conf = 0.95, label = FALSE, col = c("black", "grey44"))
ordihull(pco.dis.mgow.lb10$points,groups = env.vars.or.norm$treatment,label = FALSE, col = c("black", "grey44") )
legend(-0.6,0.59, c("BRUVs (baited)","RUVs (unbaited)"), lty=c(1,1), pch = c(0,16), lwd=c(1.5,1.5),col=c("black","grey44"), cex = 1, bt = "n")
legend(-0.6, 0.51, c("BRUVs (baited) centroid", "RUVs (unbaited) centroid)"), pch = c(18,17), col=c("black","grey70"), cex = 1, bt = "n")
#abline(h = 0, lty = 3) # add dotted zero line
#abline(v = 0, lty = 3) # add dotted zero line

# Fit environmental variables (continuous data) to PCO

env.fit <- envfit(pco.dis.mgow.lb10, env.vars.or.norm[-6], perm = 4999); env.fit #KEY function to add environemtnal fit!!
plot(env.fit, col = "blue", cex = 0.75)
points(x = c(0.0180,-0.0180),y = c(0.0394, -0.0394), col = c("black","grey70"), pch = c(18,17), cex = 2)
# test significance of all env values
env.fit <- envfit(pco.dis.mgow.lb10, env.vars.pco, perm = 4999); env.fit #KEY function to add environemtnal fit!!
#scores.envfit(env.fit)
#Save plot - does not seem to work
#ggsave(paste("E:/stats/aldabra/BRUVs/02_ALD/data_exploration/output/plots/pco_sp_comm_treatment_mGower",Sys.Date(),".png"), plot = plot.pco, scale = 1, dpi = 300)
dev.off()


#older can be removed if above works, as the below steps now in environment folder:
#env.vars.pco <- dplyr::select(env.ald.paired, opcode, depth, temperature, wave.energy = we2_mean, sample.area, percent.water.column = perc_water_column)
#row.names(env.vars.pco) <- env.vars.pco$opcode
#env.vars.pco <- dplyr::select(env.vars.pco, -opcode)
#env.vars.pco.norm <- vegan::decostand(env.vars.pco, method = "normalize")
#saveRDS(env.vars.pco.norm, "E:/stats/aldabra/BRUVs/02_ALD/diversity/output/data/env_vars_pco_norm.RDS", ascii = TRUE)



##############################################################################



# ANALYSIS NOT USED IN PHD below


## Other options for PCOs using Modified Gower with different logbase transforamtions.

#pco.dis.mgow.log10 <- ape::pcoa(dis.mgow.log)
#pco.dis.mgow.log2 <- ape::pcoa(dis.mgow.log2)
#biplot.pcoa(pco.dis.mgow.sqrt)

# PLOTS of above
#plot(pco.dis.mgow.log10$vectors, type = "p", col=env.ald.paired$treatment)
#plot(pco.dis.mgow.log2$vectors, type = "p", col=env.ald.paired$treatment)
#ordiellipse(pco.dis.mgow.log2$vectors, groups = env.ald.paired$treatment, kind = "ehull", conf = 0.95, label = FALSE, col = c("black", "red"))
#legend(0.55,0.6, c("Baited","Unbaited"), lty=c(1,1), pch = 1, lwd=c(2.5,2.5),col=c("black","red"))


## Chao 2005
pco.chao <- cmdscale(dis.chao.log10, eig = TRUE)
#pco axes contribution
axis1.contr.ch <- round(pco.chao$eig[1]/sum(pco.chao$eig)*100,2)
axis2.contr.ch <- round(pco.chao$eig[2]/sum(pco.chao$eig)*100,2)
plot(pco.chao$points, type = "p",  col=pco.lbls$clr, pch = pco.lbls$pch, xlab = paste("PCO1 (",axis1.contr.ch,"% of total variation)", sep = ""), ylab = paste("PCO2 (",axis2.contr.ch,"% of total variation)", sep = ""), asp = 1/1, main = "Chao 2005 distance from log transformed data")
ordiellipse(pco.chao$points, groups = env.ald.paired$treatment, kind = "ehull", conf = 0.95, label = FALSE, col = c("black", "grey44"))
legend(0.2,0.4, c("Baited","Unbaited"), lty=c(1,1), pch = c(0,16), lwd=c(2.5,2.5),col=c("black","grey44"))
abline(h = 0, lty = 3)
abline(v = 0, lty = 3)
env.fit <- envfit(pco.chao, env.vars.pco, perm = 999) #KEY function to add environemtnal fit!!
plot(env.fit, col = "grey70")

####principle coordiante analysis using Morisita-Horn distance of log transformed data

#pco.dis.horn.log <- cmdscale(dis.horn.log)

pco.dis.horn.log <- cmdscale(dis.horn.log, eig = TRUE)
#pco axes contribution
axis1.contr.mh <- round(pco.dis.horn.log$eig[1]/sum(pco.dis.horn.log$eig)*100,2)
axis2.contr.mh <- round(pco.dis.horn.log$eig[2]/sum(pco.dis.horn.log$eig)*100,2)
plot(pco.dis.horn.log$points, type = "p",  col=pco.lbls$clr, pch = pco.lbls$pch, xlab = paste("PCO1 (",axis1.contr.mh,"% of total variation)", sep = ""), ylab = paste("PCO2 (",axis2.contr.mh,"% of total variation)", sep = ""), asp = 1/1, main = "Morisita-Horn distance from log transformed data")
ordiellipse(pco.dis.horn.log, groups = env.ald.paired$treatment, kind = "ehull", conf = 0.95, label = FALSE, col = c("black", "grey44"))
legend(0.2,0.4, c("Baited","Unbaited"), lty=c(1,1), pch = c(0,16), lwd=c(2.5,2.5),col=c("black","grey44"))
abline(h = 0, lty = 3)
abline(v = 0, lty = 3)
env.fit <- envfit(pco.dis.horn.log, env.vars.pco, perm = 999) #KEY function to add environemtnal fit!!
plot(env.fit, col = "grey70")


###NMDS - NOT USED IN PhD.

#composition nmds plot

#mds.trt.dat <- vegan::monoMDS(dis.horn.wisc)
mds.trt.dat <- vegan::monoMDS(dis.horn.log)
plot(mds.trt.dat, type = "p")

#grouping variable baited or unbaited
MyMeta = data.frame(
        sites = c(1:122),
        grp <- c(rep("Baited",61),rep("Unbaited",61)),
        row.names = "sites")
#add ellipse
op <- par(mfrow = c(1,1),
          mar = c(4,4,2,2) + 0.1)

plot(mds.trt.dat$points, cex = 1.5, col = c(rep("black",61),rep("gray44",61)),pch = c(rep(0,61),rep(16,61)))
legend(-1.1,1.45, c("Baited","Unbaited"), lty=c(1,1), pch = c(0,16), lwd=c(2.5,2.5),col=c("black","gray44"))
NMDS = data.frame(MDS1 = mds.trt.dat$points[,1], MDS2 = mds.trt.dat$points[,2],group=grp)  
ord<-ordiellipse(mds.trt.dat, groups = grp, display = "sites", kind = "ehull", conf = 0.95, label = FALSE, col = c("black", "gray44"))

#with(env.ald.paired, ordiellipse(mds.trt.dat, groups = treatment, kind = "ehull", conf = 0.95, label = TRUE))
