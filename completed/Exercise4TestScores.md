Exercise 4: Test Scores  
  
1. The observational units in this study are the students in the two difference sections.  
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
  
Data Transformations based on Housing dataset  
  
a. <hold>  
  
b. Used the aggregate variable on the sale price of homes and the average sale price, resulting in output that shows the average sale price for each zip code:
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
