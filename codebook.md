Run Analysis Codebook
================
Michael G Harpole
2023-01-26

## Grab feature names to label columns in the dataset

The feature names, variables in the x prefixed datasets, where parsed
from the file features.txt. Then utilizing regular expressions the
variable names were cleaned up to

``` r
featureNamesData <-
  read_table("UCI HAR Dataset/features.txt", col_names = c("Index", "Feature"))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   Index = col_double(),
    ##   Feature = col_character()
    ## )

``` r
featureNames <- as.list(featureNamesData$Feature) %>%
  unlist() %>%
  str_replace_all("[//(//),]", " ") %>%
  str_replace_all(" t", " time ") %>%
  str_replace_all("^t", "time") %>%
  str_replace("(?<!\\s)-", " ") %>%
  str_replace_all("^f", "Frequency") %>%
  str_replace_all("Acc", "Acceleration") %>%
  trimws()
rm(featureNamesData)
```

## Import Test data

First I extracted all of the filenames with a .txt extension from the
test dataset directory and store it to a list. Utilizing the list I read
in the file using read table. For the subject, subject_test_data, and
the activity, y_TestSet, data I manually assigned a column name. For the
signal data, x_TestSet, I pulled in the variable names from the
featureNames charcter vector created in the first chunk. Additionaly I
selected only the mean and standard deviation from the signal data.
Finally I combined them using the bind_cols function.

``` r
testfileList <-
  list.files("./UCI HAR Dataset/test/",
             full.names = TRUE,
             pattern = "*.txt")
testfileList # subject_test.txt is 1, X_test.txt is 2 and Y_test.txt is 3
```

    ## [1] "./UCI HAR Dataset/test//subject_test.txt"
    ## [2] "./UCI HAR Dataset/test//X_test.txt"      
    ## [3] "./UCI HAR Dataset/test//y_test.txt"

``` r
subject_test_data <-
  read_table(testfileList[1], col_names = ("Subject ID"))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   `Subject ID` = col_double()
    ## )

``` r
x_TestSet <- read_table(testfileList[2], col_names = FALSE)
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   .default = col_double()
    ## )
    ## ℹ Use `spec()` for the full column specifications.

``` r
colnames(x_TestSet) <- featureNames

x_TestSet_selected <- x_TestSet %>%
  select(contains("mean") | contains("std"))

y_TestSet <- read_table(testfileList[3], col_names = ("Activity"))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   Activity = col_double()
    ## )

``` r
testData <-
  bind_cols(subject_test_data, y_TestSet, x_TestSet_selected)
testData
```

    ## # A tibble: 2,947 × 88
    ##    `Subject ID` Activity timeB…¹ timeB…² timeB…³ timeG…⁴ timeG…⁵ timeG…⁶ timeB…⁷
    ##           <dbl>    <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1            2        5   0.257 -0.0233 -0.0147   0.936  -0.283   0.115  0.0720
    ##  2            2        5   0.286 -0.0132 -0.119    0.927  -0.289   0.153  0.0702
    ##  3            2        5   0.275 -0.0261 -0.118    0.930  -0.288   0.146  0.0694
    ##  4            2        5   0.270 -0.0326 -0.118    0.929  -0.293   0.143  0.0749
    ##  5            2        5   0.275 -0.0278 -0.130    0.927  -0.303   0.138  0.0784
    ##  6            2        5   0.279 -0.0186 -0.114    0.926  -0.309   0.131  0.0760
    ##  7            2        5   0.280 -0.0183 -0.104    0.926  -0.310   0.129  0.0741
    ##  8            2        5   0.275 -0.0250 -0.117    0.927  -0.311   0.130  0.0762
    ##  9            2        5   0.273 -0.0210 -0.114    0.926  -0.316   0.126  0.0792
    ## 10            2        5   0.276 -0.0104 -0.0998   0.924  -0.318   0.125  0.0771
    ## # … with 2,937 more rows, 79 more variables:
    ## #   `timeBodyAccelerationJerk mean  -Y` <dbl>,
    ## #   `timeBodyAccelerationJerk mean  -Z` <dbl>, `timeBodyGyro mean  -X` <dbl>,
    ## #   `timeBodyGyro mean  -Y` <dbl>, `timeBodyGyro mean  -Z` <dbl>,
    ## #   `timeBodyGyroJerk mean  -X` <dbl>, `timeBodyGyroJerk mean  -Y` <dbl>,
    ## #   `timeBodyGyroJerk mean  -Z` <dbl>, `timeBodyAccelerationMag mean` <dbl>,
    ## #   `timeGravityAccelerationMag mean` <dbl>, …

