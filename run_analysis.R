setwd('UCI\ HAR\ Dataset')
# Reads data into corresponding tables
X_test<-read.table("test/X_test.txt",header=FALSE)
Y_test<-read.table("test/y_test.txt",header=FALSE)
subject_test<-read.table("test/subject_test.txt",header=FALSE)
subject_train<-read.table("train/subject_train.txt",header=FALSE)
Y_train<-read.table("train/y_train.txt",header=FALSE)
X_train<-read.table("train/X_train.txt",header=FALSE)
features<-read.table('features.txt',header=FALSE)
feature_header<-features[[2]]

#creates a list of column names for the super set
temp<-factor(append("activity",as.character(feature_header)))
temp<-factor(append("subject",as.character(temp)))
activity_labels<-read.table('activity_labels.txt',header = FALSE)

#binds all training data into one set
activity_data_train<-cbind(subject_train, Y_train, X_train)

#Appropriately labels the data set with descriptive variable names. 
colnames(activity_data_train)<- temp

#binds all test data into one set
activity_data_test<-cbind(subject_test, Y_test, X_test)
colnames(activity_data_test)<- temp

#merges the training and test data sets
mergedData <- rbind(activity_data_train, activity_data_test)

#removes duplicate columns
deDuplicatedData <- mergedData[ , !duplicated(colnames(mergedData))]

#extracts columns that are either mean or standard deviation
library(dplyr)
mean_and_std_data<-select(deDuplicatedData, matches("mean\\(\\)|std\\(\\)|subject|activity",ignore.case = FALSE))
labelled_data<-merge(mean_and_std_data,activity_labels,by.x = "activity", by.y = "V1")

#puts the correct labels onto the data set
colnames(labelled_data)[colnames(labelled_data) == 'V2'] <- 'activity_label'

tidy_data<-aggregate(labelled_data[, 3:68], list(labelled_data$activity_label,labelled_data$subject), mean)
