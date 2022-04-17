library(ggplot2)  
heights_df <- read.csv("data/r4ds/heights.csv")
covid_data_df <- read.csv("data/nytimes/covid-19-data/us-states.csv")
california_df <- filter(covid_data_df, state == "California")
florida_df <- filter(covid_data_df, state == "Florida")
ny_df <- filter(covid_data_df, state == "New York")

plot_California <- ggplot(california_df, aes(x=x, y=y)) + geom_point() + scale_y_continuous(trans='log10')
