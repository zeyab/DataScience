getDataRowsFromFiles <- function(directory, ids = 1:332){
  rows = data.frame()
  # read all ids/monitors
  for(id in ids){
    # build the file name
    file = paste(as.character(formatC(id, width = 3, flag = "0")), '.csv', sep='', collapse = '')
    # read data from csv and add values to data symbol
    rows = rbind(rows, read.csv(paste(directory, '/', file, sep = ''), header = TRUE, na.strings = "NA"))
  } #for id in ids
  rows
}

#getDataRowsFromFiles('specdata', 1:99)