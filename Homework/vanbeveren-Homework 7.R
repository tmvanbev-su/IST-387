################################################
# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 7
# Date due: 10/12/2020
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

### Step 1:

## 1.a.
mydata<- read_csv("MedianZIP.csv")

## 1.b.
table(is.na(mydata$Mean))
mydata$Mean<- ifelse(is.na(mydata$Mean), mydata$Median, mydata$Mean)
# The mean is a reasonable replacement for the missing mean values because they are both measures of central tendency, which means that they are both effective at showing the middle of the data.

## 1.c.
View(mydata)
# The "zip" column contains each specific zip code.
# The "Median" column contains the median values for these zip codes.
# The "Mean" column contains the mean values for these zip codes.
# The "Pop" column contains the value of the total population for each zip code.
# The first 2391 zip codes look wierd because they only have 4 digits, whereas zip codes are suppoused to have 5 digits.


### Step 2:

## 2.d.
zipcodes<- read_csv("us_zip_code_latitude_and_longitude.csv")

## 2.e. 
dfNew<- merge(mydata, zipcodes, by="zip")

## 2.f.
str(dfNew)
# This dataframe now has 11 attributes, including the 4 variables from "mydata." In addition to those, the new attributes show the city name, the state abbreviation, the latitude and longitude, the timezone, the daylight savings time flag, and the geopoint for each zip code.


### Step 3:

## 3.g.
states<- read_csv("stateNames.csv")
dfNew<- merge(dfNew, states, by="state")
# This new dataframe includes the original 11 attriubutes, as well as one new one that gives the full name of the state that each zip code is located within.


### Step 4: 

## 4.f.
us<- map_data("state")
dfNew$state_name<- tolower(dfNew$name)
map<- ggplot(dfNew, aes(map_id=state_name))
map<- map + geom_map(map=us, fill="white", color="black") + geom_point(aes(x=Longitude,y=Latitude, color=Mean))
map<- map + expand_limits(x=us$long, y=us$lat)
map<- map + coord_map() + ggtitle("Mean per ZIP Code")
map

## 4.g. 
# This map is not good because it is exteremly crowded and one cannot get the sense of the differences between means for all of the zip codes. Also, Alaska and Hawaii do not have any sort of outlined borders, so it is difficult to analyze those states through this map.


### Step 5:

## 5.h.
dfNew$Total <- dfNew$Mean*dfNew$Pop # This creates a new column in "dfNew" called "Total." This column contains the product of the "Mean" and "Pop" column for each row. 
dfSimple = aggregate(dfNew[c("Pop", "Total")],
                     by = list(dfNew$state_name),
                     FUN = sum) # This creates a new dataframe called "dfSimple." It takes it's values through the aggregate of the "Pop" and "Total" columns in "dfNew" and sorts them by state names. As a result of this aggregating, R automatically creates a new column called "Group.1."
dfSimple$name <- dfSimple$Group.1 # This takes the values from the "Group.1" column and puts them into the "name" column.
dfSimple$Group.1 <- NULL # This deletes the "Group.1" column.
# There are 51 rows in "dfSimple" because there is a row for each U.S. state, as well as for Washington D.C.

## 5.i.
dfSimple$income<- dfSimple$Total/dfSimple$Pop


### Part 6

## 6.j.
map2<- ggplot(dfSimple, aes(map_id=name))
map2<- map2 + geom_map(map=us,aes(fill=income))
map2<- map2 + expand_limits(x=us$long, y=us$lat)
map2<- map2 + coord_map() + ggtitle("Average Income in each US State")
map2



