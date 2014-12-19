## Download necessary packages
install.packages("reshape2")
library(reshape2)

install.packages("data.table")
library(data.table)

## Download the data

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile <- "./data/activity.zip")   
unzip("./data/activity.zip")

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

## 2) Extract the measurements of mean and standard deviation

extract_features <- grepl("mean|std", features)

## Read in test
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

## Name test

names(X_test) = features
X_test = X_test[,extract_features]

## 3) Name the activities
Y_test[,2] = activity_labels[Y_test[,1]]
names(Y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

## Merge test data

test <- cbind(as.data.table(subject_test), Y_test, X_test)

## Read in train
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

## Name train

names(X_train) = features
X_train = X_train[,extract_features]

## 3) Name the activities
Y_train[,2] = activity_labels[Y_train[,1]]
names(Y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

## Merge test data
train <- cbind(as.data.table(subject_train), Y_train, X_train)

## 1) Merge the train and test sets
data = rbind(test, train)

id_labels = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data = melt(data, id = id_labels, measure.vars = data_labels)

## 5) Create a second data set with averages
tidy_data = dcast(melt_data, subject + Activity_Label ~ variable, mean)

write.table(tidy_data, file = "./activity_tidy_data.txt")