``` r
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
```

## Import Training Data

The training data was processed identically as the test data with the
exception of different object names.

``` r
traningFileList <-
  list.files("./UCI HAR Dataset/train/",
             full.names = TRUE,
             pattern = "*.txt")
traningFileList # Data files are in the same order
```

    ## [1] "./UCI HAR Dataset/train//subject_train.txt"
    ## [2] "./UCI HAR Dataset/train//X_train.txt"      
    ## [3] "./UCI HAR Dataset/train//y_train.txt"

``` r
subject_train_data <-
  read_table(traningFileList[1], col_names = c("Subject ID"))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   `Subject ID` = col_double()
    ## )

``` r
x_TrainSet <- read_table(traningFileList[2], col_names = FALSE)
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   .default = col_double()
    ## )
    ## ℹ Use `spec()` for the full column specifications.

``` r
colnames(x_TrainSet) <- featureNames

x_TrainSet_selected <- x_TrainSet %>%
  select(contains("mean") | contains("std"))

y_TrainSet <-
  read_table(traningFileList[3], col_names = c("Activity"))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   Activity = col_double()
    ## )

``` r
trainData <-
  bind_cols(subject_train_data, y_TrainSet, x_TrainSet_selected)
trainData
```

    ## # A tibble: 7,352 × 88
    ##    `Subject ID` Activ…¹ timeB…² timeBo…³ timeB…⁴ timeG…⁵ timeG…⁶ timeG…⁷ timeB…⁸
    ##           <dbl>   <dbl>   <dbl>    <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1            1       5   0.289 -0.0203   -0.133   0.963  -0.141  0.115   0.0780
    ##  2            1       5   0.278 -0.0164   -0.124   0.967  -0.142  0.109   0.0740
    ##  3            1       5   0.280 -0.0195   -0.113   0.967  -0.142  0.102   0.0736
    ##  4            1       5   0.279 -0.0262   -0.123   0.968  -0.144  0.0999  0.0773
    ##  5            1       5   0.277 -0.0166   -0.115   0.968  -0.149  0.0945  0.0734
    ##  6            1       5   0.277 -0.0101   -0.105   0.968  -0.148  0.0919  0.0779
    ##  7            1       5   0.279 -0.0196   -0.110   0.968  -0.144  0.0931  0.0822
    ##  8            1       5   0.277 -0.0305   -0.125   0.968  -0.147  0.0917  0.0724
    ##  9            1       5   0.277 -0.0218   -0.121   0.968  -0.154  0.0851  0.0753
    ## 10            1       5   0.281 -0.00996  -0.106   0.968  -0.156  0.0809  0.0764
    ## # … with 7,342 more rows, 79 more variables:
    ## #   `timeBodyAccelerationJerk mean  -Y` <dbl>,
    ## #   `timeBodyAccelerationJerk mean  -Z` <dbl>, `timeBodyGyro mean  -X` <dbl>,
    ## #   `timeBodyGyro mean  -Y` <dbl>, `timeBodyGyro mean  -Z` <dbl>,
    ## #   `timeBodyGyroJerk mean  -X` <dbl>, `timeBodyGyroJerk mean  -Y` <dbl>,
    ## #   `timeBodyGyroJerk mean  -Z` <dbl>, `timeBodyAccelerationMag mean` <dbl>,
    ## #   `timeGravityAccelerationMag mean` <dbl>, …

``` r
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
```

## Combine data and label activities with descriptions

``` r
activityLabels <-
  read_table("UCI HAR Dataset/activity_labels.txt",
             col_names = c("Index", "Activity"))
