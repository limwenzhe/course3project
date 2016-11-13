
setwd("UCI HAR Dataset")

# Tidying the UCI HAR Dataset, which is split into subjects, activities, features and measurements.

library(tidyr)
library(dplyr)
library(reshape2)

# Loading the test and train datasets

test <- read.table("test/X_test.txt")
train <- read.table("train/X_train.txt")

# Adding feature names to the datasets

names(test) <- read.table("features.txt")[,2]
names(train) <- read.table("features.txt")[,2]

# adding subject labels

test$subject <- read.table("test/subject_test.txt")[,1]
train$subject <- read.table("train/subject_train.txt")[,1]

# adding activity labels

test$activity <- read.table("test/y_test.txt")[,1]
train$activity <- read.table("train/y_train.txt")[,1]

# merging the datasets

allData <- rbind(test, train)

# extract only measurements on mean and std of features

keep <- grepl("mean\\()|std\\()|subject|activity", names(allData))
selected <- allData[, keep]

# gathering the dataset on the key "feature", keeping subject and activity

tidy1 <- gather(selected, feature, value, -c(subject, activity))

# creating a new column indicating whether the measurement is for mean or standard deviation

tidy1$measure <- grepl("mean\\()", tidy1$feature)
tidy1$measure <- ifelse(tidy1$measure == TRUE, "mean", "std")
tidy1$feature <- gsub("-mean\\()|-std\\()", "", tidy1$feature)

# adding descriptive activity names

activityLabels <- read.table("activity_labels.txt")
tidy1 <- mutate(tidy1, activity = tolower(activityLabels[activity, 2]))

# converting the subject and activity columns to factors

tidy1$activity <- as.factor(tidy1$activity)
tidy1$subject <- as.factor(tidy1$subject)

# creating a second table which gives the average mean and std readings for each variable, grouped by activity and subject

tidy2 <- dcast(tidy1, subject + activity + feature ~ measure, mean)

# writes the new table to a .txt file

write.table(tidy2, "tidy2.txt")