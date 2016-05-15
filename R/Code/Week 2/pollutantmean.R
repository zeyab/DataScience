source('getDataRowsFromFiles.R')
pollutantmean <- function(directory, pollutant, ids = 1:332){
# 'directory' is a character vector of length 1 indicating
# the location of the CSV files
# 
# 'pollutant' is a character vector of length 1 indicating
# the name of the pollutant for which we will calculate the
# mean; either "sulfate" or "nitrate".
# 
# 'ids' is an integer vector indicating the monitor ID numbers
# to be used
# 
# Return the mean of the pollutant across all monitors list
# in the 'id' vector (ignoring NA values)
  print('getting data ...')
  rows = getDataRowsFromFiles(directory, ids)
  print('data collected')  
  mean(rows[[pollutant]], na.rm = TRUE)
}

#pollutantman("specdata", 'nitrate', 23);

#pollutantmean("specdata", "sulfate", 1:10)
# pollutantman("specdata", 'nitrate', 70:72)
# pollutantmean("specdata", "nitrate", 23)


pollutantmean("specdata", "nitrate")
