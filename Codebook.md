### Code Book
This code book that describes the variables, the data, and any transformations or work that I performed to clean up the data.

###Original Data

This data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Data Set Information

The dataset includes the following relevant files:

-	'features_info.txt': Shows detailed information about the variables used on the feature vector.
-	'features.txt': A list of the features -- if the sets below had column names, these are they.
-	'activity_labels.txt': Links the class labels with their activity name.
-	'train/X_train.txt': Training set.
-	'train/y_train.txt': Training labels. (The numeric numbers of the activity from activity_labels)
-	'test/X_test.txt': Test set.
-	'test/y_test.txt': Test labels. (The numeric numbers of the activity from activity_labels)


### Steps to get tidy data set 

- Download the dataset zip above, and expand it into a folder called "UCI HAR Dataset"

###Overview of run_analysis.R script 

- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement. 
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names. 
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
