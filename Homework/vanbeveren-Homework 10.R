################################################
# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 10
# Date due: 11/09/2020
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor
#
# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment
#
# Set working directory 
setwd("/Users/tylervanbeveren/Documents/IST 387") # Change to the folder containing your homework data files
#
########

### Part 1

## 1.a.
library(ggplot2)
library(kernlab)
library(caret)

## 1.b.
d<- diamonds
prem_ideal<- d[(d$cut=="Premium" | d$cut=="Ideal"),]

## 1.c.
prem_ideal$cut<- as.factor(as.character(prem_ideal$cut))

## 1.d.
prem_ideal$clarity<- as.numeric(prem_ideal$clarity)
prem_ideal$color<- as.numeric(prem_ideal$color)

## 1.e. 
?diamonds
# The "carat" variable shows the weight of each diamond, the "cut" shows the quality of the cut for each diamond, the "color" shows the numerically ranked quality of each diamond's color, and the "clarity" shows a numerically ranked measurement for the clarity of each diamond. Also, the "depth" shows the total depth percentage of each diamond, the "table" shows the width of the top of each diamond relative to it's widest point, and the "price" shows the cost in US dollars for each diamond. Finally, the "x" variable shows the length in mm, the "y" variable shows the width in mm, and the "z" variable shows the depth in mm of each diamond. 

### Part 2

## 2.f. 
train<- createDataPartition(y=prem_ideal$cut, p=.67, list=FALSE)
trainSet<- prem_ideal[train,]
testSet<- prem_ideal[-train,]

## 2.g.
dim(trainSet)
dim(testSet)

### Part 3

## 3.h.
svmOut<- ksvm(cut~., data=trainSet, kernel="rbfdot", kpar="automatic", C=5, cross=3, prob.model=TRUE)

## 3.i. 
# Through the book, I learned that the "kernel" is a math function that transforms your input data into the desired form. The "kpar" paramter helps to select which math parameters are used by the kernel function. The "C" parameter is used to help decide how to penalize missclassified data points. The "cross" parameter decides how cross-validation will be performed. Finally, the "prob.model" parameter decides how wheter or not a probability model should be tested.

## 3.j. 
svmOut
# The cross-validation error is 0.08!

### Part 4

## 4.k.
svmPred<- predict(svmOut, testSet, type="response")

## 4.l.
str(svmPred)
head(svmPred)

## 4.m.
table(testSet$cut, svmPred)

## 4.n
(435+551)/1162
# I calculated an error rate of 0.85.

## 4.o. 
confusionMatrix(svmPred, testSet$cut)
# The calculation from the "confusionMatrix()" function was exact to my original calculation.

## 4.p. 
# It is valuable to have a "test" dataset that is seperate from a "training" dataset because the training datset has completely different data than the test dataset. This means that once you use the training dataset to make sure that your support vector machine works, it will produce similar results on the completly different set of data located within the test dataset. 
