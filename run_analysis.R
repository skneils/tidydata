# load test data from ./UCI HAR Dataset/test/
testx=read.table("./UCI HAR Dataset/test/x_test.txt")

testy=read.table("./UCI HAR Dataset/test/y_test.txt")

tests=read.table("./UCI HAR Dataset/test/subject_test.txt")

# load train data from ./UCI HAR Dataset/train/
trainx=read.table("./UCI HAR Dataset/train/X_train.txt")

trainy=read.table("./UCI HAR Dataset/train/y_train.txt")

trains=read.table("./UCI HAR Dataset/train/subject_train.txt")

# load features and labels
features=read.table("./UCI HAR Dataset/features.txt")

actlabels=read.table("./UCI HAR Dataset/activity_labels.txt")

# give columns names using features data
colnames(testx) = features[,2]

colnames(trainx) = features[,2]

# remove columns that don't contain mean or std data
# this is done with the following:
# grepl("[a-z]*mean\\(|std\\([a-z]*",features[,2])
# data is considered if it contains "mean(" or "std("
# this excludes "meanFreq()" and the vectors used in "angle()"

testx = subset(testx, select=grepl("[a-z]*mean\\(|std\\([a-z]*",features[,2]))

trainx = subset(trainx, select=grepl("[a-z]*mean\\(|std\\([a-z]*",features[,2]))

# keep track of number of columns
v=ncol(testx)


# replace numbers with activity names and add column to textx
testx$activity = actlabels[testy[,1],2]
rm(testy)

trainx$activity = actlabels[trainy[,1],2]
rm(trainy)

# add subjects to testx
testx$subject = tests[,1]

trainx$subject = trains[,1]

# combine testx and trainx into one dataset

dataset = merge(testx, trainx, all=TRUE)

# remove the old data
rm(testx)
rm(trainx)
rm(features)
rm(actlabels)


# Now create a tidy data set with average of each variable
# for each activity and each subject
library(reshape2)

tidymelt = melt(dataset, id=c("activity","subject"), measure.vars=names(dataset[,1:v]))
tidydata = dcast(tidymelt, variable~activity+subject, mean )

rm(tidymelt)                           