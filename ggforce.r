#### ggforce for adding extra flair to your graphs ####

## Install Packages ##

install.packages("nycflights13")
install.packages("ggforce")
install.packages("concaveman")

## Libraries ##

library(tidyverse)
library(ggforce)
library(nycflights13)


##  Plot US airport locations, subset by timezone ##

p <-
  airports %>%
  filter(lon < 0, tzone != "\\N") %>%
  ggplot(aes(lon, lat, color = tzone)) + 
  geom_point(show.legend = FALSE)  +
  coord_cartesian()

p

## Add pizzazz with ggforce

p +
  geom_mark_rect()                      # Adds rectangles to TimeZone data points (aggregates)



p +
  geom_mark_rect(aes(label = tzone))    # Adds sexy labels



p + 
  geom_mark_rect(aes(label = tzone),
                 show.legend = FALSE) + #Drop legend (we don't need it with the new sexy labels)
  theme_void()                          # Drop all "graph" elements


p + 
  geom_mark_hull(aes(label = tzone,
                     fill = tzone),
                 show.legend = FALSE) + #When rectangles or circles don't give you the best coverage
  theme_void() 

p + 
  geom_mark_hull(aes(label = tzone,
                     fill = tzone),
                 show.legend = FALSE,
                 expand = unit(3,"mm")) + # Change the padding around hull.
  theme_void() 

p + 
  geom_mark_hull(aes(label = tzone,
                     fill = tzone),
                 show.legend = FALSE,
                 expand = unit(3,"mm")) + # Change the padding around hull.
  theme_no_axes()                         # Another ggforce theme

## Add context to your plots with zoom

p +
  facet_zoom(xlim = c(-155, -160.5), ylim = c(19, 22.3)) # specify limits

p +
  facet_zoom(xy = tzone == "Pacific/Honolulu",
             horizontal = FALSE,
             zoom.size = .5) # Filter by timezone

p +
  geom_mark_hull(aes(label = tzone,
                     fill = tzone),
                 show.legend = FALSE,
                 expand = unit(3, "mm")) +
                    theme_no_axes() +
  facet_zoom(x = tzone == "America/Los_Angeles",
             zoom.size = .5)


## More Facet Zoom examples

q <- 
  ggplot(diamonds) + 
  geom_histogram(aes(x = price), bins = 50) # Draw a simple histogram

q +  
  
facet_zoom(xlim = c(3000, 5000), ylim = c(0, 2500), horizontal = FALSE) # Zoom on particular area. Note: extra infomration is limited due to same bin width


ggplot() + 
  geom_histogram(aes(x = price), dplyr::mutate(diamonds, z = FALSE), bins = 50) + #Set regular graph bin width, specify this data is not zoomed (z = FALSE)
  geom_histogram(aes(x = price), dplyr::mutate(diamonds, z = TRUE), bins = 500) + #Set zoomed graph bin width, specify this data IS zoomed (z =)
  facet_zoom(xlim = c(3000, 5000), ylim = c(0, 300), zoom.data = z,               #Specify data to zoom is z = TRUE (facet_zoom looks for TRUE/FALSE value)
             horizontal = FALSE) +
  theme(zoom.y = element_blank(), validate = FALSE)


## Parralel sets/ Alluvial diagrams

titanic <- data.frame(Titanic)
head(titanic)

titanic <- gather_set_data(titanic, 1:4) # ggforce function similar to gather (or pivot_longer), adds x and y columns
head(titanic)

ggplot(titanic, aes(x, id = id, split = y, value = Freq)) +
  geom_parallel_sets(aes(fill = Sex), alpha = 0.3, axis.width = 0.1)

ggplot(titanic, aes(x, id = id, split = y, value = Freq)) +
  geom_parallel_sets(aes(fill = Sex), alpha = 0.3, axis.width = 0.1) +
  geom_parallel_sets_axes(axis.width = 0.1, color = "lightgrey", fill = "white") +
  geom_parallel_sets_labels(angle = 0) +
  theme_no_axes() +
  theme(axis.text = element_text())
  