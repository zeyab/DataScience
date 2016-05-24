source("warmup.R")
rankall <- function(outcome, num = 1){
  validOutcome = c("heart attack","heart failure","pneumonia")
  states <- function(){
    uniqueStates <<- unique(outcomes[, 7])
    return(uniqueStates)
  }
  if(!outcome %in% validOutcome)
    stop(paste('Invalid outcome: ', outcome))
  
  fullColName <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  colName <- fullColName[match(outcome,validOutcome)]
  hospital<-character(0)
  
  for (i in seq_along(states())) {
    ## Return hospital name in that state with the given rank 30-day death rate
    outcomes.state <- outcomes[outcomes$State==states()[i],]
    
    # order data by outcome
    sorted.data.state <- outcomes.state[order(as.numeric(outcomes.state[[colName]]),outcomes.state[["Hospital.Name"]],decreasing=FALSE,na.last=NA), ]
    
    if(num == 'best' || num <= 0)
      num = 1
    if(num == 'worst')
      num = nrow(sorted.data.state) - 1
    
    if(num > nrow(sorted.data.state) )
      stop(paste('Rank is out of range. Count available: ', nrow(sorted.data.state)))
    
    
    hospital[i] <- sorted.data.state[num,"Hospital.Name"]
  }
  #return sorted data
  outcomes.frame(hospital=hospital,state=validState,row.names=validState)
}

rankall("heart attack", "best")