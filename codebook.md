---
title: "Codebook for Gettting and Clean Data Project"
author: "Michael G Harpole"
date: "2023-01-25"
output:
  html_document:
    keep_md: yes
editor_options: 
  markdown: 
    wrap: 72
---

## Project Description

This project was to take data from "Human Activity Recognition Using
Smartphones Dataset Version 1.0" and combine the test and training data
sets. The data was then filtered to only have the mean and standard
deviation of each variable. Finally the data was grouped by subject &
activity and the mean of each variable was generated.

## Study design and data processing

Taken from the readme file associated with the data.

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data. 

The sensor signals (accelerometer
and gyroscope) were pre-processed by applying noise filters and then
sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128
readings/window).

The sensor acceleration signal, which has gravitational and body motion
components, was separated using a Butterworth low-pass filter into body
acceleration and gravity. The gravitational force is assumed to have
only low frequency components, therefore a filter with 0.3 Hz cutoff
frequency was used. From each window, a vector of features was obtained
by calculating variables from the time and frequency domain. See
'features_info.txt' for more details.

## Creating the tidy data file

1.   The training and the test sets where merged to create one data set.
2.  The measurements on the mean and standard deviation for each
    measurement where selected from the data set.
3.  The numerical representation of activities was converted to words to
    enable easier readablity
4.  The variable names were added to the dataset.
5.  The data was grouped by subject and activity.

### Cleaning of the data Short overview

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

## Description of the variables in the tiny_data.txt file General description of the file including: - Dimensions of the dataset - Summary of the data - Variables present in the dataset

(you can easily use Rcode for this, just load the dataset and provide
the information directly form the tidy data file)

###Variable 1 (repeat this section for all variables in the dataset)
Short description of what the variable describes.

Some information on the variable including: - Class of the variable -
Unique values/levels of the variable - Unit of measurement (if no unit
of measurement list this as well) - In case names follow some schema,
describe how entries were constructed (for example time-body-gyroscope-z
has 4 levels of descriptors. Describe these 4 levels).

(you can easily use Rcode for this, just load the dataset and provide
the information directly form the tidy data file)

####Notes on variable 1: If available, some additional notes on the
variable not covered elsewehere. If no notes are present leave this
section out.

##Sources Sources you used if any, otherise leave out.

##Annex If you used any code in the codebook that had the echo=FALSE
attribute post this here (make sure you set the results parameter to
'hide' as you do not want the results to show again)
