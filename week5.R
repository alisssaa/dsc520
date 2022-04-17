library(ggplot2)
library(plyr)
library(dplyr)
library(magrittr)
library(dbplyr)
library(purrr)

diamonds %>% head(4) %>% dim

## Pipes
# These two functions are the same

select(diamonds, carat, price)
diamonds %>% select(carat, price)

## Do not select

diamonds %>% select(-carat, -price)

## Filter
## Specify rows by logical expression

diamonds %>% filter(cut =='Ideal')

## Filter more than one possible value

diamonds %>% filter(cut %in% c('Ideal', 'Good'))

diamonds %>% filter(carat > 2 & price < 14000)

## Slice
## Specify rows by row number

diamonds %>% slice(1:5)
diamonds %>% slice(c(1:5, 8, 15:20))

## Omit these rows

diamonds %>% slice(-1)

## Mutate
## Perform transformations
## With dplyr only as many columns that fit will be displayed

diamonds %>% select(carat, price) %>% mutate(price/carat)

## To name column

diamonds %>% select(carat, price) %>% mutate(Ratio=price/carat)

## Assignment pipe
## Pipe does not add variable to table
## The assignment pipe pipes the variable back to the original table

diamonds2 <- diamonds

diamonds2 %<>% select(carat, price) %>% mutate(Ratio=price/carat)

diamonds %>%
  summarize(AvgPrice=mean(price), 
            MedianPrice=median(price),
            AvgCarat=mean(carat))

diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice=mean(price))

## Arrange

diamonds %>%
  group_by(cut) %>%
  summarize(AvgPrice=mean(price), 
  SumCarat=sum(carat)) %>%
  arrange(AvgPrice)

## Do
## Use any function on your data

topN <- function(x, N=5)
  {
  x %>% arrange(desc(price)) %>% head(N) 
}

diamonds %>% group_by(cut) %>% do(topN(., N=3))

## PURRR

## Map
## This works the same as lapply
## Always returns lists, unless specified otherwise

theList <- list(A=matrix(1:9, 3), B=1:5, C=matrix(1:4, 2), D=2)
lapply(theList, sum)

theList %>% map(sum)

theList %>% map(sum, na.rm=TRUE)

## map_if
## only modifies elements if logical condition is true

## Only will double list item if it is in the form of a matrix

theList %>% map_if(is.matrix, function(x) x*2)

diamonds %>% map_dbl(mean)

## pmap & map2
## map2 takes 2 lists as arguments
## pmap can take any number

firstList <- list(A=matrix(1:16, 4), B=matrix(1:16, 2), C=1:5)
secondList <- list(A=matrix(1:16, 4), B=matrix(1:16, 8), C=15:1)

simpleFunc <- function(x, y)
{
  NROW(x) + NROW(y)
}

map2(firstList, secondList, simpleFunc)

pmap(list(firstList, secondList), simpleFunc)

