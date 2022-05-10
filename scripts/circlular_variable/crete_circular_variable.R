library(tidyverse)
#> Warning: package 'tidyverse' was built under R version 4.0.3
library(sf)
#> Linking to GEOS 3.8.0, GDAL 3.0.4, PROJ 6.3.1

(sample <- data.frame(number = 1,
                      name = c("Arc", "Circle", "Line"),
                      area = c(0.46, 330, NA),
                      start_angle = c(134, NA, NA),
                      angle_total = c(17, NA, NA),
                      center_x = c(974, 377, NA),
                      center_y = c(7299, 7250, NA),
                      center_z = c(0, 0, NA),
                      length = c(4.27, NA, 15),
                      radius = c(14, 10.2, NA),
                      angle = c(NA, NA, 270),
                      delta_x = c(NA, NA, 0),
                      delta_y = c(NA, NA, -15),
                      delta_z = c(NA, NA, 0),
                      start_x = c(NA, NA, 18.2),
                      start_y = c(NA, NA, 7000),
                      start_z = c(NA, NA, 0),
                      end_x = c(NA, NA, 18.2),
                      end_y = c(NA, NA, 146),
                      end_z = c(NA, NA, 0)) %>% 
    as_tibble())
#> # A tibble: 3 x 20
#>   number name    area start_angle angle_total center_x center_y center_z length
#>    <dbl> <chr>  <dbl>       <dbl>       <dbl>    <dbl>    <dbl>    <dbl>  <dbl>
#> 1      1 Arc     0.46         134          17      974     7299        0   4.27
#> 2      1 Circ~ 330             NA          NA      377     7250        0  NA   
#> 3      1 Line   NA             NA          NA       NA       NA       NA  15   
#> # ... with 11 more variables: radius <dbl>, angle <dbl>, delta_x <dbl>,
#> #   delta_y <dbl>, delta_z <dbl>, start_x <dbl>, start_y <dbl>, start_z <dbl>,
#> #   end_x <dbl>, end_y <dbl>, end_z <dbl>

line_start <- sample %>% 
  filter(name == "Line") %>% 
  select(start_x, start_y) %>% 
  rename(X = start_x, Y = start_y) %>% 
  mutate(ID = 1:nrow(.))

line_end <- sample %>% 
  filter(name == "Line") %>% 
  select(end_x, end_y) %>% 
  rename(X = end_x, Y = end_y) %>% 
  mutate(ID = 1:nrow(.))

(lines <- line_start %>% 
    bind_rows(line_end) %>%
    st_as_sf(coords = c("X", "Y")) %>%
    group_by(ID) %>%
    summarise(do_union = FALSE) %>%
    st_cast("LINESTRING"))
#> `summarise()` ungrouping output (override with `.groups` argument)
#> Simple feature collection with 1 feature and 1 field
#> geometry type:  LINESTRING
#> dimension:      XY
#> bbox:           xmin: 18.2 ymin: 146 xmax: 18.2 ymax: 7000
#> CRS:            NA
#> # A tibble: 1 x 2
#>      ID              geometry
#>   <int>          <LINESTRING>
#> 1     1 (18.2 7000, 18.2 146)

# ggplot() +
#   geom_sf(data = lines) +
#   coord_sf(xlim = c(10, 20))

circle_centers <- sample %>% 
  filter(name == "Circle") %>% 
  select(center_x, center_y) %>% 
  rename(X = center_x, Y = center_y) %>% 
  mutate(ID = 1:nrow(.))

circle_radii <- sample %>% 
  filter(name == "Circle") %>% 
  select(radius) %>% 
  rename(R = radius) %>% 
  mutate(ID = 1:nrow(.))

(circle <- circle_centers %>% 
    st_as_sf(coords = c("X", "Y")) %>%
    st_buffer(circle_radii$R))
#> Simple feature collection with 1 feature and 1 field
#> geometry type:  POLYGON
#> dimension:      XY
#> bbox:           xmin: 366.8 ymin: 7239.8 xmax: 387.2 ymax: 7260.2
#> CRS:            NA
#> # A tibble: 1 x 2
#>      ID                                                                 geometry
#> * <int>                                                                <POLYGON>
#> 1     1 ((387.2 7250, 387.186 7249.466, 387.1441 7248.934, 387.0744 7248.404, 3~

 ggplot() +
   geom_sf(data = circle)

 ggplot() +
   geom_sf(data = rbind(lines, circle)) +
  coord_sf(xlim = c(-500, 1000))
 