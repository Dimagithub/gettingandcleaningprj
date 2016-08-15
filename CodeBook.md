# Code Book

This document describes `run_analysis.R`.

The code flow is following:

* Download and unzip source data files
* Prepare "lookup" data structures for labels and features
* Load test data
* Load train data
* Combine datasets
* Relabel to meet requirements

## Download and unzip data

Download data from the provided URL as a zip file; use `utils::unzip` to extracts all files at once

### File structure

Files are expected to be located in `UCI HAR Dataset` folder.

Sample folder structure:
"UCI HAR Dataset/activity_labels.txt"                         
"UCI HAR Dataset/features.txt"                                
"UCI HAR Dataset/test/subject_test.txt"                       
"UCI HAR Dataset/test/X_test.txt"                             
"UCI HAR Dataset/test/y_test.txt"                             
"UCI HAR Dataset/train/subject_train.txt"                     
"UCI HAR Dataset/train/X_train.txt"                           
"UCI HAR Dataset/train/y_train.txt"                           

### Loading data
* Load labels into `a_labels_ds data` frame - which is important for future use in join operation
* Load features into a vector `features`
* Load test data from `X` file
* Load label index fata from `y` file
* Load subject numbers from subject file
* Combine Activity and Subject index data with main dataset
* Set the column names of main dataset to values from features vector
* Repeat the same for train data

### Manipulating data
* Re-arrange column names to get them in a sorted order - this is critical step
* Merge test and train datasets
* Remove un-needed columns using grep command applied to column names; `resultColnames` contains final list of columns
* Use `ddply` to break down the merged data frame, apply mean function to std and mean metrics and combined back into a single data frame
* Re-arrange column names to make the data frame more readable; remove `ActivityIndex` column to eliminate the data redundancy to maintain tidy dataset principle
* Final dataset is saved in `resultDataPretty`, sample:
```{r}
    >head(resultDataPretty[,1:4],4)

    ActivityName SubjectIndex fBodyAcc-mean()-X fBodyAcc-mean()-Y
    1      WALKING            1        -0.2027943        0.08971273
    2      WALKING            2        -0.3460482       -0.02190481
    3      WALKING            3        -0.3166140       -0.08130244
    4      WALKING            4        -0.4267194       -0.14939963
```
### Writing final data to table format

* Write results using `write.table` function.
* Event though the file formal is "wide" it's still tidy since it satsifies all pricples of a tidy dataset:
    + All the variables in different columns
    + There no duplicate columns
* You can read the file using this command: `read.table("result.tab", header=TRUE)`
