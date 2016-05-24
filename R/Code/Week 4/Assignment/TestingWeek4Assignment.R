source("best.R")
'--Best.R--'
'--Good cases:--'
best('CA', 'heart attack')
best('CA', 'heart failure')

best('IL', 'heart attack')

best('GA', 'heart failure')

'--Negative cases:--'
best('ZM', 'heart failure')

best('IL', 'heart break')

source("rankhospital.R")
'--rankhospital.R--'
'--Good cases:--'
rankhospital("MD", "heart attack", "best")
rankhospital("MD", "heart attack", "worst")

rankhospital("MD", "heart attack", "3")

rankhospital("MD", "heart failure", "worst")

'--Negative cases:--'
rankhospital("M0", "heart attack", "worst")

rankhospital("MD", "heartattack", "1")
rankhospital("MD", "heart failure", "6000")