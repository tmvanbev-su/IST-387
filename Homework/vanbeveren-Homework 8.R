################################################
# IST387, Standard Homework Heading
#
# Student name: Tyler VanBeveren
# Homework number: 8
# Date due: 10/19/2020
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
setwd("/Users/tylervanbeveren/Desktop/IST387-labs") # Change to the folder containing your homework data files
#
########

### A. 
install.packages("psych")
library(psych)
?sat.act
str(sat.act)
summary(sat.act)
df<- sat.act
View(df)

### B.
agePlot<- ggplot(data=df) + aes(x=age, y=ACT) + geom_point()
gendPlot<- ggplot(data=df) + aes(x=gender, y=ACT) + geom_point()
eduPlot<- ggplot(data=df) + aes(x=education, y=ACT) + geom_point()

### C.
actReg<- lm(ACT ~ age + gender + education, data=df)

### D.
summary(actReg)
# The adjusted R-Squared is 0.03201.
# The only predictor that is statistically significant is education, as it's coefficent is 0.47890.

### E. 
# My overall interpretation of the model is that education would definitley have the greater impact on whether or not someone would score well on the ACT. Even without this model, I would not have thought that age and gender would not have a significant impact on ACT scores, but this model validates that. 
# In terms of age, as someone gets anothey year older, their ACT score is likely to increase by 0.01623 points. This makes sense because as someone gets older, they gain more general knowledge. Regardless, this value shows that this predictor is not particuarly significant. 
# In terms of gender, the value is -0.48606. This makes sense because someone being male or female should have next to no impact on how they perform on the ACT.
# In terms of education, as someone receives more education, their ACT score is likely to increase by 0.47890 points. This makes sense because it is almost certain that someone would perform well on the ACT if they have the adequate amopunt of knowledge and education.

### F. 
predDf<- data.frame(gender=2, education=2, age=20)
predict(actReg,predDf)
# The predicted score is 27.72728.

### G. 
satvReg<- lm(SATV ~ age + gender + education, data=df)
satqReg<- lm(SATQ ~ age + gender + education, data=df)

### H.
summary(actReg)
summary(satvReg)
summary(satqReg)
# With all three of these models, education has a statistical significance. This means that education will always have some sort of notable impact on the scores of these tests. One interesting thing of note is that age has a statistical significance for SATQ and SATV scores. This means that as someone gets older, they are much more likely to do worse on these tests than better. Finally, gender is found to be very statistically signifcant for the SATQ, as it has a value of -42.5598. This means that there is a strong difference in scores between males and females on the SATQ.

