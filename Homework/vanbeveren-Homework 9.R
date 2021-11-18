################################################
# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 9
# Date due: 11/02/2020
#
# Attribution statement: (choose only one)
# 2. I did this homework with help from the book and the professor and these Internet sources: https://www.techopedia.com/definition/9482/sparse-matrix
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

load("titanic.raw.Rdata")
badboat<- titanic.raw

### Part 1

## 1.a.
View(badboat)
# In this dataframe, there are 4 variables. These are the class each passenger was in, the gender of each passenger, the age group they were in, and wheter they survived the sinking. This is a sparse matrix, as all of the values have a non-zero value.   

## 1.b.
table(badboat$Survived)
# There are 1490 passengers who did not survive, and there are 711 passengers who did survive.

## 1.c.
prop.table(table(badboat$Survived))
# 68% of the passengers did not survive, while 32% did survive.

## 1.d.
prop.table(table(badboat$Class))
prop.table(table(badboat$Sex))
prop.table(table(badboat$Age))

## 1.e.
prop.table(table(badboat$Age, badboat$Sex))
# I see that the highest percentage comes from male adults (76%). The lowest percentage comes from female children at 2%.

### Part 2

## 2.f.
library(arules)
library(arulesViz)

## 2.g.
badboat$Class<- as.factor(badboat$Class)
badboat$Sex<- as.factor(badboat$Sex)
badboat$Age<- as.factor(badboat$Age)
badboat$Survived<- as.factor(badboat$Survived)
badboatx<- as(badboat, "transactions")

## 2.h.
inspect(badboatx)
itemFrequency(badboatx)
itemFrequencyPlot(badboatx)
# Based on these inspections, it seems like most of the passengers were members of the crew, there were more males than females, there were more adults than children, and most of the passengers did not survive.

## 2.i.
# The difference between "badboat" and "badboatx" is that "badboat" is a dataframe that shows all of the observations and thier values for each of the 4 variables. On the other hand, "badboatx" combines all of the variable values for each passenger into a transaction.

### Part 3

## 3.j.
rules<- apriori (badboatx, parameter=list (support=0.005, confidence=0.5),
                 appearance=list(rhs="Survived=Yes"))

## 3.k.
inspect(rules)

## 3.l.
inspect(rules)
# If I wanted to be certain that I would survive the Titanic disaster, I would want to have been a child that was staying in 2nd class. I came to this conclusion because the children staying in 2nd class had the highest confidence out of any other antecedent in the ruleset, as they had a confidence value of 1. 
