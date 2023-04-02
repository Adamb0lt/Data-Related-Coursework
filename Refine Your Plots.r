#### Chapter 8: Refine Your Plots
library(ggplot2)
library(socviz)

# asasec: data on membership over time in special-interest sections of the American Sociological Association
?asasec
View(asasec)
data(asasec)

# Basic scatterplot-and-smoother graph
# Let's look at the relationship between section membership and section revenues for a single year: 2014

p <- ggplot(data = subset(asasec, Year == 2014),
            mapping = aes(x=Members, y = Revenues))

p + geom_point() + geom_smooth()

## Let's refine the figure
# Identify some outliers, switch from loess to OLS, and introduce a third variable
p <- ggplot(data = subset(asasec, Year == 2014),
            mapping = aes(x=Members, y = Revenues))

p + geom_point(mapping = aes(color = Journal)) + 
  geom_smooth(method = "lm")

## Add text labels
p0 <- ggplot(data = subset(asasec, Year == 2014),
            mapping = aes(x=Members, y = Revenues))

p1 <- p0 + geom_smooth(method = "lm", se = FALSE, color = "grey80") +
  geom_point(mapping = aes(color = Journal))
library(ggrepel)
p2 <- p1 + geom_text_repel(data = subset(asasec, Year == 2014 & Revenues > 7000),
                                         size = 2, mapping = aes(label = Sname))
p2

# Label the axes and scales, and add a title
p3 <- p2 + labs(x = "Membership",
                y = "Revenues",
                color = "Section has own Journal",
                title = "ASA Sections",
                subtitle = "2014 Calendar Year.",
                caption = "Source: ASA annual report.")
p4 <- p3 + scale_y_continuous(labels = scales::dollar) +
  theme(legend.position = "bottom")
p4

#### Use Color to Your Advantage


p <- ggplot(data = organdata, mapping = aes(x = roads, y = donors, color = world))
# Method 1: We choose color palettes for mappings
p + geom_point(size = 2) + scale_color_brewer(palette = "Set2") +
  theme(legend.position = "top")

p + geom_point(size = 2) + scale_color_brewer(palette = "Pastel2") +
  theme(legend.position = "top")

p + geom_point(size = 2) + scale_color_brewer(palette = "Dark2") +
  theme(legend.position = "top")

# Method 2: We can specify  colors manually

cb_palette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442",
                "#0072B2", "#D55E00", "#CC79A7")

p4 + scale_color_manual(values = cb_palette)

#### Layer Color and Text Together

# An example where we use manually specified colors both for emphasis and because of their social meaning
# Democrat Blue and Republican Red

party_colors <- c("#2E74C0", "#CB454A")
# Subset the data, including only counties with a value of "No" on the flipped variable

p0 <- ggplot(data = subset(county_data, flipped == "No"), 
             mapping = aes(x = pop,y = black/100))
# Set the color of geom_point() to be a light gray, and apply a log transformation to the x-axis scale
p1 <- p0 + geom_point(alpha = 0.15, color = "grey50") + 
  scale_x_log10(labels = scales::comma)
p1

## The second layer:
# We choose "Yes" counties on the flipped variable
# Add a color scale for these points, mapping the partywinner16 variable to the color aesthetic
# Specify a manual color scale with scale_color_manual(), where the values are the blue and red party_colors we defined above

p2 <- p1 + geom_point(data = subset(county_data,
                                     flipped == "Yes"),
                      mapping = aes(x = pop, y = black/100,
                                    color = partywinner16)) +
  scale_color_manual(values = party_colors)

p2

## The third layer:
# Set the y-axis scale and the labels

p3 <- p2 + scale_y_continuous(labels = scales::percent) +
  labs(color = "County flipped to ...",
       x = "County Population (log scale)",
       y = "Percent Black Population",
       title = "Flipped counties, 2016",
       caption = "Counties in grey did not flip.")
p3

## The final layer:
# Add geom_text_repel()

p4 <- p3 + geom_text_repel(data = subset(county_data,
                                         flipped == "Yes" & black > 25),
                           mapping = aes(x = pop, y = black/100,
                                         label = state), size = 2)
p4 + theme_minimal()+
  theme(legend.position = "top")
 
#### Change the Appearance of Plots with Themes


# Themes can be turned on or off using the theme_set() function
# It takes the name of a theme (which will itself be a function) as an argument

theme_set(theme_bw())
p4 + theme(legend.position = "top")

theme_set(theme_dark())
p4 + theme(legend.position = "top")

# Note: Once set, a theme applies to all subsequent plots and remains active until it is replaced by a different theme
theme_set(theme_base())

##
# You can make ggplot output look like it has been featured in the Economist, or the Wall Street Journal,

install.packages("ggthemes")
library(ggthemes)

theme_set(theme_economist())
p4 + theme(legend.position = "top")

theme_set(theme_wsj())


p4 + theme(plot.title = element_text(size = rel(0.6)),
           legend.title = element_text(size = rel(0.35)),
           plot.caption = element_text(size = rel(0.35)),
           legend.position = "top")
