
This Code Book describes the variables, the data, and work done to clean up the Human Activity Recognition Via Smartphones 
Dataset.

THE DATA

The data contains several files that hold the results about the experiments carried out with a group of 30 volunteers 
within an age bracket of 19-48 years. For the experiment, each volunteer performed six activities (WALKING, WALKING UPSTAIRS,
WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) while wearing a Samsung Galaxy S II on the waist. With the smartphone's
embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The data from the volunteers were randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data, and 30% the test data. 

The data results collected for each volunteer are sensor signals (accelerometer and gyroscope).  For each observation window of a volunteer, a vector of features was obtained by calculating variables from the time and frequency domain. Therefore, the readings collected for each volunteer were:
- tBodyAcc-XYZ  	
- tGravityAcc-XYZ	
- tBodyAccJerk-XYZ	
- tBodyGyro-XYZ		
- tBodyGyroJerk-XYZ	
- tBodyAccMag	
- tGravityAccMag	
- tBodyAccJerkMag	
- tBodyGyroMag		
- tBodyGyroJerkMag	
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ		
- fBodyAccMag		
- fBodyAccJerkMag		
- fBodyGyroMag	
- fBodyGyroJerkMag

FILES USED TO CREATE NECESSARY DATASETS

- 'features.txt': List of all collected data variables for each participant.
- 'features_info.txt': Description of the collected data variables for each participant.
- 'activity_labels.txt': Descriptions of the activity codes.
- 'train/X_train.txt': Data from the participants categorized as "Training".
- 'train/y_train.txt': Activity codes used to connect to data in the Xtrain.txt file.
- 'train/subject_train.txt': Each row identifies the volunteer who performed the activity for each window sample.
- 'train/X_test.txt': Data from the participants categorized as "Test".
- 'test/y_test.txt': Activity codes used to connect to data in the Xtest.txt file.
- 'train/subject_test.txt': Each row identifies the volunteer who performed the activity for each window sample. 

VARIABLES USED IN SCRIPT TO MANIPULATE AND STRUCTURE THE DATA FROM THE DATASET

- ReadXTest: Reads the data from X_test.txt into a table
- ReadXTrain: Reads the data from X_train.txt into a table
- ColNames: Reads the column names for each of the participants data readings
- ColLabels: Secondary variable to help read the column names for each of the participants data readings
- Testnames: Reads the activity codes for the test participants into a table
- Trainnames: Reads the activity codes for the test participants into a table
- TestwActivities: Secondary data frame variable that holds the labels Test participant data
- TrainwActivities: Secondary data frame variable that holds the labels Training participant data
- ReadSubjectTrain: Reads in the Training participant labels for each of the activities associated with a participant
- ReadSubjectTest: Reads in the Test participant labels for each of the activities associated with a participant
- SubjectNamesTest: Secondary variable to associate Test participant labels to data
- SubjectNamesTrain: Secondary variable to associate Training participant labels to data
- TestwActSubj: Secondary data frame variable to connect Test participants with their data observations or readings
- TrainwActSubj: Secondary data frame variable to connect Training participants with their data observations or readings
- Activity_Labels: Reads in the names associated with the activity codes in order to associate these names with activities
- MergedTestComplete: Complete, properly labeled Test participant data
- MergedTrainComplete: Complete, properly labeled Training participant data
- FinalDataSet: Merged data set containing Test and Training data sets, together
- GetMeanStd: Holds the names of the columns that have mean or standard deviation data
- MeanStdDataSet: The data frame containing only the means or standard deviation columns of participant data
- TotalNoDupeSubjNames: Secondary vector variable to identify the readings for each participant and average them
- FinalAvg: The data frame containing only the averages of each column of from MeanStdDataSet for each participant

TRANSFORMATIONS DONE TO DATA TO CREATE A TIDY DATASET

Other than marrying the various files into singular data frames in order to create the final data sets, the only truly 
corrective transformation applied in this process was to correct errors in labeling on some of the Frequency data entries.
So an additional step was taken to correct it.
