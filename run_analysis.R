#Load libraries
library(tidyverse)
# Grab feature names to label columns in the dataset ----------------------
featureNamesData <-
  read_table("UCI HAR Dataset/features.txt", col_names = c("Index", "Feature"))
head(featureNamesData)
tail(featureNamesData)
featureNames <- as.list(featureNamesData$Feature) %>%
  unlist() %>%
  str_replace_all("[//(//),]", " ") %>%
  str_replace_all(" t", " time ") %>%
  str_replace_all("^t", "time") %>%
  str_replace("(?<!\\s)-", " ") %>%
  str_replace_all("^f", "Frequency") %>%
  str_replace_all("Acc", "Acceleration") %>%
  trimws()
featureNames
rm(featureNamesData)
# Import Test Data, select only standard deviations and means ------------------
# grab file list to simplify data import
testfileList <-
  list.files("./UCI HAR Dataset/test/",
             full.names = TRUE,
             pattern = "*.txt")
testfileList # subject_test.txt is 1, X_test.txt is 2 and Y_test.txt is 3

subject_test_data <-
  read_table(testfileList[1], col_names = ("Subject ID"))

x_TestSet <- read_table(testfileList[2], col_names = FALSE)
colnames(x_TestSet) <- featureNames

x_TestSet_selected <- x_TestSet %>%
  select(contains("mean") | contains("std"))

y_TestSet <- read_table(testfileList[3], col_names = ("Activity"))

testData <-
  bind_cols(subject_test_data, y_TestSet, x_TestSet_selected)
# View(testData)
# clean up workspace
rm(
  list = c(
    "subject_test_data",
    "x_TestSet",
    "y_TestSet",
    "testfileList",
    "x_TestSet_selected"
  )
)
# Import Training Data, select only standard deviations and means ---------------
traningFileList <-
  list.files("./UCI HAR Dataset/train/",
             full.names = TRUE,
             pattern = "*.txt")
traningFileList # Data files are in the same order

subject_train_data <-
  read_table(traningFileList[1], col_names = c("Subject ID"))

x_TrainSet <- read_table(traningFileList[2], col_names = FALSE)
colnames(x_TrainSet) <- featureNames

x_TrainSet_selected <- x_TrainSet %>%
  select(contains("mean") | contains("std"))

y_TrainSet <-
  read_table(traningFileList[3], col_names = c("Activity"))

trainData <-
  bind_cols(subject_train_data, y_TrainSet, x_TrainSet_selected)
# clean up workspace
rm(
  list = c(
    "subject_train_data",
    "x_TrainSet_selected",
    "y_TrainSet",
    "traningFileList",
    "x_TrainSet",
    "featureNames"
  )
)
# View(trainData)
# Combine data and label activities-----------
activityLabels <-
  read_table("UCI HAR Dataset/activity_labels.txt",
             col_names = c("Index", "Activity"))
activityLabels
combinedData <- bind_rows(testData, trainData) %>%
  mutate(
    Activity =
      case_when(
        Activity == 1 ~ "Walking",
        Activity == 2 ~ "Walking Upstairs",
        Activity == 3 ~ "Walking Downstairs",
        Activity == 4 ~ "Sitting",
        Activity == 5 ~ "Standing",
        Activity == 6 ~ "Laying"
      )
  )
combinedData
# clean up workspace
rm("activityLabels")
# Summarize the mean by subject and activity ------------------------------

meanCombinedData <- combinedData %>%
  group_by(`Subject ID`, Activity) %>%
  summarise_all(mean)
meanCombinedData %>% write_csv("230126_meanCombinedData.csv")
write.table(meanCombinedData,"tidy_data.txt", row.names = FALSE)
# clean up workspace
rm(list = c("testData", "trainData", ))
