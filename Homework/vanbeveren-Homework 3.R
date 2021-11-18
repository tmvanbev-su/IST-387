################################################

# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 3
# Date due: 09/14/2020
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor
# 2. I did this homework with help from the book and the professor and these Internet sources:
# 3. I did this homework with help from <Name of another student> but did not cut and paste any code


# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

# Set working directory 

setwd("/Users/tylervanbeveren/Desktop/IST387-labs") # Change to the folder containing your homework data files

# Part 1

## 1.a
dfStates<- read_csv("https://raw.githubusercontent.com/CivilServiceUSA/us-states/master/data/states.csv")


# Part 2

## 2.b
View(dfStates) # This command pulls up the dataframe as a viewable table.
head(dfStates) # This command pulls up only the data for the first six states in the data frame.
tail(dfStates) # This command pulls up only the data for the last six states in the data frame. 

## 2.c
noTwitter<- is.na(dfStates$twitter_url)

## 2.d
table(noTwitter) ## This shows that 35 states that have Twitter url (FALSE) in dfStates and that 15 states do not (TRUE). 

## 2.e
twitterStates<- data.frame(dfStates[!noTwitter,])

## 2.f
dim(twitterStates)


# Part 3

## 3.g
str(twitterStates)
mean(twitterStates$admission_number)
mean(twitterStates$population)
mean(twitterStates$population_rank)

## 3.h
# The mean population for twitterStates is 6532234.

## 3.i
noTwitterStates<- data.frame(dfStates[noTwitter,])
mean(noTwitterStates$population)
# The mean population for noTwitterStates is 5790290, which means that the states without Twitter URLs have a smaller mean population than that of the states that have Twitter URLs.


# Part 4

## 4.j
gsub("https://twitter.com/","",twitterStates$twitter_url)

## 4.k
# The issue with this output is that a few of the states still show the entire URL after the gsub() command. This is because thier URL has the "http" protocol in the URL, yet the gsub() command only accounted for URLs with the "https" protocol. 

## 4.l
twitterStates$handle<- gsub("https://twitter.com/","",twitterStates$twitter_url)


# Step 5

## 5.m 
getTwitterHandleFromURL<- function(URL){ # Defines the function name, what input it will recieve, and then opens the function
  fixTry1<-gsub("https://twitter.com/","",URL) # Says that if the input matches this URL, then to delete it. 
  fixTry2<- gsub("http://twitter.com/","",fixTry1) # Says that if the input matches this URL, then to replace it with the preferred URL in fixTry1 and perform fixTry1.
  fixTry3<-gsub("http://www.twitter.com/","",fixTry2) # Says that if the input matches this URL, then to replace it with the preferred URL in fixTry2 and perform fixTry2.
  return(fixTry3) # Says that if the input does not match any of the URLs above, the input must be returned.
} # Closes the function

## 5.n
getTwitterHandleFromURL(twitterStates$twitter_url)
# The only problem that is unfixed is that Pennsylvania's data point for the twitter_URL column is actually it's Facebook URL. This is because there must have been an error in the creation of the dataset where the Facebook URL and Twitter URL for Pennsylvania got mixed up.

## 5.o
twitterStates$handle<-getTwitterHandleFromURL(twitterStates$twitter_url)


## Expert Mode!!! 
# A project where you can use these data frames and variables could have the purpose of creating a list of Twitter handles and relevant information that lobbyists could use. 