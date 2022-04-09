Exercise 4: Test Scores  
  
1. The observational units in this study are the students in the two different sections.  
2. The variables are:
    - The type of section, regular or sports focused (categorical)
    - Course grades (categorical)
    - Total points earned in the course (quantitative)
3. Created two varaibles: scoresSports and scoresRegular to hold the values for the students in each section.
```
scoresSports <- scores_df[scores_df$Section == "Sports", ]

scoresRegular <- scores_df[scores_df$Section == "Regular", ]
```
4. Comparing the scores of the 2 sections, with the sports section denoted by red points and the regular section denoted by blue points.
```
comparisonPlot <- plot(Count ~ Score, data = scoresSports, col = "maroon", pch = 19, 
  xlab = "Student's Score in Course", ylab = "Number of Students Attaining Score", ylim =  
  c(0,50)) +points(Count ~ Score, data = scoresRegular, col = "light blue", pch = 19) + 
  title("Student's Scores By Section")
legend("topleft", legend = c("Sports Section", "Regular Section"), col = c("maroon", "light blue"), lwd = 2)
```
![image](https://user-images.githubusercontent.com/95236375/162260944-8c4e4a97-5c1f-4a7a-b8d9-5756c873fe4e.png)
a. Looking at our graph, the distribtion of scores in the control section (the section with varied examples) has peak around a score of 350, while the bell-shaped distrubtion of scores in the sports-focused section peaks under a score of 300, discounting one outlier. The regular section seems to cluster farther right on the graph, insinuating that students tended to score higher when they took the course using a well-rounded selection of examples, rather than just sports-centric ones.   
  
b. It is not true that every student in the regular section did better than every student in the sports-focused section, just that the students in the regular section tended to do better on average. A statistical tendency for a student to have better performance in one section over the other would insinuate that a random sample of students, on average, would do better in that particular section than if they had been placed in the other section. It does not necessitate that every student in one section does better than every student in the other section, as there are many variables that differentiate the students within the samples from each other, such as how much they study or how much they enjoy the course.  
  
c. An additional variable that could be confounding the results is that there could be a difference in the type of students that chose the sports-related section rather than the regular version of the course. Since the students chose their own section, the samples were not random which could have influenced the results. It is possible that the type of student who would choose a sports-related section might have a different work ethic or have different priorities than a student who would choose the regular section.  
  
Data Transformations 
  
a. I will be utilizing this alcohol consumption dataset which denotes the number of servings of beer, spirits, and wine consumed by the average individual in each country in the year 2010.  
```
            country beer_servings spirit_servings wine_servings total_litres_of_pure_alcohol
1       Afghanistan             0               0             0                          0.0
2           Albania            89             132            54                          4.9
3           Algeria            25               0            14                          0.7
4           Andorra           245             138           312                         12.4
5            Angola           217              57            45                          5.9
6 Antigua & Barbuda           102             128            45                          4.9
```
I used the apply function in order to see what the average servings of alcohol were per person globally. This involed finding the mean of all of the surveyed countries.  
```
apply(alcoholConsumption[2:5], 2, mean)
```
This produced these results:  
```
               beer_servings              spirit_servings                wine_servings 
                  106.160622                    80.994819                    49.450777 
total_litres_of_pure_alcohol 
                    4.717098 
```
This output shows that the global average of beer servings is 106, the average number of spirit servings is 81, the average number of wine servings is 49, and the total average litres consumed per person is 4.7.  
  
b. I used the aggregate variable on the housing data provided. I specifically applied it to the sale price of homes and the average sale price, resulting in output that shows the average sale price for each zip code:
```
aggregate(sale_price ~ zip5, housing_df, mean)
```  
Which provides the output:  
```
     zip5 sale_price
1 98052     649375
2 98053     672624
3 98059     645000
4 98074     951544
```  
  
c. I used ddplyr to analyze the alcohol consumption dataset, adding a new variable to see whether a country preferred wine over beer. I called this new variable "prefer_wine".
```
prefer_wine <- ddply(alcoholConsumption, c("country"), summarise, prefer_wine = 
                  wine_servings > beer_servings)
```
This produced the following output including the new variable I have added:
```
            country prefer_wine
1       Afghanistan       FALSE
2           Albania       FALSE
3           Algeria       FALSE
4           Andorra        TRUE
5            Angola       FALSE
6 Antigua & Barbuda       FALSE
```
