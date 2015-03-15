# Original Data
The data used for this project  represent data collected from the 
accelerometers of the Samsung Galaxy S smartphone. A full description is 
available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data were downloaded from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The project data are experiment data regarding a group of 30 volunteers within 
an age bracket of 19-48 years. Each person performed six activities (WALKING, 
WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a 
smartphone (Samsung Galaxy S II) on the waist. The obtained dataset has been 
randomly partitioned into two sets, where 70% of the volunteers was selected 
for generating the training data and 30% the test data. 

The files used in this project are:
* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels. 

* 'train/subject_train.txt', 'test/subject_test.txt': Each file corresponds to 
the respective dataset, i.e. test or training. Each row identifies the subject 
who performed the activity for each window sample. Their range is from 1 to 30.

# Data manipulation with run_analysis.R
## 1. Load Data
The content of the files presented above are loaded to respective 
variables. Those variables, along with the files they load, are:
* x_test, x_train: 'X_test.txt', 'X_train.txt', respectively 
* y_test, y_train: 'y_test.txt', y_train.txt', respectively
* s_test, s_train: 'subject_test.txt', 'subject_train.txt', respectively
* features: 'features.txt'
* activity_labels: 'activity_labels.txt'
	
## 2. Merge Data
* Each test/train dataset is merged in one dataset - x, y or s - using the 
'rbind' command of R. The resulting variables are:
	* x_merged: merges x_test, x_train
	* y_merged: merges y_test, y_train
	* s_merged: merges s_test, s_train

* In 'y_merged' the activity labels are replaced with the actual activity 
names, i.e. '1' --> 'WALKING', '2' --> 'WALKING_UPSTAIRS', etc.

* Suitable, descriptive names for each column of the x/y/s datasets are placed.

* 'x/y/s_merged' datasets are merged into one dataset called 
'sensor_data_merged' with R's 'cbind' command. The variable names of 
'sensor_data_merged' are changed so that no parentheses are present in the 
names.

* The columns of interest, i.e. those that refer to mean or standard deviation
values, plus those that contain the subject IDs and activity names are 
identified and their indices place in variable 'wanted_columns'.

* Using the 'wanted_columns' and 'sensor_data_merged' variables, 
'sensor_data_wanted' variable is created, containing only the columns of 
interest.    

## 3. Create an independent, tidy dataset (project's step 5)
* Using plyr library's 'ddply' command, the 'sensor_data_wanted_avg' variable 
is created, which contains an independent, tidy dataset with the average value 
of each activity and subject. 
* The dataset of 'sensor_data_wanted_avg' is written in a txt file named
'tidy_sensor_data_avg.txt'.