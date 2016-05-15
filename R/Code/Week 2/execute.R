# source('pollutantmean.R')
pollutantmean("specdata", "nitrate")

#pollutantmean("specdata", "sulfate", 1:10)
# pollutantman("specdata", 'nitrate', 70:72)
#pollutantmean("specdata", "sulfate", 34)

# pollutantmean("specdata", "nitrate", 23)

#tests for Part 2
# source('complete.R')
# cr <- corr("specdata")                
# cr <- sort(cr)                
# set.seed(868)                
# out <- round(cr[sample(length(cr), 5)], 4)
# print(out)
# set.seed(42)
# cc <- complete("specdata", 332:1)
# use <- sample(332, 10)
# print(cc[use, "nobs"])
# cc <- complete("specdata", 54)
# print(cc$nobs)
# cc <- complete("specdata", c(6, 10, 20, 34, 100, 200, 310))
# print(cc$nobs)
# complete("specdata", 1)
# complete("specdata", c(2, 4, 8, 10, 12))
# complete("specdata", 30:25)
# complete("specdata", 3)


#test for part 3
source('corr.R')
cr <- corr("specdata", 2000)                
n <- length(cr)                
cr <- corr("specdata", 1000)                
cr <- sort(cr)
print(c(n, round(cr, 4)))

# cr <- corr("specdata", 129)                
# cr <- sort(cr)                
# n <- length(cr)                
# set.seed(197)                
# out <- c(n, round(cr[sample(n, 5)], 4))
# print(out)

# cr <- corr("specdata", 150)
# head(cr)
# summary(cr)
# 
# cr <- corr("specdata", 400)
# head(cr)
# summary(cr)

# cr <- corr("specdata", 5000)
# summary(cr)
# length(cr)

# cr <- corr("specdata")
# summary(cr)
# length(cr)