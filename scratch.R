alcoholConsumption <- read.csv("data/alcohol-consumption.csv", header = TRUE)

preferWine <- function(data)
{
  c(preferWine=with(alcoholConsumption, wine_servings - beer_servings))
}

prefer_wine <- ddply(alcoholConsumption, c("country"), summarise, prefer_wine = 
                  wine_servings > beer_servings)

apply(alcoholConsumption[2:5], 2, mean)

alcoholHistogram <- 
  ggplot(alcoholConsumption, aes(total_litres_of_pure_alcohol)) + geom_histogram(bins = 30) +
  ggtitle("Average Liters of Alcohol Consumed Per Capita") + xlab("Liters Consumed") +
  ylab("Number of Countries Reporting Alcohol Usage")

probabilityPlot <- ggplot(alcoholConsumption, aes(sample = total_litres_of_pure_alcohol)) +
  stat_qq_point(size = 1) + stat_qq_line(color="violet") + 
  ggtitle("") + xlab("") + ylab("")

ggsave("alcoholConsumed.jpg")

library(pastecs)

prefer_wine_var <- prefer_wine["prefer_wine"]

alcoholConsumption$prefer_wine = prefer_wine_var
alcoholConsumption$higher_than_average_consumption = higher_consumption_var

higherConsumption <- function(data)
{
  c(higherConsumption=with(alcoholConsumption, total_litres_of_pure_alcohol > 4.7170984))
}

higherConsumption <- ddply(alcoholConsumption, c("country"), summarise, higher_consumption = 
                             total_litres_of_pure_alcohol > 4.7170984)

higher_consumption_var <- higherConsumption["higher_consumption"]
