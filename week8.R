library(boot); library(car)
library(Rcmdr)

setwd("/Users/alissa/Documents/Grad/DSC 520/dsc520")

album1 <- read.delim("data/Album Sales 1.dat", header = TRUE)

## Regression General Formula

newModel <- lm(outcome ~ predictors, data = dataFrame, na.action = action)

albumSales.1 <- lm(sales ~ adverts, data = album1)

summary(albumSales.1)

## Multiple R-squared means that advertising expenditure can account for 33.5%
## of the variation in album sales.

## p-value of 0.00000000000022 shows us that the possibility of the null,
## that this F-value happened by chance, is very slim
## It is a significant stat.

## y = mx + b
## y = adverts estimate(x) + intercept estimate
## y = 0.096124(x) + 134.139938