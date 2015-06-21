# This script takes the data from the Human Activity Recognition Via Smartphones Dataset and ultimately summarizes
# the average of the standard deviation and mean readings for each of the participants.  See associated README and
# CodeBook files for more information. 

# Loading any necessary or helpful libraries.
library(plyr)
library(reshape2)
library(jpeg)
library(RCurl)
library(Hmisc)
library(dplyr)
library(data.table)

# Reading in the data from the participants that were categorized as "test" subjects and "training" subjects into
# into two separate data frames just to keep things clean and simple. 
ReadXTest = read.table("/home/s/Documents/GettingCleaningData/X_test.txt")
ReadXTrain = read.table("/home/s/Documents/GettingCleaningData/X_train.txt")

# Doing the necessary data frame column labeling
ColNames = read.table("/home/s/Documents/GettingCleaningData/features.txt")
ColLabels = ColNames$V2
colnames(ReadXTest) <- ColLabels
colnames(ReadXTrain) <- ColLabels

# Connecting the participants' labels to their data entries.
Testnames <- scan("/home/s/Documents/GettingCleaningData/y_test.txt", what = character())
Trainnames <- scan("/home/s/Documents/GettingCleaningData/y_train.txt", what = character())
TestwActivities = cbind(Activity_Class = Testnames, ReadXTest)
TrainwActivities = cbind(Activity_Class = Trainnames, ReadXTrain)
ReadSubjectTrain = read.table("/home/s/Documents/GettingCleaningData/subject_train.txt")
ReadSubjectTest = read.table("/home/s/Documents/GettingCleaningData/subject_test.txt")
SubjectNamesTest = ReadSubjectTest$V1
SubjectNamesTrain = ReadSubjectTrain$V1
TestwActSubj = cbind(Subject_Number = SubjectNamesTest, TestwActivities)
TrainwActSubj = cbind(Subject_Number = SubjectNamesTrain, TrainwActivities)

# Labeling the participants' activities with human-friendly names 
Activity_Labels = read.table("/home/s/Documents/GettingCleaningData/activity_labels.txt")
TestwActSubj$Activity_Class = as.numeric(TestwActSubj$Activity_Class)
TrainwActSubj$Activity_Class = as.numeric(TrainwActSubj$Activity_Class)

# Specifically adding the human-friendly labeling for the data frame that has the "test" participants
TestwActSubj$Activity_Description <- 0
TestwActSubj$Activity_Description <- as.character(TestwActSubj$Activity_Description)
MergedTest <- TestwActSubj
for (count in 1:nrow(MergedTest)) {
 for (i in 1:6) {
  if (MergedTest$Activity_Class[count] == Activity_Labels$V1[i]) {MergedTest$Activity_Description[count] <- as.character(Activity_Labels$V2[i])}  
  }
}
MergedTestComplete <- MergedTest
MergedTestComplete$Random_Categorization <- "Test"  # Just wanted to add a column identifying the participant as "Test"

# Specifically adding the human-friendly labeling for the data frame that has the "train" participants
TrainwActSubj$Activity_Description <- 0
TrainwActSubj$Activity_Description <- as.character(TrainwActSubj$Activity_Description)
MergedTrain <- TrainwActSubj
for (count in 1:nrow(MergedTrain)) {
  for (i in 1:6) {
    if (MergedTrain$Activity_Class[count] == Activity_Labels$V1[i]) {MergedTrain$Activity_Description[count] <- as.character(Activity_Labels$V2[i])}  
  }
}
MergedTrainComplete <- MergedTrain
MergedTrainComplete$Random_Categorization <- "Training" # Just wanted to add a column identifying the participant as "Training"

# Finally, the merging of the "test" participant data with the "training" participant data
FinalDataSet <- rbind(MergedTestComplete, MergedTrainComplete)

# Time to focus on the mean and standard deviation data for each participant.  So we're identifying columns 
# with any standard deviation or mean calculations for each participant.
GetMeanStd <- grep("std|mean|Subject_Number|Activity_Class|Random_Categorization", names(FinalDataSet), value=TRUE)
MeanStdDataSet <- FinalDataSet[ , which(names(FinalDataSet) %in% GetMeanStd )]

# Creating human-friendly labeling for the combined data frame that has the participant means and standard deviations.
names(MeanStdDataSet) <- gsub("tBodyAcc", "Time-BodyAccelSignal", names(MeanStdDataSet))
names(MeanStdDataSet) <- gsub("tGravityAcc", "Time-GravityAccelSignal", names(MeanStdDataSet))
names(MeanStdDataSet) <- gsub("tBodyGyro", "Time-BodyGyroscopeSignal", names(MeanStdDataSet))
names(MeanStdDataSet) <- gsub("fBodyAcc", "Freq-BodyAccelSignal", names(MeanStdDataSet))
names(MeanStdDataSet) <- gsub("fBodyBodyAcc", "Freq-BodyAccelSignal", names(MeanStdDataSet))
names(MeanStdDataSet) <- gsub("fBodyGyro", "Freq-BodyGyroscopeSignal", names(MeanStdDataSet))
names(MeanStdDataSet) <- gsub("fBodyBodyGyro", "Freq-BodyGyroscopeSignal", names(MeanStdDataSet))

# Creating the final data frame showing the average standard deviation and means readings for each participant.
FinalAvg<-data.frame(stringsAsFactors=FALSE)
NoDupeSubjNameTest <- unique(SubjectNamesTest)
NoDupeSubjNameTrain <- unique(SubjectNamesTrain)
TotalNoDupeSubjNames <- c(NoDupeSubjNameTest,NoDupeSubjNameTrain)
for(rowname in TotalNoDupeSubjNames){
  holder <- MeanStdDataSet[MeanStdDataSet$Subject_Number == rowname,]
  holder$Random_Categorization <- NULL
  Meansholder <- colMeans(holder)
  FinalAvg <- rbind(FinalAvg,Meansholder)
}
names(FinalAvg) <- names(Meansholder)
FinalAvg$Subject_Number <- round(FinalAvg$Subject_Number,0)
FinalAvg$Activity_Class <- NULL

return(FinalAvg)

# Creating a file of the final data frame to submit for grading
# write.table(FinalAvg, file = "./GettingCleaningData/run_analysis.txt", row.name=FALSE)
