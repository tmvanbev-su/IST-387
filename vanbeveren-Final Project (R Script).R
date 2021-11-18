################################################
# IST387, Final Project Heading
#
# Student name: Tyler VanBeveren
# Homework number: Final Project
# Date due: 12/04/2020
#
# Attribution statement: (choose only one)
# 1. I did this final project by myself, with help from the book and the professor
#
# Run these three functions to get a clean test of code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment
#
# Set working directory 
setwd("/Users/tylervanbeveren/Desktop/IST387-labs") # Change to the folder containing your final project data files
#
########

## 1.
library(tidyverse)

airData<- read_csv("IST387-Fall2020-airData-tmvanbev.csv")

## 2.
hist(airData$age)
hist(airData$departure_delay_in_minutes)
hist(airData$arrival_delay_in_minutes)
hist(airData$flight_time_in_minutes)
hist(airData$flight_distance)
hist(airData$likelihood_to_recommend)

table(airData$gender)
table(airData$destination_city)
table(airData$origin_city)
table(airData$type_of_travel)
table(airData$flight_cancelled)

## 3.
boxplot(likelihood_to_recommend ~ gender, data=airData)
boxplot(likelihood_to_recommend ~ type_of_travel, data=airData)
boxplot(likelihood_to_recommend ~ flight_cancelled, data=airData)

## 4.
airData<- na.omit(airData)

## 5.
library(ggplot2)
library(ggmap)
usmap<- get_stamenmap(bbox=c(left=-167.50, bottom=7.45, right=-50.19, top=71.58),
                      zoom=3, maptype="toner")
ggmap(usmap) + geom_point(data=airData, aes(x=dlong, y=dlat,
                                            color=likelihood_to_recommend))

rec_Det<- airData[airData$likelihood_to_recommend<7,]
rec_Pro<- airData[airData$likelihood_to_recommend>8,]

ggmap(usmap) + geom_point(data=rec_Det, aes(x=dlong, y=dlat,
                                            color=likelihood_to_recommend))

ggmap(usmap) + geom_point(data=rec_Pro, aes(x=dlong, y=dlat,
                                            color=likelihood_to_recommend))

ggmap(usmap) + geom_point(data=rec_Det, aes(x=olong, y=olat,
                                            color=likelihood_to_recommend))

ggmap(usmap) + geom_point(data=rec_Pro, aes(x=olong, y=olat,
                                            color=likelihood_to_recommend))

## 6.
library(quanteda)

detCorpus<- corpus(rec_Det$free_text)
proCorpus<- corpus(rec_Pro$free_text)

det_dfm<- dfm(detCorpus, remove_punct=TRUE, remove=stopwords("english"))
pro_dfm<- dfm(proCorpus, remove_punct=TRUE, remove=stopwords("english"))

textplot_wordcloud(det_dfm, min_count=3)
textplot_wordcloud(pro_dfm, min_count=3)

## 7.
posWords<- scan("positive-words.txt", character(0), sep="\n")
negWords<- scan("negative-words.txt", character(0), sep="\n")
posWords<- posWords[-1:-34]
negWords<- negWords[-1:-34]

mDet<- as.matrix(det_dfm)
detReviewsPerWord<- colSums(mDet) 
detReviewsPerWord<- sort(detReviewsPerWord, decreasing=TRUE)

mPro<- as.matrix(pro_dfm)
proReviewsPerWord<- colSums(mPro)
proReviewsPerWord<- sort(proReviewsPerWord, decreasing=TRUE)

matchedPpromo<- match(names(proReviewsPerWord), posWords, nomatch=0)
matchedNpromo<- match(names(proReviewsPerWord), negWords, nomatch=0)

matchedPdetract<- match(names(detReviewsPerWord), posWords, nomatch=0)
matchedNdetract<- match(names(detReviewsPerWord), negWords, nomatch=0)

sum(matchedPpromo != 0)
sum(matchedNpromo != 0)

sum(matchedPdetract != 0)
sum(matchedNdetract != 0)

proReviewsPerWord[matchedPpromo != 0]
proReviewsPerWord[matchedNpromo != 0]

detReviewsPerWord[matchedPdetract != 0]
detReviewsPerWord[matchedNdetract != 0]

## 8. 
library(arules)
library(arulesViz)

airCat<- data.frame(Gender=as.factor(airData$gender),
                      type=as.factor(airData$type_of_travel),
                      old=as.factor(airData$age>median(airData$age)),
                      delay=as.factor(airData$departure_delay_in_minutes>15),
                      detractor=as.factor(airData$likelihood_to_recommend<7))

catX<- as(airCat, "transactions")

ruleset<- apriori(catX, parameter=list(support=0.06, confidence=0.5),
                  appearance=list(rhs="detractor=TRUE"))
inspect(ruleset)
#To me, the two most important rules in this ruleset are Rules 16 and 17, as they both have a high confidence value of 1.

## 9.
airPred<- lm(likelihood_to_recommend ~ age + gender + type_of_travel + flight_distance + departure_delay_in_minutes, data=airData)
summary(airPred)

#The adjusted R-squared is lower than the multiple R-squared, implying that this prediction model is not as strong as a model with only one coefficient.
#The p-value is almost exact to the p-value of the intercept and to the scenario where someone's type of travel is "personal travel," showing that these two coefficients are statistically significant.  


