# Shefali Emmanuel
# HW7 Kaggle Titanic
# Tutorial found at: https://www.kaggle.com/hillabehar/titanic-analysis-with-r#prediction


# I used the following packages for this analysis:

install.packages("ggplot2")
install.packages("dplyr")
install.packages("GGally")
install.packages("rpart")
install.packages("rpart.plot")
install.packages("randomForest")

library(ggplot2)
library(dplyr)
library(GGally)
library(rpart)
library(rpart.plot)
library(randomForest)

# I loaded the data:

test <- read.csv('/Users/shefalinareshemmanuel/Downloads/titanic/test.csv',stringsAsFactors = FALSE)
train <- read.csv('/Users/shefalinareshemmanuel/Downloads/titanic/train.csv', stringsAsFactors = FALSE)

# Creating a new data set with both the test and the train sets
full <- bind_rows(train,test)
LT=dim(train)[1]
# Checking the structure
str(full)

# Missing values
colSums(is.na(full))
colSums(full=="")

# We have a lot of missing data in the Age feature (263/1309)
# Let's change the empty strings in Embarked to the first choice "C"
full$Embarked[full$Embarked==""]="C"

# Let's see how many features we can move to factors
apply(full,2, function(x) length(unique(x)))

# Let's move the features Survived, Pclass, Sex, Embarked to be factors
cols<-c("Survived","Pclass","Sex","Embarked")
for (i in cols){
  full[,i] <- as.factor(full[,i])
}

# Now lets look on the structure of the full data set
str(full)

# Analysis

#At this time point I loaded and cleaned a little bit of the data. Now it’s time to look at the relationships between the different features:
  
#{r echo=TRUE, message=FALSE, warning=FALSE}
# First, let's look at the relationship between sex and survival:
ggplot(data=full[1:LT,],aes(x=Sex,fill=Survived))+geom_bar()

# Survival as a function of Embarked:
ggplot(data = full[1:LT,],aes(x=Embarked,fill=Survived))+geom_bar(position="fill")+ylab("Frequency")

t<-table(full[1:LT,]$Embarked,full[1:LT,]$Survived)
for (i in 1:dim(t)[1]){
  t[i,]<-t[i,]/sum(t[i,])*100
}
t
#It looks that you have a better chance to survive if you Embarked in 'C' (55% compared to 33% and 38%).

# Survival as a function of Pclass:
ggplot(data = full[1:LT,],aes(x=Pclass,fill=Survived))+geom_bar(position="fill")+ylab("Frequency")
# It looks like you have a better chance to survive if you in lower ticket class.
# Now, let's devide the graph of Embarked by Pclass:
ggplot(data = full[1:LT,],aes(x=Embarked,fill=Survived))+geom_bar(position="fill")+facet_wrap(~Pclass)

# Now it's not so clear that there is a correlation between Embarked and Survival. 

# Survivial as a function of SibSp and Parch
ggplot(data = full[1:LT,],aes(x=SibSp,fill=Survived))+geom_bar()
ggplot(data = full[1:LT,],aes(x=Parch,fill=Survived))+geom_bar()

# The dymanics of SibSp and Parch are very close one each other.
# Let's try to look at another parameter: family size.

full$FamilySize <- full$SibSp + full$Parch +1;
full1<-full[1:LT,]
ggplot(data = full1[!is.na(full[1:LT,]$FamilySize),],aes(x=FamilySize,fill=Survived))+geom_histogram(binwidth =1,position="fill")+ylab("Frequency")
# That shows that families with a family size bigger or equal to 2 but less than 6 have a more than 50% to survive, in contrast to families with 1 member or more than 5 members. 

# Survival as a function of age:

ggplot(data = full1[!(is.na(full[1:LT,]$Age)),],aes(x=Age,fill=Survived))+geom_histogram(binwidth =3)
ggplot(data = full1[!is.na(full[1:LT,]$Age),],aes(x=Age,fill=Survived))+geom_histogram(binwidth = 3,position="fill")+ylab("Frequency")

# Children (younger than 15YO) and old people (80 and up) had a better chance to survive.

# Is there a correlation between Fare and Survivial?
ggplot(data = full[1:LT,],aes(x=Fare,fill=Survived))+geom_histogram(binwidth =20, position="fill")
full$Fare[is.na(full$Fare)] <- mean(full$Fare,na.rm=T)
# It seems like if your fare is bigger, than you have a better chance to survive.
sum(is.na(full$Age))
# There are a lot of missing values in the Age feature, so I'll put the mean instead of the missing values.
full$Age[is.na(full$Age)] <- mean(full$Age,na.rm=T)
sum(is.na(full$Age))

# The title of the passanger can affect his survive:
full$Title <- gsub('(.*, )|(\\..*)', '', full$Name)
full$Title[full$Title == 'Mlle']<- 'Miss' 
full$Title[full$Title == 'Ms']<- 'Miss'
full$Title[full$Title == 'Mme']<- 'Mrs' 
full$Title[full$Title == 'Lady']<- 'Miss'
full$Title[full$Title == 'Dona']<- 'Miss'
officer<- c('Capt','Col','Don','Dr','Jonkheer','Major','Rev','Sir','the Countess')
full$Title[full$Title %in% officer]<-'Officer'

