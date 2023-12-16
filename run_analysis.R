library( dplyr )

#Downloading all Data Sets

filename <- "Coursera_Week4_FinalAssignment.zip"

# Checking if the file already exists.
if ( !file.exists( filename )){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file( fileURL, filename, method="curl" )
}  

# Checking if folder exists
if ( !file.exists( "UCI HAR Dataset" )) { 
  unzip( filename ) 
}

# Assign data frames
features <- read.table( "UCI HAR Dataset/features.txt", col.names = c( "n", "functions" ))
activities <- read.table( "UCI HAR Dataset/activity_labels.txt", col.names = c( "code", "activity" ))

x_test <- read.table( "UCI HAR Dataset/test/X_test.txt", col.names = features$functions )
y_test <- read.table( "UCI HAR Dataset/test/y_test.txt", col.names = "code" )

subject_test <- read.table( "UCI HAR Dataset/test/subject_test.txt", col.names = "subject" )
subject_train <- read.table( "UCI HAR Dataset/train/subject_train.txt", col.names = "subject" )

x_train <- read.table( "UCI HAR Dataset/train/X_train.txt", col.names = features$functions )
y_train <- read.table( "UCI HAR Dataset/train/y_train.txt", col.names = "code" )

# Merge different frames
comboX <- rbind( x_train, x_test )
comboY <- rbind( y_train, y_test )
subjectCombo <- rbind( subject_train, subject_test )
mergedData <- cbind( subjectCombo, comboY, comboX )

# Extracts only the measurements on the mean and standard deviation for each measurement
filteredData <- select( mergedData, subject, code, contains( "mean" ), contains( "std" ))

# Uses descriptive activity names to name the activities in the data set
filteredData$code <- activities[ filteredData$code, 2 ]

# Appropriately labels the data set with descriptive variable names
names( filteredData )[2] = "activity"
names( filteredData ) <- gsub( "Acc", "Accelerometer", names( filteredData ))
names( filteredData ) <- gsub( "Gyro", "Gyroscope", names( filteredData ))
names( filteredData ) <- gsub( "BodyBody", "Body", names( filteredData ))
names( filteredData ) <- gsub( "Mag", "Magnitude", names( filteredData ))
names( filteredData ) <- gsub( "^t", "Time", names( filteredData ))
names( filteredData ) <- gsub( "^f", "Frequency", names( filteredData ))
names( filteredData ) <- gsub( "tBody", "TimeBody", names( filteredData ))
names( filteredData ) <- gsub( "-mean()", "Mean", names( filteredData ), ignore.case = TRUE )
names( filteredData ) <- gsub( "-std()", "STD", names( filteredData ), ignore.case = TRUE )
names( filteredData ) <- gsub( "-freq()", "Frequency", names( filteredData ), ignore.case = TRUE )
names( filteredData ) <- gsub( "angle", "Angle", names( filteredData ))
names( filteredData ) <- gsub( "gravity", "Gravity", names( filteredData ))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
finalData <- group_by( filteredData, subject, activity )
finalData <- summarise_all( finalData, funs( mean ))

write.table( finalData, "FinalData.txt", row.name = FALSE )
