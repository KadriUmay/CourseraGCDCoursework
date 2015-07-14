# Code Book
This file describes the attributes, data, and any transformations that I have performed to tidy the data. 

Raw data from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Downloaded data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The RunAnalysis.R script performs the following steps to clean the data:

1.Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in trainData, trainLabel and trainSubject variables respectively.

2.Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in testData, testLabel and testsubject variables respectively.

3.Join testData to trainData to generate joinData data frame; join testLabel to trainLabel to generate joinLabel data frame; join testSubject to trainSubject to generate joinSubject data frame.

4.Read the features.txt file from the "/data" folder and store the data in features variable. Only extract the measurements on the mean and standard deviation. Get a subset of joinData with the 66 columns.

5.Beautify column names. Remove the "()" and "-" symbols in the names, change "mean" and "std" to "Mean" and "Std".

6.Read the activity_labels.txt file from the "./data"" folder and store the data in activity variable.

7.Beautify the activity names in the second column of activity. We first make all names to lower case, remove the underscore and capitalize the letter after the underscore.

8.Transform the values of joinLabel according to the activity data frame.

9.Join the joinSubject, joinLabel and joinData by column to get a new cleaned 10299x68 data frame, cleanedData. Name the first two columns, "subject" and "activity". The "subject" column contains integers that range from 1 to 30 inclusive; the "activity" column contains 6 kinds of activities; the last 66 columns contain measurements that range from -1 to 1 exclusive.

10.Write the cleanedData out to "tidydata.txt" file in current working directory.

11.Generate a second tidy data set with the average of each measurement for each activity and each subject. Then, for each combination, calculate the mean of each measurement. 

12.Write the result out to "tidydatameans.txt" file in current working directory. 

