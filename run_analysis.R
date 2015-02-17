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

        targetDF <- X_test[,allNdx]
        zhaan <- merge(y_test, activity_labels)
        targetDF$activity_name <- zhaan$activity_name

        X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$feature_name, quote="\"")
        y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = c('activity_id'), quote="\"")

        targetDF2 <- X_train[,allNdx]
        zhaan <- merge(y_train, activity_labels)
        targetDF2$activity_name <- zhaan$activity_name

##        newrowmin <- nrow(targetDF) + 1
##        newrowmax <- newrowmin+nrow(targetDF2) - 1
##        rownames(targetDF2) <- newrowmin:newrowmax
        
        rbind(targetDF,targetDF2)
}
