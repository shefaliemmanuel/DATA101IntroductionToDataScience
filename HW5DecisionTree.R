#Shefali Emmanuel
#Data 101 HW5 Decision Tree
#September 13, 2019

install.packages("lattice")
install.packages("ggplot2")
install.packages("rpart")
install.packages("rpart.plot")


library(lattice)
library(ggplot2)
library(rpart)
library(rpart.plot)


data ('iris')
head('iris')
str(iris)
set.seed(9850)
g <- runif(nrow(iris))
iris_ran <- iris[order(g),]
head(iris_ran)
model <- rpart(Species ~ ., data=iris_ran[1:100, ], method='class')
rpart.plot(model, type=4, fallen.leaves = T, extra=104)
model_predict <- predict(model,iris_ran[101:150, ], type ='class')
model_predict

install.packages("caret")
library(caret)
install.packages("e1071")
library(e1071)
confusionMatrix(iris_ran[101:150, 5], reference = model_predict)

