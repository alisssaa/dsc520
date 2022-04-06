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
