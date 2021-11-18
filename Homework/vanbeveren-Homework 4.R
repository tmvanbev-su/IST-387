# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 4
# Date due: 9/21/2020
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

# Set working directory 
setwd("/Users/tylervanbeveren/Desktop/IST387-labs") # Change to the folder containing your homework data files

#######

## 1.
vectorStats<- function(numVec) {
  statsList <- c(mean (numVec),
                 median (numVec))
  return(statsList)
}

## 2. 
vectorStats(1:10)

## 3.
vectorStats<- function(numVec) {
  statsList <- c(mean (numVec),
                 median (numVec),
                 max (numVec),
                 min (numVec),
                 sd (numVec))
  return(statsList)
}

## 4.
vectorStats(1:10)

## 5. 
myAQdata <- airquality
View(myAQdata)
# The variables in this dataset contain the values for ozone emissions, solar ray emissions, wind speed, and temperature for every day in the months of May, June, July, August, and September.

## 6.
sample(myAQdata$Wind, size=5)

## 7. 
vectorStats(sample(myAQdata$Wind, size=5))

## 8.
replicate(10, vectorStats(sample(myAQdata$Wind, size=5)))

## 9. 
# Every replication produces a different result because it always produces a random sample.

## 10. 
values<- replicate(1000, vectorStats(sample(myAQdata$Wind, size=5)))

## 11. 
hist(values[1,])

## 12. 
valuesRepeat<- replicate(1000, vectorStats(sample(myAQdata$Wind, size=50)))
hist(valuesRepeat[1,])
# This new replication affects the histogram by making the horizontal axis, or the range of means in the sample, smaller. However, the bell curve shape is still present.
