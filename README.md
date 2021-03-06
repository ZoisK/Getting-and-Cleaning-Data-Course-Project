# Getting-and-Cleaning-Data-Course-Project
This repo contains the deliverables for the "Getting and Cleaning Data Course Project" 

## Tidy Data

The file [AverageMeasurements.txt](AverageMeasurements.txt) contains the calculated average measurements of the mean and standard deviation values for each of the volunteers perfroming each of the activities. 

## Codebook

The file [Codebook.md](Codebook.md) explains the contents of the file [AverageMeasurements.txt](AverageMeasurements.txt) and how these were calculated.

## Raw Data (UCI-HAR)
The raw data come from the following source:

Human Activity Recognition Using Smartphones Dataset
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - UniversitÎ° degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data were retrieved on July 26th 2018 from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data is not uploaded in this repo to avoid unnecessary data volume. 

## R script 

The script [run_analysis.R](run_analysis.R) contains all necessary functions 
Comments in the code explain the functionality in more detail.
The code is split in functions to make it easier to operate, 
however the functions are not really meant to be self-sustained. 
To allow interactive data manipulation in RStudio the data tables are created in Global Environment. 

### USAGE
```R
> source run_analysis.R # this will load the necesary code
> doit() # this runs all steps to complete the work
```

### FUNCTIONS
The following functions are implemented in the R script file; check the source code comments for more details on the implementation 

##### doit()
This is a program-like function calling in subsequent steps all other functions as needed 

##### download_and_extract()
Download and extract data in local directory 


##### read_data()
Read in the data files to data tables in R. 
Do the assignments in GlobalEnv to enable subsequent use of the data

##### merge_data()
Merges <name>_train and <name>_test data to create one table <name>
Do the assignments in GlobalEnv to enable subsequent use of the data

##### create_table()
Create one merged data table with subject, activity, measurements

##### skimm_table()
Reduce the number of columns in the table keeping only mean and std.dev measurements

##### create_names()
Create the descriptive column names for the table. 

## Notes

### Known Limitations

