Basic operations steps of the Run_Analysis.R script
===================================================
 
1. read the X_train data set into a data frame named as train.df
2. assign each column names based on features file
3. add subject_train as a column and name it as "subjectid" 
4. add y_train as a column and name it as "activityid"
5. read the X_test data set into a data frame named as test.df
6. assign each column names based on features file
7. add subject_test as a column and name it as "subjectid" 
8. add y_test as a column and name it as "activityid"
9. merge the two data frames, train.df and test.df
10. extract the measurements on the mean and standard deviation for each measurement, that
    can be done based on the column names and grepping substrings: "mean", "std". At this
    step the first tidy data set is ready.
11. the second tidy data set is obtained by the first one applying mean on subsets determined
    by {subject, activity}.