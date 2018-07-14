## Code for Programming Assignment - Coursera Getting & Cleaning Data
## Author: Arup Mitra
## July 14, 2018

##Section 1: Reads the data files
##Read the "test" data into data frame test tab
##Read the "test" labels into data frame testlabel

testtab<-read.table("X_test.txt",header=FALSE)
testlabel<-read.table("y_test.txt",header=FALSE)

## Read the "train" data into dataframe traintab
## Read the "train" labels into dataframe trainlabel

traintab<-read.table("X_train.txt",header=FALSE)
trainlabel<-read.table("y_train.txt",header=FALSE)

## In this section the processing begins!!


## First we append the rows of the training data at the end of the test data using rbind
mergedata<-rbind(testtab,traintab)

## We read in the list of features - this is then used as the column names 
## for the merged data

featuresdata<-read.table("features.txt", header=FALSE,stringsAsFactors = FALSE)

colnames(mergedata)<-featuresdata[,2]

## Now we append the labels for train at the end of the test labels
mergelabel<-rbind(testlabel,trainlabel)

## We load the subject data into data frame subjecttest and subjecttrain 
## for test and training data respectively

subjecttest<-read.table("subject_test.txt", header=FALSE)
subjecttrain<-read.table("subject_train.txt", header=FALSE)

## Just like above, we append the training subject data to the end of the test data
## Then include the subject data as a column into the merged subject data
mergesubject<-rbind(subjecttest,subjecttrain)
datawithsubject<-cbind(mergesubject,mergedata)

## Next step is to insert the labels as well as the first column. Now 
## we have the full labelled data
fulldata<- cbind(mergelabel,datawithsubject)

## Lets change the column names for the Activity and Subject
colnames(fulldata)[1]<-"Activity"
colnames(fulldata)[2]<-"Subject"

## Now lets subset only the columns which have mean or std in the column name
## as per requirement 2
meanstddata<-fulldata[ , 
        c(1,2,grep( "mean|std" , names(fulldata), value = FALSE)) ]

## Read in the activity labels into a data frame
activitylabel<-read.table("activity_labels.txt",header=FALSE, stringsAsFactors = FALSE)

## Now join the two data frames to provide the descriptive Activity label
labelledstdmean<-merge(activitylabel,meanstddata,by.x="V1", by.y="Activity")

## Finally we do the group by on the activity and subject and compute mean
## for each variable
meandata<-aggregate(labelledstdmean[, 4:82], 
                    list(labelledstdmean$V2,labelledstdmean$Subject), 
                    mean)

## Once again - change the col names to descriptive names
colnames(meandata)[1]<-"Activity"
colnames(meandata)[2]<-"Subject"

## The following section is entirely focussed on providing meaningful names
## I have used gsub function to replace the various substrings to more meaningful
## words
colnames(meandata)<-gsub("tBodyAcc-mean\\()-",
                         "Triaxial Body Accel Mean-", 
                         names(meandata))

colnames(meandata)<-gsub("tBodyAcc-std\\()-",
                        "Triaxial Body Accel Std Dev-", 
                        names(meandata))

colnames(meandata)<-gsub("tGravityAcc-mean\\()-",
                         "Triaxial Gravity Accel Mean-", 
                         names(meandata))

colnames(meandata)<-gsub("tGravityAcc-std\\()-",
                        "Triaxial Gravity Accel Std Dev-", 
                        names(meandata))
colnames(meandata)<-gsub("tBodyAccJerk-mean\\()-",
                         "Triaxial Body Accel Jerk Mean-", 
                         names(meandata))
colnames(meandata)<-gsub("tBodyAccJerk-std\\()-",
                        "Triaxial Body Accel Jerk Std Dev-", 
                        names(meandata))

colnames(meandata)<-gsub("tBody",
                        "Triaxial Body ", 
                        names(meandata))
colnames(meandata)<-gsub("-mean\\()",
                        "Mean ", 
                        names(meandata))
colnames(meandata)<-gsub("-std\\()",
                         " Std Dev ", 
                         names(meandata))


colnames(meandata)<-gsub("fBody",
                        "F Body ", 
                        names(meandata))

## AND FINALLY - writing the data frame to the file FinalCleanData.txt
write.table(meandata,"FinalCleanData.txt", row.name=FALSE)
