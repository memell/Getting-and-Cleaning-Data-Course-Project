##-----------------------------------------------------------------------------------------------------------------------
##Test data
##-----------------------------------------------------------------------------------------------------------------------
#files
data_X_test_raw=read.table("X_test.txt")
data_X_headers=read.table("features.txt")
data_X_test_activity=read.table("y_test.txt")
data_X_test_subject=read.table("subject_test.txt")
data_activity_labels=read.table("activity_labels.txt")

#headers
data_X_headers<-data_X_headers[,2]
colnames(data_X_test_raw) <- data_X_headers

#selecting columns whose name includes "mean" or "std"
data_X_test<-cbind(data_X_test_raw[,grep("-mean()", colnames(data_X_test_raw), fixed = TRUE)],
                   data_X_test_raw[,grep("-std()", colnames(data_X_test_raw))])

#adding the activity column
data_X_test$activity<-unlist(data_X_test_activity)
#labelling activity
data_X_test$activity<-factor(data_X_test$activity, labels=data_activity_labels$V2)

#adding the subject column
data_X_test$subject<-unlist(data_X_test_subject)



##-----------------------------------------------------------------------------------------------------------------------
##Training data
##-----------------------------------------------------------------------------------------------------------------------
#files
data_X_train_raw=read.table("X_train.txt")
data_X_train_activity=read.table("y_train.txt")
data_X_train_subject=read.table("subject_train.txt")

#headers
colnames(data_X_train_raw) <- data_X_headers

#selecting columns whose name includes "mean" or "std"
data_X_train<-cbind(data_X_train_raw[,grep("-mean()", colnames(data_X_train_raw), fixed = TRUE)],
                   data_X_train_raw[,grep("-std()", colnames(data_X_train_raw))])

#adding the activity column
data_X_train$activity<-unlist(data_X_train_activity)
#labelling activity
data_X_train$activity<-factor(data_X_train$activity, labels=data_activity_labels$V2)

#adding the subject column
data_X_train$subject<-unlist(data_X_train_subject)

##-----------------------------------------------------------------------------------------------------------------------
##Full data set
##-----------------------------------------------------------------------------------------------------------------------
#merging train and test datasets
data_X_merged<-rbind(data_X_train,data_X_test)

#aggregating the merged data 
final_data<-aggregate(data_X_merged[1:66], by=list(subject = data_X_merged$subject, activity = data_X_merged$activity), 
                      FUN=mean, na.rm=TRUE)

#exporting the aggreagted data
write.table(final_data, "~/Documents/Data Science Tools/3 Getting Data/assessment/final_data.txt", sep=",", row.names=FALSE)

