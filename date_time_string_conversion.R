# cRow meeting, Graham Centre, 22 November 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# Converting messy dates from the same character vector (or dataframe column), and getting
# them all into one, nice ISO format.

#----- Option 1 -----
library(lubridate)

aa <- c("11/7/2016", "14-07-16", "2016/7/11", "22_Nov_2019",
        "12,september,2008", "30-Feb-2007", "8/9/10", "20050403")

(dmy(aa) -> date_1)

# With {lubridate} the day-month-year order has to be the same in each string to parse correctly.
# Have access to other orders: ymd, ydm, mdy, myd, etc.
# Dates also have to be "real".
# It actually gets one date wrong!


#----- Option 2 -----
library(anytime)

(anydate(aa) -> date_2)

# {anytime} doesn't like truncated years ("16" instead of "2016").
# Converts last string correctly BUT assumes first string is in American format
# Also works with times.

# Let's compare them...
str(date_1)
str(date_2)
data.frame(aa, date_1, date_2, same = date_1 == date_2)


#----- Make your own function, if required -----
# From: R-help Digest, Vol 201, Issue 4

reformat <- function(z, sep = "-"){
   z <- gsub(" ","",z) ## remove blanks
   ## break up dates into 3 component pieces and convert to matrix
   z <- matrix(unlist(strsplit(z, "-|/")), nrow = 3)
   ## add "0" in front of single digit in dd and mm
   ## add "20" in front  of "yy"
   for(i in 1:2) z[i, ] <- gsub("\\<([[:digit:]])\\>","0\\1",z[i, ])
   z[3, ] <- sub("\\<([[:digit:]]{2})\\>","20\\1",z[3, ])
   ## combine back into single string separated by sep
   paste(z[3, ],z[2, ],z[1, ], sep = sep)
}

## Testit
z <- c(" 1 / 22 /2015"," 1 -5 -15","11/7/2016", "14-07-16")

reformat(z)  # Gets first date wrong in ymd output

reformat(z,"/")

as.Date(reformat(z))
as.Date(reformat(z, ""))
as.Date(reformat(z, "_"), format="%Y_%m_%d")

# Ends.
