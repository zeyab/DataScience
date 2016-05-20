#1
# library(datasets)
# data("iris")
# ##dimnames(iris)
# # head(iris)
# 
# 
# ##http://www.r-bloggers.com/r-function-of-the-day-tapply/
# ##tapply(Summary Variable, Group Variable, Function)
# #tapply(iris$Sepal.Length, iris$Species, mean)
# 

#2
#apply(iris[,1:4],2,mean)

#3.
library(datasets)
data("mtcars")
# head(mtcars)

# sapply(mtcars, cyl, mean) - Wrong syntax
# lapply(mtcars, mean) - Avg on each column
# apply(mtcars, 2, mean) - same as above except will return vector
# tapply(mtcars$cyl, mtcars$mpg, mean) #will try to level by mpg and get no grouping.
# sapply(split(mtcars$mpg, mtcars$cyl), mean) # Yes
# tapply(mtcars$mpg, mtcars$cyl, mean) # Yes
# mean(mtcars$mpg, mtcars$cyl) # will error on second value.
# with(mtcars, tapply(mpg, cyl, mean)) #Yes
# split(mtcars, mtcars$cyl) #will only split values

#4. 
#http://www.statmethods.net/management/subset.html
library(datasets)
data("mtcars")
# mean(mtcars$hp[which(mtcars$cyl == 4)]) #subsetting
abs(mean(mtcars$hp[which(mtcars$cyl == 4)]) - mean(mtcars$hp[which(mtcars$cyl == 8)]))

#5.
