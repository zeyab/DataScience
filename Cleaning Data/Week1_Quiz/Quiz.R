# Question 1

# if(!file.exists('data')){
#   dir.create('data');
# }
# %y-%m-%d-%H%M%S
# today <- date()
# format(today, format="%Y")
# downloadFileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv";
# download.file(downloadFileUrl, destfile = "./data/2016-06-17-0106.csv", method = 'curl');
data <- read.csv(file = './data/2016-06-17-0106.csv', header = TRUE);
#length(data$VAL[ data$VAL == 24 & !is.na(data$VAL)])

# Question 2
# table(data$FES)

#install.packages("xlsx")
require("xlsx")
# Question 3
downloadFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx';
#download.file(downloadFileUrl, destfile = "./data/2016-06-17-0106.xlsx", method = 'curl');
options(java.home="/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home/jre")
library(xlsx);
rows = 18:23
cols = 7:15
dat <- read.xlsx("./data/2016-06-17-0106.xlsx", sheetIndex = 1, rowIndex = rows, colIndex = cols, header = TRUE)
sum(dat$Zip*dat$Ext,na.rm=T)


# Question 4
# downloadFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml';
# download.file(downloadFileUrl, destfile = "./data/Baltimore-Rest-2016-06-17-0106.xml", method = 'curl');
#install.packages('XML')
#require("XML")
library(XML)
xmlDoc <- xmlTreeParse("./data/Baltimore-Rest-2016-06-17-0106.xml", useInternal = TRUE);
rootNode <- xmlRoot(xmlDoc);
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")

# Question 5
# downloadFileUrl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv';
# download.file(downloadFileUrl, destfile = "./data/AmericanCommunitySurvey-2016-06-17-0106.xml", method = 'curl');

library(data.table);
DT <- fread(input="./data/AmericanCommunitySurvey-2016-06-17-0106.xml", sep=",");

system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))

system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

system.time(tapply(DT$pwgtp15,DT$SEX,mean))

#system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])

system.time(mean(DT$pwgtp15,by=DT$SEX))

system.time(DT[,mean(pwgtp15),by=SEX])
