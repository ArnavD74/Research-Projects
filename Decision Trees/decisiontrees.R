install.packages("rpart")
install.packages("rpart.plot")
install.packages("RColorBrewer")
library(rpart)
library(rpart.plot)
library(RColorBrewer)
survey <- read.csv("C:/Users/arugo/Desktop/ExpandedF21DataSurveyWithSectionsAnonymized.csv", header=FALSE)
View(survey)

origsurvey = survey
survey = survey[-1,]

survey$V12[survey$V12 == "No"] = "CantRollTongue"
survey$V12[survey$V12 == "Yes"] = "CanRollTongue"


#-----
ChocolateOrVanilla = survey$V6

CanRollTongue = survey$V12
phoneType = survey$V13
randomNumber = survey$V14
#-----
ThermostatTemperature = survey$V9

DressColor = survey$V3
Floaters = survey$V4
#ChocolateOrVanilla = survey$V6
#-----
#DressColor = survey$V3

# ThermostatTemperature = survey$V9
DominantHand = survey$V7
GrossFood = survey$V16
#randomNumber = survey$V14

#-----

decisiontree1 = rpart(ChocolateOrVanilla ~ CanRollTongue + phoneType + randomNumber, data=survey, method="class")
rpart.plot(decisiontree1)
printcp(decisiontree1)

decisiontree2 = rpart(ThermostatTemperature ~ DressColor + Floaters + ChocolateOrVanilla, data=survey, method="class")
rpart.plot(decisiontree2)
printcp(decisiontree2)

decisiontree3 = rpart(DressColor ~ ThermostatTemperature + DominantHand + GrossFood + randomNumber, data=survey, method="class"
rpart.plot(decisiontree3)
printcp(decisiontree3)