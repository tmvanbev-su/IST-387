# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 5
# Date due: 9/28/2020
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

library(RCurl) # calls the "RCurl" package for use
library(jsonlite) # calls the "jsonlite" package for use
dataset <- getURL("https://opendata.maryland.gov/resource/pdvh-tf2u.json") # creates the dataset function through the data in the provided URL
df <- jsonlite::fromJSON(dataset) # creates the dataframe "df" by using the "jsonlite" package to read the JSON file from the URL and extracts the data within
df$day_of_week <- str_trim(df$day_of_week) # Parses the "day_of_week" column in the "df" dataframe and eliminates all extra spaces in the values

### Part 1

## 1.a.
str(df)
View(df)

## 1.b
# This is a dataset that contains information about car accidents in Maryland that occured from January 1st, 2012 to January 21st, 2012.
# There are 1000 rows in the dataframe. Each row represents a specfic car accident. 
# There are 18 columns in the dataframe. The "case_number" column references the case number assigned to each accident. The "barrack" column references the broad location in Maryland where the accident occured. The "acc_date" column references the date of the accident. The "acc_time" column references the time of day that each accident occured during. The "acc_time_code" references a numerical value stating which part of the day the accident took place. The "day_of_week" column states which day of the week an accident occured. The "road" column references which road the accident occured on. The "intersect_road" column references the nearest intersecting road on the road where the accident occured. The "dist_from_intersect" column references the distance that the accident was from the nearest intersection. The "dist_direction" column references the direction of the intersection from the accident. The "city_name" column references the city in Maryland where the accident took place. The "county_code" column references the numerical code for the county where the accident took place. The "county_name" column references the name of the county where the accident took place. The "vehicle_count" column references how many vehicles were involved in each accident. The "prop_dest" column references whether or not any property was destroyed as a result of the accident. The "injury" column references whether or not there were any injuries as a result of the accident. The "collision_with_1" column references the type of being or object that was one of the objects/beings involved in the accident. The "collision_with_2" column references the type of object or being for the other object/being that was involved in the crash.

### Part 2

## 2.c.
nrow(df[df$day_of_week=="FRIDAY",])
# There were 151 accidents happened on a Friday.

## 2.d.
nrow(df[df$day_of_week=="FRIDAY" & df$injury=="NO",])
# There were 102 accidents that happened on a Friday and that had no injuries.

## 2.e.
nrow(df[df$day_of_week=="FRIDAY" & df$injury=="YES",])
# There were 49 accidents that happened on a Friday and that had injuries. 

## 2.f.
dfFri<- df[df$day_of_week=="FRIDAY" & df$injury=="YES",]

## 2.g.
dfFri$vehicle_count<- as.numeric(dfFri$vehicle_count)
dfFriVehicles<-mean(dfFri$vehicle_count, na.rm=TRUE)
# The mean is 2.06383.

## 2.h.
hist(dfFri$vehicle_count)
# The distribution does not show a consistent bell curve on the histogram, but rather, shows a majority of accidents had involved 2 cars. 

