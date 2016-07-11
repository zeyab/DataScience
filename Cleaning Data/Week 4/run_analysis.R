# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# A full description is available at the site where the data was obtained:
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Here are the data for the project:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Ensure local file location exists.
if(!file.exists('data')){
  dir.create('data');
}
dataLocation <- "data/UCI-HAR-20160709"
if(!file.exists(dataLocation)){
  dir.create(dataLocation);
}
#Download Zip file
dataZipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
baseFilePath <- "./data/UCI-HAR-Data-20160709"
#downloading is expensive do not do this on each call. Download once and then reuse the downloaded file.
downloadedFile = "./data/UCI-HAR-Data-20160709.zip";
if(!file.exists(downloadedFile)){
  download.file(url = dataZipUrl, destfile = downloadedFile, method = "curl")
  #Extract zip files
  unzip("./data/UCI-HAR-Data-20160709.zip", exdir=baseFilePath)
  #manually moved files one level up.
}

#Check on extracted files.
#dataFiles <- list.files(file.path(baseFilePath), recursive = TRUE)

#Read data into memory
print("Reading into memory ...")
testPath <- paste0(baseFilePath, "/test/")
trainPath <- paste0(baseFilePath, "/train/")

dataActivityTest <- read.table(paste0(testPath, "Y_test.txt"), header = FALSE)
dataActivityTrain <- read.table(paste0(trainPath, "Y_train.txt"), header = FALSE)

dataSubjectTest <- read.table(paste0(testPath, "subject_test.txt"), header = FALSE)
dataSubjectTrain <- read.table(paste0(trainPath, "subject_train.txt"), header = FALSE)

dataFeaturesTest <- read.table(paste0(testPath, "X_test.txt"), header = FALSE)
dataFeaturesTrain <- read.table(paste0(trainPath, "X_train.txt"), header = FALSE)

# print("Printing validation - Head")
# head(dataActivityTest)
# head(dataActivityTrain)
# head(dataSubjectTest)
# head(dataSubjectTrain)
# head(dataFeaturesTest)
# head(dataFeaturesTrain)

print("1. Merging data. Will take time. Patience ...")
mergedSubjects <- rbind(dataSubjectTrain, dataSubjectTest)
mergedActivities <- rbind(dataActivityTrain, dataSubjectTest)
mergedFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

# head(mergedSubjects)
# head(mergedActivities)
# head(mergedFeatures)

print("Set variable names")
names(mergedSubjects) <- c("subject")
names(mergedActivities) <- c("activities")
featureNames <- read.table(paste0(baseFilePath, "/features.txt"), header = FALSE)
summary(featureNames)
names(mergedFeatures) <- featureNames$V2

print("Standardized data - merge everything ...")
mergedData <- cbind(mergedSubjects, mergedActivities)
mergedData <- cbind(mergedFeatures, mergedData)


print("2. Get Mean and Std dev.")

index <- grep("mean\\(\\)|std\\(\\)", featureNames$V2)
subFeatureNames <- featureNames$V2[index]

mergedFeatures <- mergedFeatures[, index]

selectedNames<-c(as.character(subFeatureNames), "subject", "activity" )

mergedData <-  subset(mergedData, select = selectedNames)

#Read activities names to standardize on values used.
activityNames <- read.table(paste0(baseFilePath, "/activity_labels.txt"), header = FALSE)

# Check
# head(mergedData$activity, 10)

print("3/4. Clean up lables/names. Make them clear and readable.")
names(mergedData)<-gsub("^t", "time", names(mergedData))
names(mergedData)<-gsub("^f", "frequency", names(mergedData))
names(mergedData)<-gsub("Acc", "Accelerometer", names(mergedData))
names(mergedData)<-gsub("BodyBody", "Body", names(mergedData))
names(mergedData)<-gsub("Gyro", "Gyroscope", names(mergedData))
names(mergedData)<-gsub("Mag", "Magnitude", names(mergedData))

#friendly labels for activities
mergedData[,ncol(mergedData)] <- activityNames[mergedData[,ncol(mergedData)], 2]
# head(mergedData)


print("5. Tidy data set creation ....")
tidyData <- data.table(mergedData)
# std dev and average by columns - subject and activity
#NTS: in By list whitespace is considered part of name - big no-no
#names(mergedData)
tidyData <- tidyData[, lapply(.SD, mean), by = 'subject,activities']
head(tidyData)
if(!file.exists('data/output')){
  dir.create('data/output');
}

output <- "data/output"
today <- Sys.Date()
today <- format(today, "%Y%m%d")
output <- paste0(output, '/tidyData-', today, ".tsv")
print(paste0("Writing output to: ", output))
write.table(tidyData, row.names = FALSE, file= output, quote=FALSE, sep="\t")
head(tidyData)
print("Done.")