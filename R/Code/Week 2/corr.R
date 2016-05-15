source('complete.R')
corr <- function(directory, threshold = 0) {
# 'directory' is a character vector of length 1 indicating the location of the CSV files
# 'threshold' is a numeric vector of length 1 indicating the number of completely observed observations (on all
# variables) required to compute the correlation between nitrate and sulfate; the default is 0

# Return a numeric vector of correlations
  
  # completeData <- complete(directory)
  # # print(completeData)
  # print(lengths(completeData))
  # print('==============')
  # completeData <- completeData[completeData$nobs > threshold,]
  # print(lengths(completeData))
  # correlation = NULL
  # correlation = cor(completeData, completeData$nitrate, completeData$sulfate)
  # correlation
  
  tcorr <- function(fname) {
    data <- read.csv(file.path(directory, fname))
    nobs <- sum(complete.cases(data))
    if (nobs > threshold) {
      return (cor(data$nitrate, data$sulfate, use="complete.obs"))
    }
  }
  tcorrs <- sapply(list.files(directory), tcorr) #get all correlations + NULLs
  tcorrs <- unlist(tcorrs[!sapply(tcorrs, is.null)]) #remove NULLs
  return (tcorrs)
}

corr('specdata')