```

    ## 
    ## ── Column specification ────────────────────────────────────────────────────────
    ## cols(
    ##   Index = col_double(),
    ##   Activity = col_character()
    ## )

``` r
activityLabels
```

    ## # A tibble: 6 × 2
    ##   Index Activity          
    ##   <dbl> <chr>             
    ## 1     1 WALKING           
    ## 2     2 WALKING_UPSTAIRS  
    ## 3     3 WALKING_DOWNSTAIRS
    ## 4     4 SITTING           
    ## 5     5 STANDING          
    ## 6     6 LAYING

``` r
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
```

    ## # A tibble: 10,299 × 88
    ##    `Subject ID` Activity timeB…¹ timeB…² timeB…³ timeG…⁴ timeG…⁵ timeG…⁶ timeB…⁷
    ##           <dbl> <chr>      <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>   <dbl>
    ##  1            2 Standing   0.257 -0.0233 -0.0147   0.936  -0.283   0.115  0.0720
    ##  2            2 Standing   0.286 -0.0132 -0.119    0.927  -0.289   0.153  0.0702
    ##  3            2 Standing   0.275 -0.0261 -0.118    0.930  -0.288   0.146  0.0694
    ##  4            2 Standing   0.270 -0.0326 -0.118    0.929  -0.293   0.143  0.0749
    ##  5            2 Standing   0.275 -0.0278 -0.130    0.927  -0.303   0.138  0.0784
    ##  6            2 Standing   0.279 -0.0186 -0.114    0.926  -0.309   0.131  0.0760
    ##  7            2 Standing   0.280 -0.0183 -0.104    0.926  -0.310   0.129  0.0741
    ##  8            2 Standing   0.275 -0.0250 -0.117    0.927  -0.311   0.130  0.0762
    ##  9            2 Standing   0.273 -0.0210 -0.114    0.926  -0.316   0.126  0.0792
    ## 10            2 Standing   0.276 -0.0104 -0.0998   0.924  -0.318   0.125  0.0771
    ## # … with 10,289 more rows, 79 more variables:
    ## #   `timeBodyAccelerationJerk mean  -Y` <dbl>,
    ## #   `timeBodyAccelerationJerk mean  -Z` <dbl>, `timeBodyGyro mean  -X` <dbl>,
    ## #   `timeBodyGyro mean  -Y` <dbl>, `timeBodyGyro mean  -Z` <dbl>,
    ## #   `timeBodyGyroJerk mean  -X` <dbl>, `timeBodyGyroJerk mean  -Y` <dbl>,
    ## #   `timeBodyGyroJerk mean  -Z` <dbl>, `timeBodyAccelerationMag mean` <dbl>,
    ## #   `timeGravityAccelerationMag mean` <dbl>, …

``` r
# clean up workspace
rm("activityLabels")
```

## Generate means by subject and activity

``` r
meanCombinedData <- combinedData %>%
  group_by(`Subject ID`, Activity) %>%
  summarise_all(mean)
meanCombinedData %>% write_csv("230125_meanCombinedData.csv")
# clean up workspace
rm(list = c("testData", "trainData"))
```

## Session Information

    ## R version 4.2.2 (2022-10-31)
    ## Platform: aarch64-apple-darwin20 (64-bit)
    ## Running under: macOS Ventura 13.1
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/lib/libRblas.0.dylib
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/lib/libRlapack.dylib
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] forcats_0.5.2   stringr_1.5.0   dplyr_1.0.10    purrr_1.0.1    
    ## [5] readr_2.1.3     tidyr_1.2.1     tibble_3.1.8    ggplot2_3.4.0  
    ## [9] tidyverse_1.3.2
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] tidyselect_1.2.0    xfun_0.36           haven_2.5.1        
    ##  [4] gargle_1.2.1        colorspace_2.0-3    vctrs_0.5.1        
    ##  [7] generics_0.1.3      htmltools_0.5.4     yaml_2.3.6         
    ## [10] utf8_1.2.2          rlang_1.0.6         pillar_1.8.1       
    ## [13] withr_2.5.0         glue_1.6.2          DBI_1.1.3          
    ## [16] bit64_4.0.5         dbplyr_2.3.0        modelr_0.1.10      
    ## [19] readxl_1.4.1        lifecycle_1.0.3     munsell_0.5.0      
    ## [22] gtable_0.3.1        cellranger_1.1.0    rvest_1.0.3        
    ## [25] evaluate_0.20       knitr_1.41          tzdb_0.3.0         
    ## [28] fastmap_1.1.0       parallel_4.2.2      fansi_1.0.3        
    ## [31] broom_1.0.2         scales_1.2.1        backports_1.4.1    
    ## [34] googlesheets4_1.0.1 vroom_1.6.0         jsonlite_1.8.4     
    ## [37] bit_4.0.5           fs_1.5.2            hms_1.1.2          
    ## [40] digest_0.6.31       stringi_1.7.12      grid_4.2.2         
    ## [43] cli_3.6.0           tools_4.2.2         magrittr_2.0.3     
    ## [46] crayon_1.5.2        pkgconfig_2.0.3     ellipsis_0.3.2     
    ## [49] xml2_1.3.3          reprex_2.0.2        googledrive_2.0.0  
    ## [52] lubridate_1.9.0     timechange_0.2.0    assertthat_0.2.1   
    ## [55] rmarkdown_2.20      httr_1.4.4          rstudioapi_0.14    
    ## [58] R6_2.5.1            compiler_4.2.2
