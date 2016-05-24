source("warmup.R")

best <- function(state, outcome){
  
  ds <- cache(outcomes)
  ds$states()
  # print(colNames[2])
  # colNames[1]
  # colNames[0]
  
  
}

cache <- function(data)
{
  uniqueStates <- NULL
  stateData <- NULL
  queryState <- NULL
  setStateData <- function(state){
    if(state != queryState){
      queryState <<- state
      stateData <<- data[data$State=state,]  
    }
    return(stateData)
  }
  
  states <- function(){
    if(is.null(uniqueStates)){
      uniqueStates <<- unique(data[, 7])
    }
    return(uniqueStates)
  }
  
  lowestHeartAttack <- function(state){
    colName ='Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack'
    setStateData(state)
    min(as.double(stateData[,colName]));
  }
  
  lowestPneumonia <- function(state){
    colName = 'Hospital.30.Day.Readmission.Rates.from.Pneumonia'
    setStateData(state)
    min(as.double(stateData[,colName]));
  }
  
  lowestHeartFailure <- function(state){
    colName = 'Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure'
    setStateData(state)
    min(as.double(stateData[,colName]));
  }
  
  list(
    lowestHeartAttackRate = lowestHeartAttack,
    lowestHeartFailureRate = lowestHeartFailure,
    lowestPneumoniaRate = lowestPneumonia,
    states = states
  )
}


best('CA', 'jflkds')