# Shefali Emmanuel
# October 26, 2019
# HW9 KNN Nearest Neighbor Problem

#Tutorial by: Jaylayer Academy
# https://www.youtube.com/watch?v=GtgJEVxl7DY
# https://www.youtube.com/watch?v=DkLNb0CXw84

#mydata = read.csv("gender_submission.csv")  # read csv file 
#mydata = read.csv("test.csv")  # read csv file 
mydata = read.csv("train.csv")  # read csv file 
str(mydata)
table(mydata$Embarked) #only look at the embarked column in data set
head(mydata,20) #see the headers in the data frame
mydata #see entire data set
#set.seed(9850)
#runif(150)
#gp <- runif(nrow(mydata))
#mydataMixedUp <- mydata[order(gp),]
#str(mydataMixedUp)
#gp
summary(mydata[,c(5)])
normalize <- function(x){
  + return( (x-min(x)) / (max(x)-min(x))) }
normalize(c(1,2,3,4,5))
mydata_Normalized <- as.data.frame(lapply(mydata[,c(1,2,3,7,8,10)], normalize))
#mydata_Normalized <- as.data.frame(lapply(mydata[,c(1,2)], normalize))
str(mydata_Normalized)
summary(mydata_Normalized)

mydata_train <- mydata_Normalized[1:871, ]
mydata_test <- mydata_Normalized[872:891, ]
mydata_train_target <- mydata[1:871, 5]
mydata_test_target <- mydata[872:891, 5]


#mydata_train <- mydata_Normalized[1:398, ]
#mydata_test <- mydata_Normalized[399:418, ]

#mydata_train_target <- mydata[1:398, 2]
#mydata_test_target <- mydata[399:418, 2]

require(class)

#k = how many nearest neighbors do you want the alg to have
m1 <- knn(train=mydata_train,test= mydata_test,cl=mydata_train_target,k= sqrt(418)) #prediction for the classification of all the values in the test dataframe
#m1 <- knn(train=mydata_train,test= mydata_test,cl=mydata_train_target,k= sqrt(891)) #prediction for the classification of all the values in the test dataframe

m1

table(mydata_test_target, m1)
