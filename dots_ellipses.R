# cRow meeting, Graham Centre, 22 November 2019
# David Luckett, djluckett@gmail.com, 0408 750 703

# The "dot" syntax

mtcars %>%
  select(mpg, cyl) %>%
  filter(cyl != 8) %>%
  mutate(cyl = as.factor(cyl)) %>%
  str()

mtcars %>%
  select(mpg, cyl) %>%
  filter(cyl != 8) %>%
  mutate(cyl = as.factor(cyl)) %>%
  ggplot(aes(x=as.factor(cyl), y=mpg)) +
    geom_point()


# For some functions the data input is not automatically available in the chain
# and it has to parsed with the "dot" notation.

mtcars %>%
  select(mpg, cyl) %>%
  filter(cyl != 8) %>%
  lm(mpg ~ cyl, data=.) %>%
  summary()

#----- Dot notation in a formula -----
# It means "use all other columns (variables) in the dataframe".

# Make a dataframe with four variables
mtcars %>%
  select(mpg, cyl, disp, am) -> new.df

# Fit a regression model and print a summary
summary(lm(mpg ~ ., data=new.df))


#----- Ellipses in function arguments -----
my_fun <- function(x) {
  (mean(x)*100)
}

xx <- c(1:10)

my_fun(xx)

xx[3] <- NA
xx
my_fun(xx)

# Version with ellipses in argument list
my_fun2 <- function(x, ...) {
  (mean(x, ...)*100)
}

my_fun2(xx)
my_fun2(xx, na.rm=TRUE)


#----- Dot(s) in object names -----

# In the middle of an object name = "no problem"
my.data <- mtcars[, c("mpg", "cyl")]

head(my.data)

# If "dot" is the first character of the object name, then that object is hidden
.mine <- mtcars[, c("mpg", "disp")]

ls()

# It still exists.......
head(.mine)

ls(all.names=TRUE)



# Ends.
