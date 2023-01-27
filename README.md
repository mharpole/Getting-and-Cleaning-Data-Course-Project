# Getting-and-Cleaning-Data-Course-Project

Course project: This project was to take data from ["Human Activity Recognition Using Smartphones Dataset Version 1.0"](<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>) and combine the test and training data sets. The data was then filtered to only have the mean and standard deviation of each variable. Finally the data was grouped by subject & activity and the mean of each variable was generated.

## Files in Repo
- [UCI HAR Dataset](https://github.com/mharpole/Getting-and-Cleaning-Data-Course-Project/tree/main/UCI%20HAR%20Dataset)- directory with the orginal data downloaded from ["Human Activity Recognition Using Smartphones Dataset Version 1.0"](<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>) 
- [run_analysis.R](https://github.com/mharpole/Getting-and-Cleaning-Data-Course-Project/blob/main/run_analysis.R)-This is the orgnial script authored to perform the requested tasks.
- [run_analysis.RMD](https://github.com/mharpole/Getting-and-Cleaning-Data-Course-Project/blob/main/run_analysis.Rmd)-A R markdown version of the original script with more description utilized to generate a github document to be used as an in depth codebook.
- [Run_analysis.md](https://github.com/mharpole/Getting-and-Cleaning-Data-Course-Project/blob/main/run_analysis.md)-Github document knitted from the run_analysis.RMD which shows an in-depth overview of the code and data generated from the run_analysis.

## Raw Data Description. 
#### *The following description of the raw data was taken from the Dataset readme file, [Readme.txt](https://github.com/mharpole/Getting-and-Cleaning-Data-Course-Project/blob/main/UCI%20HAR%20Dataset/README.txt)*

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details.

For each record it is provided:

-   Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

-   Triaxial Angular velocity from the gyroscope.

-   A 561-feature vector with time and frequency domain variables.

-   Its activity label.

-   An identifier of the subject who carried out the experiment. The dataset includes the following files: =========================================

-   'README.txt'

-   'features_info.txt': Shows information about the variables used on the feature vector.

-   'features.txt': List of all features.

-   'activity_labels.txt': Links the class labels with their activity name.

-   'train/X_train.txt': Training set.

-   'train/y_train.txt': Training labels.

-   'test/X_test.txt': Test set.

-   'test/y_test.txt': Test labels.

## Creating the tidy data file

1.  The training and the test sets where merged to create one data set.
2.  The measurements on the mean and standard deviation for each
    measurement where selected from the data set.
3.  The numerical representation of activities was converted to words to
    enable easier readablity
4.  The variable names were added to the dataset.
5.  The data was grouped by subject and activity.

## Cleaning of the Data, High Level Overview

First the variable names where taken from the file features.txt and
using regular expression cleaned up into a more readable form. The
training an test datasets where processed in the same manner. The
subject id was take from the file prefixed with subject ( ie.
subject_test.txt), the activity numerical identifier was taken from the
file prefixed with y (ie. y_test.txt), and the accelerometer signals
were taken from the file prefixed with X(ie. x_test.txt). The three
parts of each the test and training data sets were combined, the
variables names for the signals were assigned from the previous cleaned
up features data, and then only the standard deviation and mean
variables where selected. The activity word descritiions where taken
from the file activity_labels.txt. Then the data sets were combined and
the activity numerical representations were mutated to the descritiops
mentioned before. Finally the combined data was grouped by subject id
and activity and the mean of each variable was taken createing the final
tidy data set.
Please refer to the [Codebook](https://github.com/mharpole/Getting-and-Cleaning-Data-Course-Project/blob/main/run_analysis.md) for an indepth look at the code and data synthesized.



