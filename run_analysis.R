### 
### run_analysis.R
###
#
# Scope 
#
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation 
#    for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names.
# 5. From the data set in step 4, create a second, 
#    independent tidy data set with 
#    the average of each variable for each activity and each subject.
#    a txt file created with write.table() using row.name=FALSE

#
# Required packages
#
library(dplyr)


# FUNCTION: doit()
# perform all steps to complete the assignment
#
doit <- function()
{
    # Download zip file from specified URL and extract data 
    download_and_extract()
    datatables <- read_data()
    
    #
    # 1. Merge the training and the test sets to create one data set.
    
    # -- merge rows (train and test)
    merge_data( datatables)
    
    # -- create one table incl. subject and activity
    full.table <- create_table( subject, y, X)
    
    #
    # 2. Extract only the required measurements 
    # mean and standard deviation
    skimmed.table <- skimm_table( full.table)
    
    # 3. Uses descriptive activity names to name the activities in the data set
    # 4. Appropriately label the data set with descriptive variable names.
    names( skimmed.table) <- create_names( skimmed.table)
    
    # 5. From the data set in step 4, create a second, independent tidy data set
    # with the average of each variable for each activity and each subject.
    
    # group the table by subject and activity 
    grouped.table <- group_by( skimmed.table, Subject.ID, Activity)
        
    # get the average value per subject and activity 
    avg.table <- summarize_all( grouped.table, mean)
        
    # write the table with agerages in a text file
    write.table( avg.table, file = "./AveragedMeasurements.txt", 
                 row.names = FALSE)
    
}



#
# FUNCTION: download_and_extract()
# Download and extract data in local directory 
# ARGUMENTS: -
# RETURNS: -
#
download_and_extract <- function( ) { 
    
    # URL to retrieve data file
    datafile.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    datafile.zip <- "./data.zip"     # name for the zip archive locally
    datafile.dir <- "./data"             # directory to extrac the files
    
    # download the data
    download.file(datafile.url, destfile = datafile.zip)
    
    # create data directory 
    if (!dir.exists(datafile.dir)) { dir.create(datafile.dir) }
    # extract data 
    unzip( datafile.zip, exdir = datafile.dir)
    
    # cleanup - remove the zip file 
    file.remove(datafile.zip)
}

#
# FUNCTION: read_data()
# Read in the data files to data tables 
# Do the assignments in GlobalEnv to enable subsequent use of the data
# returns the list of datatables read from the files
# 
# ARGUMENTS: directory with the data files
# RETURNS: list with the names of the data tables
#
read_data <- function( datafile.dir = "./data") {
    #
    # Create the list of data files
    #
    fnames <- list.files( path = datafile.dir, recursive = TRUE, full.names = TRUE)
    
    # remove from the list the two informational files 
    # features_info.txt - informational element, no data contained
    # README.txt - informational element, no data contained
    fnames <- fnames[-c(grep( "README.txt", fnames),
                        grep( "features_info.txt", fnames))]
    
    # create data tables with the same names as the files
    # use envir = .GlobalEnv in assignment, to make the data available 
    # for interactive use after the call to this function
    for (i in 1:length(fnames)) {
        assign( sub( ".txt$", "", basename(fnames[i])), 
                read.table( fnames[i], header = FALSE),
                envir = .GlobalEnv)
    }
    
    #
    # Create the list of data tables
    #
    datatables <- sub( ".txt$", "", basename(fnames))
}

#
# FUNCTION: merge_data()
# merge <name>_train and <name>_test data to create one table <name>
# Do the assignments in GlobalEnv to enable subsequent use of the data
# ARGUMENTS: list with the names of the data tables (from read_data())
# RETURNS: -
#
merge_data <- function( datatables) {
    
    # remove from the list the first two tables that contain labels
    # [1] activity_labels 
    # [2] features
    # there's no meaning in merging these two 
    datatables <- datatables[-c(1,2)]
    
    # merge the data: 
    # one table containing test rows followed by the train rows 
    # use envir = .GlobalEnv in assignment, to make the data available 
    # for interactive use after the call to this function
    for (i in 1:12) {
        assign( sub( ".test$", "", datatables[i]), 
                rbind( get(datatables[i]), get(datatables[i+12])),
                envir = .GlobalEnv)
    }
}

