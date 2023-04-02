# BIS 244 Spring 2022
# Week 11: Draw maps
library(dplyr)
library(socviz)
library(ggplot2)

install.packages("maps")
library(maps)

us_states <- map_data("state")
#map_data: turns data from the "maps" package in to a data frame for plotting with ggplot2
head(us_states)
dim(us_states)


p <- ggplot(data = us_states, mapping = aes(x = long, y = lat, group = group))

p + geom_polygon(fill = "white", color = "black")

## fill the aesthetic to "region" and change the color mapping to a light gray,
# and thin the lines to make the state borders a little nicer:

p <- ggplot(data = us_states, 
            mapping = aes(x = long, y = lat, 
                          group = group, fill = region))
p + geom_polygon(color = "gray90", size = 0.1) + guides(fill = "none")


# projecting points and lines from a round to a flat surface
# Albers projection:
p <- ggplot(data = us_states, 
            mapping = aes(x = long, y = lat, 
                          group = group, fill = region))

p + geom_polygon(color = "gray90", size = 0.1) + 
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) +
  guides(fill = "none")

#### Merge our data correctly
?election 
head(election)
# US Presidential Election 2016, State-level results

# tolower: convert the "state" names to begin lowercase
election$region <- tolower(election$state) 
# merge two data sets into one set 
us_states_elect <- left_join(us_states, election)
# Joining, by = "region"
# the "region" variable is the only column with the same name in both datasets
head(us_states_elect)


p <- ggplot(data = us_states_elect, 
            mapping = aes(x = long, y = lat, 
                          group = group, fill = party))

p + geom_polygon(color = "gray90", size = 0.1) + 
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) 

# The default colors do not look correct on our map
## Let's improve our figure:
party_colors <- c("blue", "red")
p0 <- ggplot(data = us_states_elect, 
            mapping = aes(x = long, y = lat, 
                          group = group, fill = party))
p1 <- p0 + geom_polygon(color = "gray90", size = 0.1) + 
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) 
p2 <- p1 + scale_fill_manual(values = party_colors) +
  labs(title = "Election Results 2016", fill = NULL)
p2
library(ggthemes)
p2 + theme_map()

# theme_map(): A clean theme that is good for displaying maps


### Let's include other variables into the map
# For example: percentage of the vote received by Donald Trump

p0 <- ggplot(data = us_states_elect, 
             mapping = aes(x = long, y = lat, 
                           group = group, fill = pct_trump))

p1 <- p0 + geom_polygon(color = "gray90", size = 0.1) + 
  coord_map(projection = "albers", lat0 = 39, lat1 = 45) 
p1 + labs(title = "Trump vote") + theme_map() + labs(fill = "Percent")

# The default color is blue (which is not we wanted here)
# In addition, the gradient runs in the wrong direction
# use scale_fill_gradient function which defines the direction for the level of shading
#white = low shade and the color you are using = highest shade of that color

p2 <- p1 + scale_fill_gradient(low = "white", high = "red") +
  labs(title = "Trump vote")

p2 + theme_map() + labs(fill = "Percent")

### In-class exercise: 

# Draw a map using the "percentage of the vote received by Clinton"
# Create a gradient effect using color "steelblue"
# e.g., a higher vote share makes for a darker color
p0 <- ggplot(data = us_states_elect, mapping = aes(x = long, y = lat,
                                                  group = group, fill = pct_clinton))
p1 <- p0 + geom_polygon(color = "gray90",size = 1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)

p2 <- p1 + scale_fill_gradient(low = "white", high = "steelblue") + labs(title =  "Clinton votes")

p2 + theme_map() + labs(fill = "Percent")











### ------- county-level U.S. maps -------------------------------------
library(socviz)
?county_map
head(county_map)
county_map %>% sample_n(5)
dim(county_map)


?county_data
# Selected county data (including state-level observations on some variables)
# id: the FIPS code for the county
county_data %>%
  select(id, name, state, pop_dens, pct_black) %>%
  sample_n(5)

# merging two datasets into one:

county_full <- left_join(county_map, county_data, by = "id")
county_full

# Map the population density per square mile
p <- ggplot(data = county_full,
             mapping = aes(x = long, y = lat, 
                           fill = pop_dens,
                           group = group))

p1 <- p + geom_polygon(color = "gray90", size = 0.05) + 
  coord_equal() # makes sure that the relative scale of our map does not change
p1
# p1: by default ggplot chooses an unordered categorical layout
# (pop_dens variable is not ordered)

p2 <- p1 + scale_fill_brewer(palette = "Blues",
                             labels = c("0-10", "10-50", "50-100", "100-500",
                                        "500-1,000", "1,000-5,000", ">5,000"))

p2
  
p2 + labs(fill = "Population per \n square mile") +
  theme_map() +
  guides(fill = guide_legend(nrow = 1)) +
  theme(legend.position = "bottom")

## Draw a similar map of "percent black population by county"

p <- ggplot(data = county_full,
            mapping = aes(x = long, y = lat, 
                          fill = pct_black,
                          group = group))

p1 <- p + geom_polygon(color = "gray90", size = 0.05) + 
  coord_equal()

p2 <- p1 + scale_fill_brewer(palette = "Greens")

p2 + labs(fill = "US Population, Percent Black") +
  guides(fill = guide_legend(nrow = 1)) +
  theme_map() +
  theme(legend.position = "bottom")

##### population density map
#RColorBrewer::brewer.pal chooses different shades of color from one type of color
orange_pal <- RColorBrewer::brewer.pal(n = 6, name = "Oranges")
orange_pal

pop_p <- ggplot(data = county_full, mapping = aes(x = long, y =lat,
                                                  fill = pop_dens6,
                                                  group = group))

pop_p1 <- pop_p + geom_polygon(color = "gray90", size = 0.05) + 
  coord_equal()

pop_p2 <- pop_p1 + scale_fill_manual(values = orange_pal)

pop_p2 + labs(title = "Revenue-coded Population Density",
              fill = "People per square mile") +
  theme_map() +
  theme(legend.position = "bottom")
