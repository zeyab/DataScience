source('getDataRowsFromFiles.R')
complete <- function(directory, ids = 1:332) {
  # 'directory' is a character vector of length 1 indicating the location of the CSV files
  # 'id' is an integer vector indicating the monitor ID numbers to be used
  
  # Return a data frame of the form: 
  # id nobs 
  # 1 117 
  # 2 1041 
  # ...  
  # where 'id' is the monitor ID number and 'nobs' is the number of complete cases
  # for( id in ids){
  #   rows <- getDataRowsFromFiles(directory, id)
  #   nobs = c(nobs, sum(complete.cases(rows)))
  #   
  # }
  
  sums <- function(id){
    sum(complete.cases(getDataRowsFromFiles(directory, id)))
  }
  
  data.frame(id=ids, nobs=sapply(ids, sums))
  
}
