Basic operations steps of the Run_Analysis.R script
===================================================
 
1. download raw data set based on its URL specification and store it in /data subdirectory
2. load the activity labels file into the activity_labels.df data frame
3. load the features name file into the features.df data frame
4. load the subject_train file into the subject_train.df data frame
5. load the X_train.txt file into the X_train.df data frame while assigning the features name as column names
6. load the X_train.txt file into the X_train.df data frame
7. load the subject_test.txt file into the subject_test data frame
8. load the X_test.txt file into the X_test data frame
9. load the Y_test.txt file into the Y_test data frame
10. changing activity identifier into their literal name associated to, for both training and testing data set
11. column binding the activity, subject and measurements columns all together for both train and test data to create two new data frames, All_train.df and All_test.df
12. row binding the All_train.df and All_test.df data frame
13. preparing regular expression based on "mean" and "std" keywords to grep for
14. determining what are the column names containing the "mean" or "std" substring to build a logical vector to select those columns from the All_df data frame
15. including subject and activity identifiers (first two columns) in the logical vector
16. determing the second tidy data set by aggregation of mean values aggregated by (subjectid, activityid)
17. renaming column names by prepending "avg" to coputed average columns
18. storing results into the tidydata.txt file
19. reading back the produced tidydata.txt file to verify it is all ok