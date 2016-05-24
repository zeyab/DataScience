'--Warmpup loaded. Loading data now.--'
outcomes <- read.csv('./ProgAssignment3-data/outcome-of-care-measures.csv', colClasses = 'character')
#head(outcomes)
#convert column 11 as numeric data.
outcomes[,11] = as.numeric(outcomes[,11])
#hist(outcomes[,11])

#names(outcomes)