full$Title<- as.factor(full$Title)

ggplot(data = full[1:LT,],aes(x=Title,fill=Survived))+geom_bar(position="fill")+ylab("Frequency")

# Prediction

#At this time point we want to predict the chance of survival as a function of the other features. I'm going to keep just the correlated features: Pclass, Sex, Age, SibSp, Parch, Title and Fare.
#I'm going to divide the train set into two sets: training set (train1) and test set (train2) to be able to estimate the error of the prediction.

#{r echo=TRUE,message=FALSE,warning=FALSE}
# The train set with the important features 
train_im<- full[1:LT,c("Survived","Pclass","Sex","Age","Fare","SibSp","Parch","Title")]
ind<-sample(1:dim(train_im)[1],500) # Sample of 500 out of 891
train1<-train_im[ind,] # The train set of the model
train2<-train_im[-ind,] # The test set of the model

# Let's try to run a logistic regression
model <- glm(Survived ~.,family=binomial(link='logit'),data=train1)
summary(model)

# We can see that SibSp, Parch and Fare are not statisticaly significant. 
# Let's look at the prediction of this model on the test set (train2):
pred.train <- predict(model,train2)
pred.train <- ifelse(pred.train > 0.5,1,0)
# Mean of the true prediction 
mean(pred.train==train2$Survived)

t1<-table(pred.train,train2$Survived)
# Presicion and recall of the model
presicion<- t1[1,1]/(sum(t1[1,]))
recall<- t1[1,1]/(sum(t1[,1]))
presicion
recall
# F1 score
F1<- 2*presicion*recall/(presicion+recall)
F1
# F1 score on the initial test set is 0.871. This pretty good.

# Let's run it on the test set:

test_im<-full[LT+1:1309,c("Pclass","Sex","Age","SibSp","Parch","Fare","Title")]

pred.test <- predict(model,test_im)[1:418]
pred.test <- ifelse(pred.test > 0.5,1,0)
res<- data.frame(test$PassengerId,pred.test)
names(res)<-c("PassengerId","Survived")
write.csv(res,file="res.csv",row.names = F)

#At this time point I want to predict survival using a decision tree model:
model_dt<- rpart(Survived ~.,data=train1, method="class")
rpart.plot(model_dt)

pred.train.dt <- predict(model_dt,train2,type = "class")
mean(pred.train.dt==train2$Survived)
t2<-table(pred.train.dt,train2$Survived)

presicion_dt<- t2[1,1]/(sum(t2[1,]))
recall_dt<- t2[1,1]/(sum(t2[,1]))
presicion_dt
recall_dt
F1_dt<- 2*presicion_dt*recall_dt/(presicion_dt+recall_dt)
F1_dt
# Let's run this model on the test set:
pred.test.dt <- predict(model_dt,test_im,type="class")[1:418]
res_dt<- data.frame(test$PassengerId,pred.test.dt)
names(res_dt)<-c("PassengerId","Survived")
write.csv(res_dt,file="res_dt.csv",row.names = F)

# Let's try to predict survival using a random forest.
model_rf<-randomForest(Survived~.,data=train1)
# Let's look at the error
plot(model_rf)
pred.train.rf <- predict(model_rf,train2)
mean(pred.train.rf==train2$Survived)
t1<-table(pred.train.rf,train2$Survived)
presicion<- t1[1,1]/(sum(t1[1,]))
recall<- t1[1,1]/(sum(t1[,1]))
presicion
recall
F1<- 2*presicion*recall/(presicion+recall)
F1
# Let's run this model on the test set:
pred.test.rf <- predict(model_rf,test_im)[1:418]
res_rf<- data.frame(test$PassengerId,pred.test.rf)
names(res_rf)<-c("PassengerId","Survived")
write.csv(res_rf,file="res_rf.csv",row.names = F)

# Conclusion
# The mean of the right predictions that I got on the test set is 0.76555 with the decision tree method, 0.77990 with the logistic regression model, and 0.80382 with the random forest model. 

# Can we improve the results of prediction?
# The best solution seemed to be found at https://www.kaggle.com/ash316/eda-to-prediction-dietanic/comments

# Some of the observations:
# 1)Some of the common important features are Initial,Fare_cat,Pclass,Family_Size.
# 2)The Sex feature doesn't seem to give any importance, which is shocking as we had seen earlier that Sex combined with Pclass was giving a very good differentiating factor. Sex looks to be important only in RandomForests.
#However, we can see the feature Initial, which is at the top in many classifiers.We had already seen the positive correlation between Sex and Initial, so they both refer to the gender.
# 3)Similarly the Pclass and Fare_cat refer to the status of the passengers and Family_Size with Alone,Parch and SibSp.
# I have not edited my code in this file to configure this new prediction, as the assignment asked to repeat the prediction part of the tutorial and not edit it.

