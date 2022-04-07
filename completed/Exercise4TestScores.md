Exercise 4: Test Scores  
  
i.
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
a. Looking at our graph, the distribtion of scores in the section with well-rounded examples has peak around 350, while the bell-shaped distrubtion of scores in the sports-focused section peaks under a score of 300, discounting one outlier. The regular section seems to cluster farther right on the graph, insinuating that students tended to score higher when they took the course using various examples, rather than just sports-centric ones. You cannot say that every student in the regular section did better than every studet in the sports-focused section, just that the students in the regular section tended to do better on average.
