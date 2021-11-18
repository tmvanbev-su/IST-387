################################################
# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 6
# Date due: 10/05/2020
#
# Attribution statement: (choose only one)
# 1. I did this homework by myself, with help from the book and the professor

# Run these three functions to get a clean test of homework code
dev.off() # Clear the graph window
cat('\014')  # Clear the console
rm(list=ls()) # Clear user objects from the environment

# Set working directory 
setwd("/Users/tylervanbeveren/Desktop/IST387-labs") # Change to the folder containing your homework data files

########

### Step 1:

## 1.a.
air<- airquality

## 1.b.
View(air)
# These variables were measured every day from May 1st to September 30th. 

### Step 2:

air$Ozone[is.na(air$Ozone)]

## 2.c. 
# This statement works by going through each row in the "Ozone" column of the "air" dataframe and picking out each "NA" value by reporting them as TRUE. It then reports all of the values together by themsleves.

## 2.d. 
air$Solar.R[is.na(air$Solar.R)]
air$Wind[is.na(air$Wind)]
air$Temp[is.na(air$Temp)]

## 2.e. 
air$Ozone<- na_interpolation(air$Ozone)
air$Solar.R<- na_interpolation(air$Solar.R)
air$Wind<- na_interpolation(air$Wind)
air$Temp<- na_interpolation(air$Temp)

## 2.f.
air$Ozone[is.na(air$Ozone)]
air$Solar.R[is.na(air$Solar.R)]
air$Wind[is.na(air$Wind)]
air$Temp[is.na(air$Temp)]

### Step 3:

## 3.g.
ggplot(air, aes(x=Ozone)) + geom_histogram(bins=10) + ggtitle("O-Zone Levels")

## 3.h. 
ggplot(air, aes(x=Solar.R)) + geom_histogram(bins=10) + ggtitle("Solar Radiation Levels")
ggplot(air, aes(x=Wind)) + geom_histogram(bins=10) + ggtitle("Wind Speeds")
ggplot(air, aes(x=Temp)) + geom_histogram(bins=10) + ggtitle("Temperatures")
# To make all of the histograms look right, one should add the bins parameter and set it to 10.

### Step 4:

## 4.i.
air$Date<- as.Date(paste("1973", airquality$Month, airquality$Day, sep="-"))
# This code creates a new column in the "air" dataframe with the name of "Date." It creates the values for this column by placing "1973" and the corresponding values for the "Day" and "Month" columns to create a complete date. It then seperates each of these inputs by the "-" sign and places each value in a row. 

## 4.j. 
ozoneLine<- ggplot(air, aes(x=Date, y=Ozone)) + geom_line()
ozoneLine

## 4.k.
solarLine<- ggplot(air, aes(x=Date, y=Solar.R)) + geom_line(color='orange')
solarLine
windLine<- ggplot(air, aes(x=Date, y=Wind)) + geom_line(color="light blue")
windLine
tempLine<- ggplot(air, aes(x=Date, y=Temp)) + geom_line(color="red")
tempLine

## 4.l.
airScat<- ggplot(air, aes(x=Wind, y=Temp, color=Ozone, size=Ozone)) + geom_point() 
airScat

## 4.m.
# Through looking at these visualizations, the insight that I gather is that when temperatures were high and wind speeds were low, there was a considerable effect produced on the O-zone. However, when temperatures were low and wind speeds were high, there was no significant impact on the O-zone. 




