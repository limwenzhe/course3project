# course3project
Course Project for Getting and Cleaning Data, Data Science Specialisation

This repo contains a script ("run_analysis.R") and a codebook ("codebook.md") detailing transformations to the UCI HAR Dataset.

The data contains smartphone accelerometer and gyrometer data. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script aims to gather the data into columns for subject, activity, feature, measure (mean or standard deviation) and value. A second tidy dataset is then created averaging the measures for each variable, across each subject and activity.
