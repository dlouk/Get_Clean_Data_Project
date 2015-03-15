# Get_Clean_Data_Project
Repository for the project of Coursera's online course "Getting and Cleaning 
Data".

## Available files

### run_analysis.R
R script which performs the tasks of the project's description. These tasks are:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each 
measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.

Steps 1-4 correspond to lines 1-69 of the script.
Step 5 corresponds to lines 72-80 of the script.

### tidy_sensor_data_avg.txt
Text file which contains the tidy dataset created in step 5 of the project's 
tasks.

### CodeBook.md
Markdown file which describes the variables, the data, and any transformations 
or work that has been performed to clean up the original data.