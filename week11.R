setwd("/Users/alissa/Documents/Grad/DSC 520/dsc520")

load("data/wifi.rdata")

head(wifi)

ggplot(wifi, aes(x=x, y=y, color=Distance)) + geom_point() +
  scale_color_gradient2(low="blue", mid="white", high="red",
                        midpoint=mean(wifi$Distance))

wifiMod1 <- nls(Distance ~ sqrt((betaX - x)^2 + (betaY - y)^2), 
                data=wifi, start=list(betaX=50, betaY=50))


## Credit Data> 
theURL = "http://archive.ics.uci.edu/ml/ machine-learning-databases/statlog/german/german.data"
credit <- read.table(theURL, sep=" ", header=FALSE, col.names=creditNames, stringsAsFactors=FALSE)

creditNames <- c("Checking", "Duration", "CreditHistory", "Purpose", 
                 "CreditAmount", "Savings", "Employment",
                 "InstallmentRate", "GenderMarital", "OtherDebtors",
                 "YearsAtResidence", "RealEstate", "Age",
                 "OtherInstallment", "Housing", "ExistingCredits",
                 "Job", "NumLiable", "Phone", "Foreign", "Credit")

creditHistory <- c(A30 ="All Paid", A41 = "All Paid This Bank", A32 = "Up To Date",
                   A33 = "Late Payment", A34="Critical Account")

purpose <- c(A40 = "car (new)", A41 = "car (used", A42 = "furniture/equipment",
             A43 = "radio/television", A44 = "domestic appliances", A45 = "repairs",
             A46= "education", A47 = "vacation", A48 = "retraining", A49 = "business",
             A410 = "others")

employment <- c(A71 = "unemployed", A72 = "< 1 year", A73 = "1 - 4 years",
                A74 = "4 - 7 years", A75 = ">= 7 years")

credit$CreditHistory <- creditHistory[credit$CreditHistory]
credit$Purpose <- Purpose[credit$Purpose]
credit$Employment <- Employment[credit$Employment]

credit$Credit <- ifelse(credit$Credit == 1, "Good", "Bad")
credit$Credit <- factor(credit$Credit, levels=c("Good", "Bad"))

### Time Series

library(WDI); library(ggplot2); library(scales)
library(forecast); library(reshape); library(maditr)
library(vars); library(quantmod)

gdp <- WDI(country = c("US", "CA", "GB", "DE", "CN", "JP", "SG", "IL"),
           indicator = c("NY.GDP.PCAP.CD", "NY.GDP.MKTP.CD"),
           start = 1960, end = 2011)

names(gdp) <- c("iso2c", "Country", "Year", "PerCapGDP", "GDP")

us <- gdp$PerCapGDP[gdp$Country == "United States"]
us <- ts(us, start=min(gdp$Year), end=max(gdp$Year))

## tells us how many diff we should use

ndiffs(x=us)
plot(diff(us,2))

## ARIMA model

usBest <- auto.arima(x=us)

## ACF & PCF within dotted lines denote good model

acf(usBest$residuals)
pacf(usBest$residuals)

coef(usBest)

predict(usBest, n.ahead=5, se.fit=TRUE)

## Plot predicted forecast

usForecast <- forecast(object=usBest, h=5)
plot(usForecast)

gdp2 <- gdp[, c("Country", "Year", "PerCapGDP")]
gdpTS <- gdpTS[, which(colnames(gdpTS) != "Germany")]

gdpCast <- dcast(gdp$Year ~ gdp$Country, data=setDT(gdp2), value.var="PerCapGDP")

pivot_wider(data = gdp, )

gdpTS <- ts(data=gdpCast[, -1], start=min(gdpCast$Year), + end=max(gdpCast$Year))

gdpDiffed <- diff(gdpTS, differences = 1)

### GARCH for handling extreme events and high volatility

load("data/att.rdata")

### Clustering

wineUrl <- 'http://archive.ics.uci.edu/ml/ machine-learning-databases/wine/wine.data'

wine <- read.csv("data/wine.data")
names(wine) <- c('Cultivar', 'Alcohol', 'Malic.acid', 
                               'Ash', 'Alcalinity.of.ash', 'Magnesium', 
                               'Total.phenols', 'Flavanoids', 
                               'Nonflavanoid.phenols', 'Proanthocyanin', 
                               'Color.intensity', 'Hue', 
                               'OD280.OD315.of.diluted.wines', 'Proline')

wineTrain <- wine[, which(names(wine) != "Cultivar")]

set.seed(278613)
wineK3 <- kmeans(x=wineTrain, centers=3)

library(useful)
plot(wineK3, data=wineTrain)

wineK3N25 <- kmeans(wineTrain, centers=3, nstart=25)

wineBest <- FitKMeans(wineTrain, max.clusters=20, nstart=25, seed=278613)

table(wine$Cultivar, wineK3N25$cluster)

plot(table(wine$Cultivar, wineK3N25$cluster), 
     main="Confusion Matrix for Wine Clustering", 
     xlab="Cultivar", ylab="Cluster")


**Binary Classifier K-Means Clustering**
  
  ```{r}
binaryK3 <- kmeans(x=binary_df, centers=3)
binaryK5 <- kmeans(x=binary_df, centers=5)
binaryK10 <- kmeans(x=binary_df, centers=10)
binaryK15 <- kmeans(x=binary_df, centers=15)
binaryK20 <- kmeans(x=binary_df, centers=20)
binaryK25 <- kmeans(x=binary_df, centers=25)

binaryX <- c(3, 5, 10, 15, 20, 25)
binaryY <- c(binaryK3$tot.withinss,
             binaryK5$tot.withinss,
             binaryK10$tot.withinss,
             binaryK15$tot.withinss,
             binaryK20$tot.withinss,
             binaryK25$tot.withinss)

binaryKWSS <- data.frame(binaryX, binaryY)

ggplot(binaryKWSS, aes(x=binaryX, y=binaryY)) + geom_line() + xlab("Number of Clusters (K)") + ylab("Total WSS")
```

**Trinary Classifier K-Means Clustering**
  
  ```{r}
trinaryK3 <- kmeans(x=trinary_df, centers=3)
trinaryK5 <- kmeans(x=trinary_df, centers=5)
trinaryK10 <- kmeans(x=trinary_df, centers=10)
trinaryK15 <- kmeans(x=trinary_df, centers=15)
trinaryK20 <- kmeans(x=trinary_df, centers=20)
trinaryK25 <- kmeans(x=trinary_df, centers=25)

trinaryX <- c(3, 5, 10, 15, 20, 25)
trinaryY <- c(trinaryK3$tot.withinss,
              trinaryK5$tot.withinss,
              trinaryK10$tot.withinss,
              trinaryK15$tot.withinss,
              trinaryK20$tot.withinss,
              trinaryK25$tot.withinss)

trinaryKWSS <- data.frame(trinaryX, trinaryY)

ggplot(trinaryKWSS, aes(x=trinaryX, y=trinaryY)) + geom_line() + xlab("Number of Clusters (K)") + ylab("Total WSS")
```