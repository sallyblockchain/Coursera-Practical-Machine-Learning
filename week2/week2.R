## Caret package
library(caret)
library(kernlab)
data(spam)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=F)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)

set.seed(32343)
# install.packages("e1071")
modelFit <- train(type ~., data=training, method="glm")
modelFit
modelFit$finalModel
predictions <- predict(modelFit, newdata=testing)
predictions

confusionMatrix(predictions, testing$type)

## Data slicing
set.seed(32323)
# k-fold
folds <- createFolds(y=spam$type, k=10, list=T, returnTrain=T)
sapply(folds, length)
folds[[1]][1:10]
# return test
set.seed(32323)
folds <- createFolds(y=spam$type, k=10, list=T, returnTrain=F)
sapply(folds, length)
folds[[1]][1:10]
# resampling
set.seed(32323)
folds <- createResample(y=spam$type, times=10, list=T)
sapply(folds, length)
folds[[1]][1:10]
# time slices
set.seed(32323)
tme <- 1:1000
folds <- createTimeSlices(y=tme, initialWindow=20, horizon=10)
names(folds)
folds$train[[1]]
folds$test[[1]]

## Training options
args(train.default) 
# Continous outcomes - RMSE: root mean squared error
# - RSquared: R^2 from regression models
# Categorical outcomes - Accuracy: Fraction correct
# - Kappa: A measure of concordance
args(trainControl)
# boot, boot632, cv, repeatedcv, LOOCV

## Plotting predictors
library(ISLR)
library(ggplot2)
library(caret)
data(Wage)
summary(Wage)
inTrain <- createDataPartition(y=Wage$wage, p=0.7, list=F)
training <- Wage[inTrain,]
testing <- Wage[-inTrain,]
dim(training)
dim(testing)
# feature plot
featurePlot(x=training[, c("age", "education", "jobclass")],
                       y=training$wage, plot="pairs")
qplot(age, wage, data=training)
qplot(age, wage, color=jobclass, data=training)
# Add regression smoothers
qq <- qplot(age, wage, color=education, data=training)
qq + geom_smooth(method='lm', formula=y~x)
library(Hmisc)
cutWage <- cut2(training$wage, g=3)
table(cutWage)
p1 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c("boxplot"))
p1
p2 <- qplot(cutWage, age, data=training, fill=cutWage, geom=c("boxplot", "jitter"))
library(gridExtra)
library(ggplot2)
grid.arrange(p1, p2, ncol=2)
# Tables
t1 <- table(cutWage, training$jobclass)
t1
prop.table(t1, 1)
# Density plots
qplot(wage, color=education, data=training, geom="density")
# Make plots only in the training set: imbalance in outcomes, outliers
# groups of points not explained by a predictor, skewed variables

## Preprocessing
library(caret)
library(kernlab)
data(spam)
inTrain <- createDataPartition(y=spam$type, p=0.75, list=F)
training <- spam[inTrain,]
testing <- spam[-inTrain,]
dim(training)
hist(training$capitalAve, main="", xlab="ave. capital run length")
mean(training$capitalAve)
sd(training$capitalAve)
# Standardizing
trainCapAve <- training$capitalAve
trainCapAveS <- (trainCapAve - mean(trainCapAve)) / sd(trainCapAve)
mean(trainCapAveS)
sd(trainCapAveS)
# Standardizing testing
testCapAve <- testing$capitalAve
testCapAveS <- (testCapAve - mean(trainCapAve)) / sd(trainCapAve)
mean(testCapAveS)
sd(testCapAveS)

preObj <- preProcess(training[,-58], method=c("center", "scale"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
mean(trainCapAveS)
sd(trainCapAveS)
testCapAveS <- predict(preObj, testing[,-58])$capitalAve
mean(testCapAveS)
sd(testCapAveS)
set.seed(32343)
modelFit <- train(type~., data=training, 
                  preProcess=c("center", "scale"), method="glm")
modelFit
# standardizing - Box-cox transform
preObj <- preProcess(training[,-58], method=c("BoxCox"))
trainCapAveS <- predict(preObj, training[,-58])$capitalAve
par(mfrow=c(1, 2))
hist(trainCapAveS)
qqnorm(trainCapAveS)
# standardizing - Imputing data
set.seed(13343)
training$capAve <- training$capitalAve
selectNA <- rbinom(dim(training)[1], size=1, prob=0.05)==1
training$capAve[selectNA] <- NA
preObj <- preProcess(training[,-58], method="knnImpute")
library(RANN)
capAve <- predict(preObj, training[,-58])$capAve
capAveTruth <- training$capitalAve
capAveTruth <- (capAveTruth - mean(capAveTruth)) / sd(capAveTruth)
quantile(capAve - capAveTruth)
quantile((capAve - capAveTruth)[selectNA])
quantile((capAve - capAveTruth)[!selectNA])
