library(plyr)
library(dplyr)

run_analysis <- function() {
        rm(list = ls())

        features <- read.table("UCI HAR Dataset/features.txt", col.names = c('feature_id', 'feature_name'), quote="\"")
        activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c('activity_id', 'activity_name'), quote="\"")

        ## use a regular expression to find all the features that are Mean-related
        meanPattern <- '.*mean*?'
        meanNdx = grep(meanPattern, features$feature_name, perl=T)

        ## use a regular expression to find all the features that are Standard Deviation-related
        stdPattern <- '.*std.*'
        stdNdx = grep(stdPattern, features$feature_name, perl=T)

        ## append the two lists together to find a discrete set of features we want, by index
        allNdx <- append(meanNdx, stdNdx)

        X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$feature_name, quote="\"")        
        y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = c('activity_id'), quote="\"")
        subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c('subject_id'), quote="\"")

        # splice in the activity names and subject IDs
        targetDF <- X_test[,allNdx]
        joined <- join(y_test, activity_labels)
        targetDF$activity_name <- joined$activity_name
        targetDF$subject_id <- subjects_test$subject_id

        X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature_name, quote="\"")
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c('activity_id'), quote="\"")
        subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c('subject_id'), quote="\"")

        # splice in the activity names and subject IDs
        targetDF2 <- X_train[,allNdx]
        joined <- join(y_train, activity_labels)
        targetDF2$activity_name <- joined$activity_name
        targetDF2$subject_id <- subjects_train$subject_id

        ## rbind combines the test and train data frames, which is the output for Step 4
        step4 <- rbind(targetDF,targetDF2)

        ## step 5: pivot the data using dplyr
        ## dplyr is *amazingly* powerful
        ## http://marcoghislanzoni.com/blog/2014/09/01/pivot-tables-r-dplyr/ for usage of the pipe %>% operator and group_by
        ## http://stackoverflow.com/a/25839767 for summarise_each
        step5 <- step4 %>% group_by(subject_id,activity_name) %>% summarise_each(funs(mean))
}
