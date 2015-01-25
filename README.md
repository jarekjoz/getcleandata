### Getting and cleaning data course: assignment

The script included in the file run_analysis.R performs a set of operations to obtain a "clean" dataset required by the assignment.

Below are steps the script takes to obtain the final dataset:

Step 1: As the script relies on the libraries *plyr* and *dplyr*, these libraries are loaded into R

Step 2: Original files supplied with the assignment are loaded: actual measurements data (training data and test data), activity id's, subject id's, variable names and meaningful activity names.

Step 3: The subject id's and activity id's are attached to each dataset (i.e. to the training dataset and to the test dataset)

Step 4: A new variable "status" is created in each of the two datasets. They have the same value for every observation: "test" in the test dataset and "traning" in the training dataset. This step allows us two identify which dataset a given observation comes from, when the two datasets are merged.

Step 5: Datasets are merged

Step 6: The columns (variables) of the dataset are reorded, so that subject, status and activity id's come first.

Step 7: Activity id's (numerical) are replaced with descriptive activity names.

Step 8: Variable (column) id's are replaced with descriptive variable names.

Step 9: Only mean and standard deviation values are selected.

Step 10: In the final step, the script calculates the mean value of every variable selected in Step 9 -- for every subject and every activity (i.e. it calculates 6 values for every subject, because there are 6 activities)


**IMPORTANT:** in order for the script to work, the downloaded files must be placed in the working directory and the **original directory structure must be preserved**

