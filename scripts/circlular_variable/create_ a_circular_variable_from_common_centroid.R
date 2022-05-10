# Aim create a series of segments (set distance) from a common central point and obtain their radians/degrees from 0
# do this using segments - they will need to be spatialobjects so that I can overlay them onto the positions of the sample statiosn- and assign their angles to the points.
# I should be able to write function that creates more and more points using a for loop
library(tidyverse)
library(sf)



#simple mentod!

# read in Aldabra and convert it to a sf r object - work in utm38 so that you can work with meters when running the loop to incrementally 
# draw a minimum convex hull around Aldabra
# find the centroid of the mnin convex hull
# read in location of RUVS and BRUVS
# clculate the distance and angle of the cenroid to the respective points- like this

# https://stackoverflow.com/questions/48444003/creating-r-function-to-find-both-distance-and-angle-between-two-points
# using 
# calculate the angle between central point and new 
angle <- function(from,to){
  dot.prods <- from$x*to$x + from$y*to$y
  norms.x <- distance(from = `[<-`(from,,,0), to = from)
  norms.y <- distance(from = `[<-`(to,,,0), to = to)
  thetas <- acos(dot.prods / (norms.x * norms.y))
  as.numeric(thetas)
}

theta <- acos( sum(a*b) / ( sqrt(sum(a * a)) * sqrt(sum(b * b)) ) )
#------------------------scrap below 


# read in Aldabra and convert it to a sf r object - work in utm38 so that you can work with meters when running the loop to incrementally 
# draw a minimum convex hull around Aldabra
# find the centroid of the mnin convex hull
# overlay the points

test_segement <- segments(x0 = 0, y0 = 0, x1 = 0, y = 1)
y = 
for (variable in vector) {
  x = 0 # replace 0 with central point of Aldabra
  for (variable in vector) {
    # function to incrementaly increase y by 0.01, starting central point of Aldabra + a nominal y distance of 20 km to ensure
  }
}


# calculate the angle between central point and new 
theta <- acos( sum(a*b) / ( sqrt(sum(a * a)) * sqrt(sum(b * b)) ) )
#------------- check out circular package
library(circular)
control <- c(0, 45, 90, 135, 180, 225, 270, 315) #assign control data
experimental <- c(0, 5, 10, 15, 350, 355) #assign experimental data
control.mean <- mean(control) #calculate and assign control mean
print(control.mean)


#Convert control data to circular
control.circ <- circular(control, units = "degrees", template = "geographics") 

#Convert experimental data to circular
experimental.circ <- circular(experimental, units = "degrees", template = "geographics")

experimental.circ.mean <- mean(experimental.circ)
print(experimental.circ.mean)

plot.circular(experimental.circ) #plot experimental data
arrows.circular(experimental.mean) # plot arithmetic mean, default color is black 
arrows.circular(experimental.circ.mean, col = "red") # plot circular mean in red (col = "red")
