################################################
# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 11
# Date due: 11/16/2020
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
charVector<- scan("TheRoadNotTaken.txt", character(0), sep="\n")
View(charVector)

## 1.b.
charCorpus<- corpus(charVector)
char_dfm<- dfm(charCorpus, remove_punct=TRUE, remove=stopwords("english"))

## 1.c.
textplot_wordcloud(char_dfm, min_count=1)

### Part 2

## 2.d.
m<- as.matrix(char_dfm)
wordCounts<- colSums(m)

## 2.e.
View(wordCounts)
# Based on this sorted list, the most frequently used word in the poem is "one" with 3 mentions. The words "two", "roads", "diverged", "wood", "took", "way", and "ages" are all mentioned twice. Finally, all of the other words in the poem are mentioned only once. 

### Part 3

## 3.f. 
posWords<- scan("positive-words.txt", character(0), sep="\n")
posWords<- posWords[-1:-34]
negWords<- scan("negative-words.txt", character(0), sep="\n")
negWords<- negWords[-1:-34]

## 3.g.
matchedP<- match(names(wordCounts), posWords, nomatch=0)
# This line of code creates a variable that matches the values of the "name" variable in "wordCounts" with the words in "posWords." The last part of the code declares that if a name from "wordCounts" does not match any of the positive words, it must be granted a value of 0.
matchedN<- match(names(wordCounts), negWords, nomatch=0)

## 3.h. 
View(matchedP)
# Each non-zero entry contains a number other than zero. This values corresponds to the row number in "posWords" that contains the word that matches the word from "wordCounts" which is represented in "matchedP" by it's exact row number from "wordCounts". 

## 3.i. 
wordCounts[matchedP != 0]
# The positive words that were in the speech were "fair", "better", and "leads".

## 3.j.
sum(matchedP != 0)
# There are 3 positive words that were in the speech.

## 3.k.
wordCounts[matchedN != 0]
sum(matchedN != 0)
# There are 3 negative words that were in the speech.

## 3.l.
# Through this process, I found that this speech had the same amount of positive and negative words. There are 3 words of each kind in this speech. 









