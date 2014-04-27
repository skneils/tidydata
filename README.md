run_analysis.R

The working directory needs to contain the Samsung data folder (UCI HAR Dataset).
The "reshape2" package needs to be installed.

This script loads the test and train datasets in separate data frames.
It loads the activity and feature labels and applies them to the test/train data.
Columns that don't contain mean or std data are removed.  
Data is considered relevant if its label contains "mean(" or "std(".
This excludes data that involves frequency and angles.
Subject data is added to the data frames and then the frames are merged.
Old data is removed to save space.
Data is melted and recast to create "tidydata":
a data frame of means of feature data for each activity/subject pair.
