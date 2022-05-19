library(car); library(mlogit); library(useful)

setwd("/Users/alissa/Documents/Grad/DSC 520/dsc520")

eelData <- read.delim("data/eel.dat", header = TRUE, stringsAsFactors = TRUE)

## R converts nominal variables into factors alphabetically
## The baseline condition of the variables should be 0
## Many times we need to switch them around to order them correctly

eelData$Cured<-relevel(eelData$Cured, "Not Cured")
eelData$Intervention<-relevel(eelData$Intervention, "No Treatment")

## Logistic Regression

## newModel<-glm(outcome ~ predictor(s), data = dataFrame, 
##              family = name of a distribution, na.action = an action)

eelModel.1 <- glm(Cured ~ Intervention, data = eelData, family = binomial())

eelModel.2 <- glm(Cured ~ Intervention + Duration, data = eelData, family = binomial())

summary(eelModel.1)

## Calculate Chi
modelChi <- eelModel.1$null.deviance - eelModel.1$deviance

## Degrees of Freedom
chidf <- eelModel.1$df.null - eelModel.1$df.residual

## P-Value Chi
chisq.prob <- 1 - pchisq(modelChi, chidf)

## Chi is calculated by subtracting the null deviance by the residual deviance
## This shows us how much better the new model is than no model

## R-squared
R2.hl <- modelChi/eelModel.1$null.deviance

## Odds Ratios
## Larger than 1 means that as predictor increases, odds of the outcome also
## increase. Smaller than 1 means that as a predictor increases, odds of
## the outcome decreases
exp(eelModel.1$coefficients)

## Confidence Intervals for Odds Ratio
## Important that the conf int does not cross 1
exp(confint(eelModel.1))

## Model 2
glm(formula = Cured ~ Intervention + Duration, family = binomial(), dat = eelData)

modelChi <- eelModel.1$deviance - eelModel.2$deviance
chidf <- eelModel.1$df.residual - eelModel.2$df.residual
chisq.prob <- 1 - pchisq(modelChi, chidf)
modelChi; chidf; chisq.prob

## ANOVA
anova(eelModel.1, eelModel.2)

## If the significance of the chi-square statistic is less than .05, 
## then the model is a significant fit to the data.

## Casewise Diagnostics
write.table(eelData, "Eel With Diagnostics.dat", sep = "\t", row.names = FALSE)

eelData$predicted.probabilities<-fitted(eelModel.1) 
eelData$standardized.residuals<-rstandard(eelModel.1) 
eelData$studentized.residuals<-rstudent(eelModel.1) 
eelData$dfbeta<-dfbeta(eelModel.1) 
eelData$dffit<-dffits(eelModel.1)
eelData$leverage<-hatvalues(eelModel.1)

eelData[, c("leverage", "studentized.residuals", "dfbeta")]


## Penalty Data

penaltyData<-read.delim("data/penalty.dat", header = TRUE)

penaltyData$Scored <- as.factor(penaltyData$Scored)

penaltyModel.2 <- glm(Scored ~ Previous + PSWQ + Anxious, 
                      data = penaltyData, family = binomial())

## VIF

vif(penaltyModel.2)
1/vif(penaltyModel.2)

## Linearity

penaltyData$logPSWQInt <- log(penaltyData$PSWQ)*penaltyData$PSWQ
penaltyData$logAnxInt <- log(penaltyData$Anxious)*penaltyData$Anxious
penaltyData$logPrevInt <- log(penaltyData$Previous)*penaltyData$Previous

penaltyTest.1 <- glm(Scored ~ PSWQ + Anxious + Previous + logPSWQInt + 
                       logAnxInt + logPrevInt, data=penaltyData, 
                     family=binomial())
summary(penaltyTest.1)

## All variables have p-values over 0.5, so linearity has been met.

## Multinomial Regression

chatData<-read.delim("data/Chat-Up Lines.dat", header = TRUE)

chatData$Success <- as.factor(chatData$Success)
chatData$Gender <- as.factor(chatData$Gender)

chatData$Gender<-relevel(chatData$Gender, ref = 2)

## MLogit Conversion

newDataframe<-mlogit.data(oldDataFrame, choice = "outcome variable", 
                          shape = "wide"/"long")

mlChat <- mlogit.data(chatData, choice = "Success", shape = "wide")

## newModel<-mlogit(outcome ~ predictor(s), data = dataFrame, na.action = 
##                   an action, reflevel = a number representing the baseline 
##                 category for the outcome)


chatModel <- mlogit(Success ~ 1 | Good_Mate + Funny + Gender + Sex + Gender*Sex
                    + Funny*Gender, data = mlChat, reflevel = "No response/Walk Off")

summary(chatModel)
exp(chatModel$coefficients)

## Confidence Intervals
exp(confint(chatModel))

## American Community Survey

acs <- read.table("http://jaredlander.com/data/acs_ny.csv", sep=",", header=TRUE, stringsAsFactors=FALSE)

acs$Income <- with(acs, FamilyIncome >= 150000)

income1 <- glm(Income ~ HouseCosts + NumWorkers + OwnRent + NumBedrooms + FamilyType,
               data=acs, family=binomial(link="logit"))

summary(income1)

thoracicTest <- thoracicSurgeryX
thoracicTest$model_prob <- predict(thoracic_Model.1, thoracicTest, type = "response")
thoracicTest$model_predict <- thoracicTest$model_prob >= .5
thoracicTest$model_correct <- thoracicTest$model_predict == thoracicTest$Survival
model_accuracy <- sum(thoracicTest$model_correct)/nrow(thoracicTest)

model_accuracy
