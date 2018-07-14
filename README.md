# GetCleanDataAssignment
Coursera Getting and Cleaning Data Assignment

This is the submission for the Programming Assignment for the Coursera Getting & Cleaning Data course

Author: Arup Mitra

PREREQUISITES FOR RUNNING the code
-----------------------------------
1. All the data files should be in the working directory of R.
2. Source the run_analysis.R code in R. 
2. For reading the final output, in RStudio, please use:

    mydata <- read.table("FinalCleanData.txt", header = TRUE)

    View(mydata)


PROGRAM LOGIC
---------------
The program begins by reading in the test & training data + label files into corresponding 
data sets as detailed in the in-line comments provided in the code.

The test data and training data are appended using the rbind function. 
Similarly the labels for each are also merged using rbind.

After this is done, the next section deals with providing appropriate labels.
This is detailed out in the comments of the code. The objective is to complete 
the labelling and merging of the data into a complete data frame. This is followed by subsetting 
the data by grep-ing on the words mean and std in the column names.

The next step is to join the activity labels from the activity label data set, and then group 
the data on the activity & subject variables to find the mean for every other column.

Finally, the data set column names are made more meaningful by grep-ing on the appropriate 
abbreviated column names and replacing them with expanded words. 

At the end, the data frame is written into a file "FinalCleanData.txt"






