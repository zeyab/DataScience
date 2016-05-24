source("warmup.R")

best <- function(state, outcome){
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
  
  ## Return hospital name in that state with lowest 30-day death rate
  outcomes.state <- outcomes[outcomes$State==state,]
  idx <- which.min(as.double(outcomes.state[,colName]))
  paste(state, ': ', outcomes.state[idx,"Hospital.Name"])
}
