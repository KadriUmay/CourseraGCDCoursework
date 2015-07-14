#1.Merges the training and the test sets to create one data set.
#Training Data
if (!grepl("/data$",getwd()))
    {
      setwd(".\\data")
    }
trainData <- read.table("./train/X_train.txt") 
testData <- read.table("./test/X_test.txt") 
joinData <- rbind(trainData, testData) 
#Labels
trainLabel <- read.table("./train/y_train.txt") 
testLabel <- read.table("./test/y_test.txt")  
joinLabel <- rbind(trainLabel, testLabel) 
#Subjects
trainSubject <- read.table("./train/subject_train.txt") 
testSubject <- read.table("./test/subject_test.txt") 
joinSubject <- rbind(trainSubject, testSubject) 

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
features <- read.table("./data/features.txt") 
meanOrstdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2]) #variable have names with mean() or std() in the dataset
joinData <- joinData[, meanOrstdIndices] 
#Beautify column names and update JoinData
names(joinData) <- gsub("\\(\\)", "", features[meanOrstdIndices, 2]) # remove "()" 
names(joinData) <- gsub("mean", "Mean", names(joinData)) # capital M 
names(joinData) <- gsub("std", "Std", names(joinData)) # capital S 
names(joinData) <- gsub("-", "", names(joinData)) # remove "-"  


# 3. Uses descriptive activity names to name the activities in the data set 
activity <- read.table("./activity_labels.txt") 
activity[, 2] <- tolower(gsub("_", "", activity[, 2])) #remove _ in the activity label names
activityLabel <- activity[joinLabel[, 1], 2] 
joinLabel[, 1] <- activityLabel 
names(joinLabel) <- "activity" 

# 4. Appropriately labels the data set with descriptive activity names.  
names(joinSubject) <- "subject" 
cleanedData <- cbind(joinSubject, joinLabel, joinData)
write.table(cleanedData, "mergeddata.txt") # write out the 1st dataset 


#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2] 
result <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)  
result <- as.data.frame(result) 
colnames(result) <- colnames(cleanedData) 
row <- 1 
for(i in 1:subjectLen) { 
     for(j in 1:activityLen) { 
         result[row, 1] <- sort(unique(joinSubject)[, 1])[i] 
         result[row, 2] <- activity[j, 2] 
         bool1 <- i == cleanedData$subject 
         bool2 <- activity[j, 2] == cleanedData$activity 
         result[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen]) 
         row <- row + 1 
     } 
} 
write.table(result, "datawithmeans.txt", row.names = FALSE) # write out the 2nd dataset 

