library(plyr)
library(dplyr)

# File locations
course_path <- "C:/Users/Louk/Desktop/Getting_Cleaning_Data/"
dataset_path <- paste(course_path, 
                      "Get_Clean_Data_Project/UCI_HAR_Dataset/",
                      sep="")
train_path <- paste(dataset_path, "train/", sep="")
test_path <- paste(dataset_path, "test/", sep="")

# Load test datasets
x_test <- read.table(paste(test_path, "X_test.txt", sep=""))
y_test <- read.table(paste(test_path, "y_test.txt", sep=""))
s_test <- read.table(paste(test_path, "subject_test.txt", sep=""))
# Load training datasets
x_train <- read.table(paste(train_path, "X_train.txt", sep=""))
y_train <- read.table(paste(train_path, "y_train.txt", sep=""))
s_train <- read.table(paste(train_path, "subject_train.txt", sep=""))
# Load features.txt file --> contains descriptive variable names 
features <- read.table(paste(dataset_path, "features.txt", sep=""))
# Load activity_labels.txt file --> links number-labels with activity names
activity_labels <- read.table(paste(dataset_path, "activity_labels.txt", 
                                    sep=""))


# Merge test and training datasets
x_merged <- rbind(x_train, x_test)  # measurements
y_merged <- rbind(y_train, y_test)  # activity labels
s_merged <- rbind(s_train, s_test)  # subjects of experiments

# Sustitute activity *labels* with actual activity *names* in y_merged.
# E.g. 1: WALKING, 2: WALKING UPSTAIRS, etc.
y_merged[, 1] <- activity_labels[y_merged[, 1], 2]

# Place suitable names for each column in the datasets
colnames(x_merged) <- t(features[2])
colnames(y_merged) <- "activity"
colnames(s_merged) <- "subject_ID" 

# Merge all to one dataset --> columns 1-561 : measurements 
#                              column 562    : activity
#                              column 563    : subject IDs
sensor_data_merged <- cbind(x_merged, y_merged, s_merged)
# Fix column names so that no '()' are present
names(sensor_data_merged) <- gsub('[-()]', '', names(sensor_data_merged))

# Get only columns which correspond to mean or sandard deviation 
# values of measurements --> shall receive a vector of integers
wanted_columns <- grep("-(mean|std)\\(\\)", features[, 2])
# Add the last 2 columns which hold the subject IDs and activities
wanted_columns <- c(wanted_columns, 562, 563)

# The following dataset satisfies all criteria set by steps 1-4 
# of the project's description, i.e. :
# 1. it has been created by merging the original datasets (train, test)
# 2. only mean and standard deviation values of measurements are contained
# 3. each column has an appropriate descriptive variable name
# 4. the "activity" column contains actual activity names instead of 
#    activity labels, e.g. "WALKING" instead of "1"
sensor_data_wanted <- sensor_data_merged[, wanted_columns]
# Move last 2 rows as to be the first 2, i.e. the order shall be subject ID, 
# activity, measurements
no_columns <- ncol(sensor_data_wanted)
sensor_data_wanted <- sensor_data_wanted[ ,c(no_columns, no_columns-1, 
                                             1:(no_columns-2))]
# Sort "sensor_data_wanted" dataset by subject_ID in ascending order.
# In case of equal subject_ID, sort by activity, alphabetically.
sensor_data_wanted <- arrange(sensor_data_wanted, subject_ID, activity)


# Use "sensor_data_wanted" dataset to create an independet, tidy dataset
# with the average value of each activity and subject.
sensor_data_wanted_avg <- ddply(sensor_data_wanted_avg, 
                                 c("subject_ID","activity"), 
                                 numcolwise(mean))
# Write the above created dataset in a txt file.
write.table(sensor_data_wanted_avg, 
            file = paste(course_path, "tidy_sensor_data_avg.txt", sep=""),
            row.names=FALSE)
            

