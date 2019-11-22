# cRow meeting, Graham Centre, 22 November 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Many users migrating from Excel to R for data manipulation ask,
# "How do I make a pivot table? Its so easy in Excel!"

# Pivot tables are essentially just reshaping the data.

#---- The history of options for reshaping data in R -----

# base::reshape function
# {reshape} package
# {reshape2} package (functions 'melt' and 'cast')
# {tidyr} package (functions 'gather' and 'spread')
# {tidyr} package now uses functions 'pivot_wider' and 'pivot_longer'

# The {data.table} package can do many data-munging tasks.
# The {cdata} package provides more options.


#----- Install {tidyr} package -----
# The simplest way to install {tidyr} is to install it and all its "tidyverse" siblings

install.packages("tidyverse")

library("tidyverse")

help(tidyr)

# Go via <Index> to <User guides...>  to <tidyr::pivot> vignette for explanation


#----- Make dataset "longer" -----
# This means increase the number of rows and decrease the number of columns.

# Why would we want to do this?
# To make the data more amenable to analysis and graphing.
# Data is often entered into spreadsheets in a "wide" format (for convenience),
# or extracted from websites, PDFs, or Word documents in "wide" table form.

relig_income
str(relig_income)

pivot_longer(relig_income, -religion, names_to = "income", values_to = "count")

# The new column names of "income" and "count" are in quotes because they need to be created
# by the reshaping.

# We can pipe-in the dataset if we wish:
relig_income %>%
  pivot_longer(-religion, names_to = "income", values_to = "count") -> long_income

str(long_income)

# Now the dataset is able to be graphed:
library(ggplot2)

ggplot(data=long_income) +
  geom_point(aes(x=income, y=count, col=religion))


#----- Make data "wider" -----
# You will use this less often.
# Aim is to produce a dataframe with more columns and less rows.

# We can simply reverse our pivot_longer() command to recreate the relig_income dataset.
pivot_wider(long_income, names_from=income, values_from=count)

# Here, income and count do not need quotes because they already exist in the dataframe.

# See the vignette for more complicated (but not uncommon) dataset reshaping tasks.

#----- What about pivot tables? -----
# Using the warpbreaks data from base R.

warpbreaks
# Two factor weaving experiment: 2 type of wool, 3 levels of tension, 9 replicates.
# Recorded the number of times the yarn broke during weaving.
# Make a pivot table of means for all factor combinations.

warpbreaks %>%
  pivot_wider(
    names_from = wool,
    values_from = breaks,
    values_fn = list(breaks = mean))

# This is really summarise and reshape operations in one step.

warpbreaks %>%
  group_by(wool, tension) %>%
  summarise(mean_breaks = mean(breaks))

warpbreaks %>%
  group_by(wool, tension) %>%
  summarise(mean_breaks = mean(breaks)) %>%
  pivot_wider(names_from = wool,
              values_from = mean_breaks)

#----- Interactive pivot tables in the {radiant} package -----

install.packages("radiant")
library(radiant)
# Now, {radiant} is accessible from the RStudio <Addins> menu.
# It runs in a separate browser window.


#----- Other options (from CRAN) -----

# {pivottabler} package
# {cdata} and {data.table} packages


#----- How to read tabular (and messy) data from Excel? -----
# {tidyxl} package
# {unpivotr} package
# {tidycells} package (e.g. 96-well plates, even multiple ones per excel sheet)

# These are all on CRAN.


# Ends.
