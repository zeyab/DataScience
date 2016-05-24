source("warmup.R")

rankhospital <- function(state, outcome, num = 1){
  validOutcome = c("heart attack","heart failure","pneumonia")
  states <- function(){
    uniqueStates <<- unique(outcomes[, 7])
    return(uniqueStates)
  }
  if(!outcome %in% validOutcome)
    stop(paste('Invalid outcome: ', outcome))
  if(!state %in% states())
    stop(paste('Invalid state: ', state))
  
  fullColName <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
  colName <- fullColName[match(outcome,validOutcome)]
  
  #hospital name at the rank
  outcomes.state <- outcomes[outcomes$State==state,]
  if(num == 'best' || num <= 0)
    num = 1
  if(num == 'worst')
    num = nrow(outcomes.state) - 1
  
  if(num > nrow(outcomes.state) )
    stop(paste('Rank is out of range. Count available: ', nrow(outcomes.state)))
  
  
  paste(state, ': ', outcomes.state[num,"Hospital.Name"])
}