#Shefali Emmanuel
#Data 101 HW4 LinearRegression
#September 13, 2019

#workshop found at https://www.youtube.com/watch?v=0vCK17cQt14

#Data Structures in R: Vectors, Matricies, Array's, Data Frames, and Lists

install.packages("DMwR")

#P value
#T value
#Standard Deviation- difference of data points to the predicted Y
#Resididual Deviation
#Variance
#Least Squared
#Mean

head(cars)
str(cars)

plot(cars) #shows the graphical version
plot(cars$speed, cars$dist) #says specifically plot speed and dist ONLY

#correlation- strength of the relationship between 2 variables
#close to 1 means strong correlation
cor(cars$speed, cars$dist) 
#or
cor(cars$speed, cars
    $dist)

linearMod <- lm(dist ~ speed, data = cars)
summary(linearMod)

#dist= Intercept + speed
#dist = -17.5791 + 3.9324

#p < 0.05 for the model to be statistically significant

#set starting point 
set.seed(100)

#splitting the data set
trainingRowIndex <- sample(1:nrow(cars), 0.8*nrow(cars))

#model training data
trainingData <- cars[trainingRowIndex,]

#test data
testData <- cars[trainingRowIndex,]

lmMod <- lm(dist ~ speed, data = trainingData)

distPred <- predict(lmMod, testData)

summary(lmMod)

actuals_predicts <- data.frame(cbind(actuals=testData$dist, predicteds=distPred))
head(actuals_predicts)

correlation_accuracy <- cor(actuals_predicts)
correlation_accuracy

DMwR::regr.eval(actuals_predicts$actuals, actuals_predicts$predicteds)
