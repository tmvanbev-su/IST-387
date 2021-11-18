################################################
# IST387, Homework 
#
# Student name: Tyler VanBeveren
# Homework number: 2
# Date due: 09/07/2020
#
# Attribution statement: (choose only one)
# 2. I did this homework with help from the book and the professor and these Internet sources: https://stackoverflow.com/questions/20256028/understanding-scale-in-r#:~:text=scale%20%2C%20with%20default%20settings%2C%20will,divide%20by%20the%20std%20deviation.)


# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

# Set working directory 
setwd("/Users/tylervanbeveren/Desktop/IST387-labs") # Change to the folder containing your homework data files

## Make dataset into variable
myCars<- mtcars
summary(myCars)
View(myCars)

## 1.a.
# 20.09

## 1.b. 
# 33.90

## 1.c.
# 10.40

## 1.d. 
mtCarsSorted<- order(myCars$mpg)

## 2.e. 
# Higher HP is better than lower HP. 

## 2.f. 
which.max(myCars$hp)
# 31

## 2.g. 
which.min(myCars$hp)
# 19

## 3.h. 
scaledMPG<- scale(myCars$mpg, center=0, scale=T)

## 3.i.
# This command scales the 'mpg' vector in the 'myCars' dataset by subtracting the mean and dividing by the standard deviation for every value in the vector. 

## 3.j. 
scaledhp<- scale(myCars$hp, center=0, scale=T)

## 3.k. 
scaledmpghp<- order(scaledMPG,scaledhp)
# The command was able to add the two measurements together because it is simply adding the scaled results from both the 'mpg' and the 'hp' vector. It works because both of the vectors have numeric values, which allows you to combine them and put them into a vector of thier own.

## 3.l. 
# The Ford Pantera L has the highest combination of mpg and hp.

## 3.m. 
myCarsSorted<- order(scaledmpghp)





