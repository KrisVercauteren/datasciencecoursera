The run_analysis.R script performs the data preparation and then followed by the 5 steps required as described in the course project's definition.

1.  Download the dataset Dataset downloaded and extracted under the folder called UCI HAR Dataset
2.  Assign each data to variables
    -   features : the features selected for this database
    -   activities : list of activities performed when the corresponding measurements were taken and its codes
    -   x_test : contains recorded features test data
    -   y_test : contains test data of activities code labels
    -   subject_test : contains test data of 9/30 volunteer test subjects
    -   subject_train : contains training data of 21/30 volunteer subjects being observed
    -   x_train : contains recorded features train data
    -   y_train : contains train data of activities code labels
3.  Merges the training and the test sets to create one data set
    -   comboX : is created by merging x_train and x_test using **rbind** function
    -   comboY : is created by merging y_train and y_test using **rbind** function
    -   subjectCombo : is created by merging subject_train and subject_test using **rbind** function
    -   mergedData : is created by merging subjectCombo, comboY, comboX using **cbind** function
4.  Extracts only the measurements on the mean and standard deviation for each measurement
    -   filteredData : is created by subsetting mergedData, selecting subject, code and the measurements on the mean and standard deviation for each measurement
5.  Uses descriptive activity names to name the activities in the data set
    -   Entire numbers in code column of the filteredData replaced with corresponding activity taken from second column of the activities variable
6.  Appropriately labels the data set with descriptive variable names code column
    -   code column in filteredData renamed into activities
    -   all Acc in column's name replaced by Accelerometer
    -   All Gyro in column's name replaced by Gyroscope
    -   All BodyBody in column's name replaced by Body
    -   All Mag in column's name replaced by Magnitude
    -   All start with character f in column's name replaced by Frequency
    -   All start with character t in column's name replaced by Time
7.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
    -   finalData : is created by sumarizing filteredData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
    -   save finalData is a .txt file
