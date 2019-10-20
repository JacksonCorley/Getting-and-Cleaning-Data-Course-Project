	### **title: Getting and Cleaning Data Coursera Assignment**
	### **author: Jackson Corley**
	### **date: 10/20/2019**
	### **output: FinalData.txt**
  
#**Project Description**
The run_analysis.R script performs the required steps as described in the course project’s definition.
	## **Check if zipped file exists**
		○ Dataset downloaded from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
	## **Check if folder exists**
		○ extracts under the folder called UCI HAR Dataset
	## **Assign each data to variables**
		○ features <- features.txt : 561 rows, 2 columns
        	contains a list of measurements that were taken.
		○ activities <- activity_labels.txt : 6 rows, 2 columns
        	contains activity performed when the corresponding measurements were taken and teh activity's code
		○ subject_test <- test/subject_test.txt : 2947 rows, 1 column
        	contains test data of test subjects being observed
		○ x_test <- test/X_test.txt : 2947 rows, 561 columns
        	contains recorded features test data
		○ y_test <- test/y_test.txt : 2947 rows, 1 columns
        	contains test data of activities’code labels
		○ subject_train <- test/subject_train.txt : 7352 rows, 1 column
        	contains train data of subjects being observed
		○ x_train <- test/X_train.txt : 7352 rows, 561 columns
        	contains recorded features train data
		○ y_train <- test/y_train.txt : 7352 rows, 1 columns
        	contains train data of activities’code labels
	## **Merges the training and the test sets to create one data set**
		○ X (10299 rows, 561 columns) created by merging x_train and x_test using rbind() function
		○ Y (10299 rows, 1 column) created by merging y_train and y_test using rbind() function
		○ Subject (10299 rows, 1 column) created by merging subject_train and subject_test using rbind() function
		○ Merged_Data (10299 rows, 563 column) created by merging Subject, Y and X using cbind() function
	## **Extracts only the measurements on the mean and standard deviation for each measurement**
		○ TidyData (10299 rows, 88 columns) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement
	## **Uses descriptive activity names to name the activities in the data set**
		○ Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the activities variable
	## **Appropriately labels the data set with descriptive variable names**
		○ code column in TidyData renamed into activities
		○ All Acc in column’s name replaced by accelerometer
		○ All Gyro in column’s name replaced by gyroscope
		○ All BodyBody in column’s name replaced by body
		○ All Mag in column’s name replaced by magnitude
		○ All start with character f in column’s name replaced by frequency
		○ All start with character t in column’s name replaced by time
	## **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
		○ FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
			Export FinalData into FinalData.txt file.