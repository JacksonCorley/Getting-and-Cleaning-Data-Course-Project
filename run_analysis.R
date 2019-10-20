
library(dplyr)

filename <- "Coursera_Samsung_Data.zip"

# Step 1: Check if archive already exists.
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileURL, filename)
}

# Step 2: Check if folder exists
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

# Step 3: Load required tables
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


#Step 4: Combines the training and test data sets into one dataset.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#Step 5: Extracts only the columns containing mean or standard deviation.
TidyData <- Merged_Data %>% 
        select(subject, code, contains("mean"), contains("std"))

#Step 6: Uses descriptive activity names to name the activities in the data set.
TidyData$code <- activities[TidyData$code, 2]

#Step 7: Labels the data according to inofrmation provided in the Readme file
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "body", names(TidyData))
names(TidyData)<-gsub("Mag", "magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "time", names(TidyData))
names(TidyData)<-gsub("^f", "frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "timeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "std", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "angle", names(TidyData))
names(TidyData)<-gsub("gravity", "gravity", names(TidyData))

#Step 8: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- TidyData %>%
        group_by(subject, activity) %>%
        summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

