# Scope 
This codebook describes the contents of file [AverageMeasurements.txt](AverageMeasurements.txt)

This file provides a reduced summary data set based on the measurements of the original data set (see the section below for more details)

# Contents
For each individual of the 30 volunteers (as identified by the "Subject.ID") performing each of the 6 activities (as identified by the "Activity") the average value of 66 different measured quantities is given. 
The measured quantities are listed below. Since the original data were normalized and bounded in [-1,1] so are the average values given in this reduced data set. 

## Indices (subject performing activity)

*  "Subject.ID" 
    - identifies the individual volunteer, values are of the form Subject.<nn>, where <nn> is a 2-digit number ranging from 1 to 30 for the 30 volunteers

 *  "Activity"                                             
    - identifies the particular activity, values are {WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING} 

## Average Values from the measurements 
 
*  "body acceleration in time domain mean-X"              
*  "body acceleration in time domain mean-Y"              
*  "body acceleration in time domain mean-Z"              
*  "gravity acceleration in time domain mean-X"           
*  "gravity acceleration in time domain mean-Y"           
*  "gravity acceleration in time domain mean-Z"           
*  "body acceleration Jerk in time domain mean-X"         
*  "body acceleration Jerk in time domain mean-Y"         
*  "body acceleration Jerk in time domain mean-Z"         
*  "angular velocity in time domain mean-X"               
*  "angular velocity in time domain mean-Y"               
*  "angular velocity in time domain mean-Z"               
*  "angular Velocity jerk in time domain mean-X"          
*  "angular Velocity jerk in time domain mean-Y"          
*  "angular Velocity jerk in time domain mean-Z"          
*  "body acceleration magnitude in time domain mean"      
*  "gravity acceleration magnitude in time domain mean"   
*  "body acceleration jerk magnitude in time domain mean" 
*  "angular velocity magnitude in time domain mean"       
*  "angular velocity jerk magnitude in time domain mean"  
*  "body acceleration in freq domain mean-X"              
*  "body acceleration in freq domain mean-Y"              
*  "body acceleration in freq domain mean-Z"              
*  "body acceleration Jerk in freq domain mean-X"         
*  "body acceleration Jerk in freq domain mean-Y"         
*  "body acceleration Jerk in freq domain mean-Z"         
*  "angular velocity in freq domain mean-X"               
*  "angular velocity in freq domain mean-Y"               
*  "angular velocity in freq domain mean-Z"               
*  "body acceleration magnitude in freq domain mean"      
*  "body acceleration jerk magnitude in freq domain mean" 
*  "angular velocity magnitude in freq domain mean"       
*  "angular velocity jerk magnitude in freq domain mean"  
*  "body acceleration in time domain stdev-X"             
*  "body acceleration in time domain stdev-Y"             
*  "body acceleration in time domain stdev-Z"             
*  "gravity acceleration in time domain stdev-X"          
*  "gravity acceleration in time domain stdev-Y"          
*  "gravity acceleration in time domain stdev-Z"          
*  "body acceleration Jerk in time domain stdev-X"        
*  "body acceleration Jerk in time domain stdev-Y"        
*  "body acceleration Jerk in time domain stdev-Z"        
*  "angular velocity in time domain stdev-X"              
*  "angular velocity in time domain stdev-Y"              
*  "angular velocity in time domain stdev-Z"              
*  "angular Velocity jerk in time domain stdev-X"         
*  "angular Velocity jerk in time domain stdev-Y"         
*  "angular Velocity jerk in time domain stdev-Z"         
*  "body acceleration magnitude in time domain stdev"     
*  "gravity acceleration magnitude in time domain stdev"  
*  "body acceleration jerk magnitude in time domain stdev"
*  "angular velocity magnitude in time domain stdev"      
*  "angular velocity jerk magnitude in time domain stdev" 
*  "body acceleration in freq domain stdev-X"             
*  "body acceleration in freq domain stdev-Y"             
*  "body acceleration in freq domain stdev-Z"             
*  "body acceleration Jerk in freq domain stdev-X"        
*  "body acceleration Jerk in freq domain stdev-Y"        
*  "body acceleration Jerk in freq domain stdev-Z"        
*  "angular velocity in freq domain stdev-X"              
*  "angular velocity in freq domain stdev-Y"              
*  "angular velocity in freq domain stdev-Z"              
*  "body acceleration magnitude in freq domain stdev"     
*  "body acceleration jerk magnitude in freq domain stdev"
*  "angular velocity magnitude in freq domain stdev"      
*  "angular velocity jerk magnitude in freq domain stdev"

## Original data set

The original data set used for calculating the averages above is 

Human Activity Recognition Using Smartphones Dataset
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universitΰ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data were retrieved on July 26th 2018 from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Data values of the original dat

The information on the measured values is taken from the explanatory files accompanying the original data, which are also uploaded in this repo for easier reference:
* [README.txt](README.txt)
* [features_info.txt](features_info.txt)

## Process to create the Average Measurements data set

We've merged the training and test sets of the original data 
We keep only the measurements on the mean and standard deviation for each measurement type
We average the measurements for each activity and each subject.

### R Code to process the data

The code is contained in [run_analysis.R](run_analysis.R)
