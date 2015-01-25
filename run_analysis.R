### Loads plyr & dplyr (and installs them if necessary)
suppressWarnings(
      if (!require(plyr)) {
      install.packages("plyr")
      library(plyr)
} else {
      library(plyr)
}
)
suppressWarnings(
      if (!require(dplyr)) {
      install.packages("dplyr")
      library(dplyr)
} else {
      library(dplyr)
}
)
### Reads required files
test_data <- read.table("./test/X_test.txt")
training_data <- read.table("./train/X_train.txt")
test_labels <- read.table("./test/y_test.txt")
training_labels  <- read.table("./train/y_train.txt")
test_subjects <- read.table("./test/subject_test.txt")
training_subjects <- read.table("./train/subject_train.txt")
features <- read.table("./features.txt")
labels_readable <- read.table("./activity_labels.txt")
### Adds descriptive column name to subject and activity vectors
colnames(test_subjects) <- "subject"
colnames(training_subjects) <- "subject"
colnames(test_labels) <- "activity"
colnames(training_labels) <- "activity"
### Adds column with subject number and activity number to each dataframe
test_data <- cbind(test_labels, test_subjects, test_data)
training_data <- cbind(training_labels, training_subjects, training_data)
### Adds status to *_data dataframes
test_data <- mutate(test_data, status = "test")
training_data <- mutate(training_data, status = "training")
### Merges two datasets
data <- rbind(training_data, test_data)
data$status <- as.factor(data$status)
### Re-orders the dataframe: subject, status and activity go first
data <- select(data, subject, status, activity, V1:V561)
### Gives explicit activity names
data$activity <- as.factor(data$activity)
data$activity <-revalue(data$activity, 
                         c("1" = "WALKING", "2"="WALKING UPSTAIRS",
                           "3" ="WALKING DOWNSTAIRS", "4" = "SITTING", 
                           "5" = "STANDING", "6" = "LAYING"))
### Gives explicit variable names (column names)
colnames(data)[4:564] <- as.character(features$V2)
### Selects only mean and standard deviation values
data <- data[, grepl("mean|std|activity|status|subject", colnames(data))]
### Converts data to tbl dataframe, which is compatible with dplyr
data <- tbl_df(data)
### Groups data by subject, status (i.e. training or test) and activity
grouped <- group_by(data, subject, status, activity)
### Calculates means of each measurement for each subject and activity
means_data <-summarise_each(grouped, funs(mean))