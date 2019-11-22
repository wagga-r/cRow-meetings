# cRow meeting, Graham Centre, 22 November 2019
# David Luckett, djluckett@gmail.com, 0408 750 703


# Danger of variables being recycled in a function

dummy_data <- data.frame(id = c("dog","cat","mouse","lion","horse","pig"),
                         type = c("A","B","B","A","B","B"))
dummy_data

library(dplyr)

dummy_data %>%
  filter(type == c("A", "B"))

dummy_data %>%
  filter(type %in% c("A", "B"))

dummy_data %>%
  filter(type == c("A") | type == c("B"))


#----- Variable lengths are not exact multiples of each other -----
# We do get a warning, but recycling logic is the same.

dummy_data %>% filter(id != "pig") -> dummy_data2

dummy_data2 %>%
  filter(type == c("A", "B"))

# Ends.
