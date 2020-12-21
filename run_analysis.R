# 1 Merges the training and the test sets to create one data set.
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
X_total <- rbind(X_train, X_test)
y_total <- rbind(y_train, y_test)

# 2 Extracts only the measurements on the mean and standard deviation for each
#   measurement.
X_total_mean <- apply(X_total, 2, mean)
X_total_sd <- apply(X_total, 2, sd)

# 3 Uses descriptive activity names to name the activities in the data set.
activities <- c(
    "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS",
    "SITTING", "STANDING", "LAYING"
)
names(activities) <- c(1:6)
y_total$descriptive <- activities[y_total$V1]

# 4 Appropriately labels the data set with descriptive varibale names.
labels <- read.table("features.txt")[, 2]
colnames(X_total) <- labels

# 5 From the data set in step 4, creates a second, independent tidy data set
#   with the average variables for each activity and each subject.
Xy_total <- cbind(y_total, X_total)
colnames(Xy_total)[1] <- "activity"
Xy_total_average <- aggregate(
    Xy_total[, 2:ncol(Xy_total)],
    by = list(Xy_total$activity),
    FUN = mean,
    na.rm = TRUE
)
# The tidy data set with the average variabels for each activity
# and the first six subjects.
write.csv(Xy_total_average, "tidy_data.csv")
library((xlsx))
write.xlsx(Xy_total_average, "tidy_data.xlsx", col.names = TRUE)