#
# FUNCTION: create_table()
# Create one data table for subsequent use
# ARGUMENTS: - the three tables
#   subject - the table with the subject IDs
#   y - the table with the activities
#   X - the table with the observations / measurements
#
# RETURNS: the merged data table
#
create_table <- function( subject, y, X) {
    
    # X data table (measurements) 
    # - observation/row containst the measurement for each of the "features" 
    # - column names are Vnnn - replace with the respective feature names  
    names( X) <- features[,2]
    
    # y data table (activities)
    # - the number corresponding to the "activity" for each observation
    # 
    # create a factor from the activity_labels
    activity_factor <- factor(  sub( "^[0-9] ", "", activity_labels[,2]))
    # column name "Activity"
    names( y) <- "Activity"
    # replace the activity number with the activity name
    y = transmute(y, Activity = activity_factor[Activity])
    
    
    # subject data table 
    # - the number corresponding to the "subject" for each observation
    
    # create subject IDs in the form "Subject.nn", 
    # where nn in the subject number 1:30 
    subject_factor <- factor( sprintf( 'Subject.%0.2d', 
                                        sort(unique(subject)[,1])))
    # column name "Subject.ID"
    names( subject) <- "Subject.ID"
    # replace the subject number with the respective subject name
    subject = transmute( subject, Subject.ID = subject_factor[Subject.ID])
        
    # create one data table putting the three tables together
    # Subject.ID - Activity - features<1>...feature<561>
    
    # RETURNS the data table with all columns
    full.table <<- cbind(subject, y, X)
    
}

#
# FUNCTION: skimm_table()
# Reduce table size keeping only mean and std.dev measurements
# ARGUMENTS: 
# - the full data table (from create_table())
# RETURNS:  the data table containig only mean and std.dev observations
#           fewer columns 
#
skimm_table <- function( full.table) {

    # - which features refer to the mean() and std() values
    features <- colnames( full.table)
     
    features.mean <- grep( "-mean()", features, value = TRUE, fixed = TRUE)
    features.std <- grep( "-std()", features, value = TRUE, fixed = TRUE)

    skimmed.table <- full.table[ c( colnames(full.table)[1:2], 
                                features.mean, 
                                features.std)]
    
}

#
# FUNCTION: create_names()
# Create the column names for the table with descriptive names
# ARGUMENTS: 
#   - the reduced data table containig only mean and std.dev observations 
#   (from skimm_table())
# RETURNS:  the new name list to use
# USAGE: names(table) <- create_names(table), to change the names 
#
create_names <- function( table) {
    
    newnames <- names(table)
    
    # correction for error to use "BodyBody" instead of "Body" in feature list
    newnames <- gsub( "BodyBody", "Body", newnames)
    
    # this code is used to change the variable names to readable 
    
    newnames <- gsub( "tBodyAcc-", "body acceleration in time domain ", newnames)
    newnames <- gsub( "tGravityAcc-", "gravity acceleration in time domain ", newnames)
    newnames <- gsub( "tBodyAccJerk-", "body acceleration Jerk in time domain ", newnames)
    newnames <- gsub( "tBodyGyro-", "angular velocity in time domain ", newnames)
    newnames <- gsub( "tBodyGyroJerk-", "angular Velocity jerk in time domain ", newnames)
    newnames <- gsub( "tBodyAccMag-", "body acceleration magnitude in time domain ", newnames)
    newnames <- gsub( "tGravityAccMag-", "gravity acceleration magnitude in time domain ", newnames)
    newnames <- gsub( "tBodyAccJerkMag-", "body acceleration jerk magnitude in time domain ", newnames)
    newnames <- gsub( "tBodyGyroMag-", "angular velocity magnitude in time domain ", newnames)
    newnames <- gsub( "tBodyGyroJerkMag-", "angular velocity jerk magnitude in time domain ", newnames)
    
    newnames <- gsub( "fBodyAcc-", "body acceleration in freq domain ", newnames)
    newnames <- gsub( "fGravityAcc-", "gravity acceleration in freq domain ", newnames)
    newnames <- gsub( "fBodyAccJerk-", "body acceleration Jerk in freq domain ", newnames)
    newnames <- gsub( "fBodyGyro-", "angular velocity in freq domain ", newnames)
    newnames <- gsub( "fBodyGyroJerk-", "angular Velocity jerk in freq domain ", newnames)
    newnames <- gsub( "fBodyAccMag-", "body acceleration magnitude in freq domain ", newnames)
    newnames <- gsub( "fGravityAccMag-", "gravity acceleration magnitude in freq domain ", newnames)
    newnames <- gsub( "fBodyAccJerkMag-", "body acceleration jerk magnitude in freq domain ", newnames)
    newnames <- gsub( "fBodyGyroMag-", "angular velocity magnitude in freq domain ", newnames)
    newnames <- gsub( "fBodyGyroJerkMag-", "angular velocity jerk magnitude in freq domain ", newnames)
    
    newnames <- gsub( "mean\\(\\)", "mean", newnames)
    newnames <- gsub( "std\\(\\)", "stdev", newnames)
    
    newnames
}
