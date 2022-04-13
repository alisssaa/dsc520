This assignment was completed using the College Major dataset provided by 538 here:  
https://github.com/fivethirtyeight/data/blob/master/college-majors/recent-grads.csv  
  
a. dplyr Operations  
  
**group_by**  
The data set includes the median salary for each major listed. I used the group_by function 
to find the median salary of each major category (engineering, arts, etc.)  
```
recentgrads_df %>% group_by(Major_category) %>% 
  summarize(Median_salary = mean(Median))
```
```
   Major_category                      Median_salary
   <chr>                                       <dbl>
 1 Agriculture & Natural Resources            36900 
 2 Arts                                       33062.
 3 Biology & Life Science                     36421.
 4 Business                                   43538.
 5 Communications & Journalism                34500 
 6 Computers & Mathematics                    42745.
 7 Education                                  32350 
 8 Engineering                                57383.
 9 Health                                     36825 
10 Humanities & Liberal Arts                  31913.
11 Industrial Arts & Consumer Services        36343.
12 Interdisciplinary                          35000 
13 Law & Public Policy                        42200 
14 Physical Sciences                          41890 
15 Psychology & Social Work                   30100 
16 Social Science                             37344.
```
