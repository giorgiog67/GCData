# 1. download raw data set based on its URL specification and store it in /data subdirectory
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("data")) {
  dir.create("data")
}
download.file(url, destfile="./data/rawdata.zip", method="auto")
# check the data file is there as expected 
stopifnot("rawdata.zip" %in% list.files("./data"))
# 2. load the activity labels file into the activity_labels.df data frame
activity_labels.conn <- unz("./data/rawdata.zip", filename = c("UCI HAR Dataset/activity_labels.txt"))
activity_labels.df <- read.table(activity_labels.conn, row.names=NULL, col.names = c("activityid","activitylabels"))
# 3. load the features name file into the features.df data frame
features.conn <- unz("./data/rawdata.zip", filename = c("UCI HAR Dataset/features.txt"))
features.df <- read.table(features.conn, row.names=NULL,  col.names = c("featuresid","featuresname"))
# 4. load the subject_train file into the subject_train.df data frame
subject_train.conn <- unz("./data/rawdata.zip", filename = c("UCI HAR Dataset/train/subject_train.txt"))
subject_train.df <- read.table(subject_train.conn, row.names=NULL, col.names = c("subjectid"))
# 5. load the X_train.txt file into the X_train.df data frame while assigning the features name as column names
X_train.conn <- unz("./data/rawdata.zip", filename = c("UCI HAR Dataset/train/X_train.txt"))
subjects <- features.df$featuresname
X_train.df <- read.table(X_train.conn, row.names = NULL, col.names = subjects)
# 6. load the X_train.txt file into the X_train.df data frame
Y_train.conn <- unz("./data/rawdata.zip", filename = c("UCI HAR Dataset/train/y_train.txt"))
Y_train.df <- read.table(Y_train.conn, row.names=NULL, col.names = c("activityid"))
# 7. load the subject_test.txt file into the subject_test data frame
subject_test.conn <- unz("./data/rawdata.zip", filename = c("UCI HAR Dataset/test/subject_test.txt"))
subject_test.df <- read.table(subject_test.conn, row.names=NULL, col.names = c("subjectid"))
# 8. load the X_test.txt file into the X_test data frame
X_test.conn <- unz("./data/rawdata.zip", filename = c("UCI HAR Dataset/test/X_test.txt"))
X_test.df <- read.table(X_test.conn, row.names = NULL, col.names = subjects)
# 9. load the Y_test.txt file into the Y_test data frame
Y_test.conn <- unz("./data/rawdata.zip", filename = c("UCI HAR Dataset/test/y_test.txt"))
Y_test.df <- read.table(Y_test.conn, row.names=NULL, col.names = c("activityid"))
# closing all file connections
closeAllConnections()
# 10. changing activity identifier into their literal name associated to,
#     for both training and testing data set
x <- list()
x <- c(x, sapply(Y_train.df, function(x) {activity_labels.df[x,2]}))
v <- unlist(x)
Y_train2.df <- as.data.frame(v)
colnames(Y_train2.df) <- c("activityid")
x <- list()
x <- c(x, sapply(Y_test.df, function(x) {activity_labels.df[x,2]}))
v <- unlist(x)
Y_test2.df <- as.data.frame(v)
colnames(Y_test2.df) <- c("activityid")
# 11. column binding the activity, subject and measurements columns all together for both train 
#     and test data to create two new data frames, All_train.df and All_test.df
All_train.df <- cbind(subject_train.df, Y_train2.df, X_train.df)
All_test.df <- cbind(subject_test.df, Y_test2.df, X_test.df)
# 12. row binding the All_train.df and All_test.df data frame
All.df <- rbind(All_train.df, All_test.df)
# 13. preparing regular expression based on "mean" and "std" keywords to grep for
all.col <- colnames(All.df)
chars <- "mean|std"
# 14. determining what are the column names containing the "mean" or "std" substring to build a 
#     logical vector to select those columns from the All_df data frame
v <- sapply(all.col, function(x){grepl(chars, x)})
# 15. including subject and activity identifiers (first two columns) in the logical vector
v[1] <- TRUE; v[2] <- TRUE;
p <- which(v==TRUE)
names(p) = NULL
All.df.filtered <- All.df[,p]
colnames(All.df.filtered)
# 16. producing the second tidy data set by aggregation of mean values aggregated
#     by (subjectid, activityid)
attach(All.df.filtered)
subjectid <- factor(subjectid)
activityid <- factor(activityid)
n <- ncol(All.df.filtered)
aggregate.df <- aggregate(All.df.filtered[(3:n)], by=All.df.filtered[c("subjectid","activityid")], FUN=mean)
# 17. renaming column names by prepending "avg" to coputed average columns
oldcolnames <- colnames(aggregate.df[,3:n])
newcolnames <- sapply(oldcolnames, function(x){paste("avg", x, sep="")})
newcolnames <- c("subjectId", "activityid", newcolnames)
colnames(aggregate.df) <- newcolnames
# 18. storing results into the tidydata.txt file
write.table(aggregate.df, file = "tidydata.txt", row.names = FALSE)
# 19. reading back the produced tidydata.txt file to verify it is all ok
test.df <- read.table(file = "tidydata.txt", header = TRUE)
head(test.df, 40)
################################################à

