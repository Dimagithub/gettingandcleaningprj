#run_analysis.r
#script related to course assignment of Getting and Cleaning the Data

#download source data zip file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "uci_har.zip", method = "curl")

#unzip (extract) file files
#the util::unzip wil extract all files and place them in ucihar subfolder 
#relative to current folder; of the folder does not exist - it will create it
unzip("uci_har.zip", exdir="./ucihar")

#load activity labels - in data table first
a_labels_ds <- read.table("./ucihar/UCI HAR Dataset/activity_labels.txt")
colnames(a_labels_ds) <- c("ActivityIndex", "ActivityName")

#load activity features - in data table first
features_ds <- read.table("./ucihar/UCI HAR Dataset/features.txt")
colnames(features_ds) <- c("FeatureIndex", "FeatureName")
#extract names only
features <- features_ds[,"FeatureName"]

#load data
#load test data
testData <- read.table("./ucihar/UCI HAR Dataset/test/X_test.txt")
testDataLabels <- read.table("./ucihar/UCI HAR Dataset/test/y_test.txt")
testDataSubjects <- read.table("./ucihar/UCI HAR Dataset/test/subject_test.txt")

#assign features to column names
colnames(testData) <- features

#add column with activity label indexes by reading first column from the label dataset
testData$ActivityIndex <- testDataLabels[,1]

#add colum with subject indexes by reading first colum of subject dataset
testData$SubjectIndex <- testDataSubjects[,1]

#load train data
trainData <- read.table("./ucihar/UCI HAR Dataset/train/X_train.txt")
trainDataLabels <- read.table("./ucihar/UCI HAR Dataset/train/y_train.txt")
trainDataSubjects <- read.table("./ucihar/UCI HAR Dataset/train/subject_train.txt")

#assign features to column names
colnames(trainData) <- features

#add column with activity label indexes by reading first column from the label dataset
trainData$ActivityIndex <- trainDataLabels[,1]

#add colum with subject indexes by reading first colum of subject dataset
trainData$SubjectIndex <- trainDataSubjects[,1]

require("plyr")
require("dplyr")


#arrange columns
testData <- testData[,sort(colnames(testData))]
trainData <- trainData[,sort(colnames(trainData))]

#merge test and train to get single dataset
resData <- merge(testData, trainData, all=TRUE, sort=FALSE)


#get only std and mean columns

#select std and mean columns
resultColumns <- grep("ActivityIndex|SubjectIndex|-mean\\(\\)|-std\\(\\)", colnames(joinedData))
resultDataStage1 <- joinedData[ ,resultColumns]

#summarize data
resultData <- ddply(resultDataStage1, .(ActivityIndex,SubjectIndex), colMeans)

#label activities
resultData <- left_join(resultData, a_labels_ds)

#re-arrange column names
colsd <- as.data.frame(colnames(resultData))
colnames(colsd) <- c("ColName")
colsd_std_mean <- filter(colsd, !(ColName %in% c("ActivityName", "SubjectIndex", "ActivityIndex"))) %>% arrange(ColName)

#skip ActivityIndex to maintain tidy dataset rules
resultColnames <- append(c("ActivityName", "SubjectIndex"),as.vector(colsd_std_mean[,1]))
resultDataPretty <- resultData[,resultColnames]
write.table(resultDataPretty, file = "result.tab", row.names = FALSE, append=FALSE)

#use this to read it back: read.table("result.tab", header=TRUE)

