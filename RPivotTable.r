#### Exploring data in R using pivot tables ####

browseURL("https://github.com/nicolaskruchten/pivottable/wiki")
browseURL("https://cran.r-project.org/web/packages/rpivotTable/rpivotTable.pdf")

## Install packages

#install.packages("rpivotTable")
#install.packages("tidyverse")

## Load Libraries

library(rpivotTable)
library(tidyverse)

# Load Data
data(mtcars)
head(mtcars, n=3L)
?mtcars

## One line to create pivot table

rpivotTable(mtcars)

## Add in some default settings

rpivotTable(mtcars,
            rows="gear",
            col=c("cyl","carb"),
            vals="mpg"
            )

## Include Colwise Subtotals


rpivotTable(mtcars,
            rows="gear",
            cols=c("cyl", "carb"),
            subtotals=TRUE
            )

## Tidyverse friendly

iris %>%
  tbl_df() %>%
  filter( Sepal.Width > 3 ) %>%
  rpivotTable()
