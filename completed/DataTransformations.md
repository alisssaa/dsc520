This assignment was completed using the College Major dataset provided by 538 here:  
https://github.com/fivethirtyeight/data/blob/master/college-majors/recent-grads.csv  
  
a. dplyr Operations  
  
**group_by**  
This data set demonstrates data for many individual majors, but each major is also classified in a more broad "major group" (engineering, arts, etc.) I used the group_by function to group the data by the major category.  
```
recentgrads_df %>% group_by(Major_category)
```
```
# Groups:   Major_category [16]
    Rank Major_code Major    Total   Men Women Major_category ShareWomen Sample_size
   <int>      <int> <chr>    <int> <int> <int> <chr>               <dbl>       <int>
 1     1       2419 PETROLE…  2339  2057   282 Engineering         0.121          36
 2     2       2416 MINING …   756   679    77 Engineering         0.102           7
 3     3       2415 METALLU…   856   725   131 Engineering         0.153           3
 4     4       2417 NAVAL A…  1258  1123   135 Engineering         0.107          16
 5     5       2405 CHEMICA… 32260 21239 11021 Engineering         0.342         289
 6     6       2418 NUCLEAR…  2573  2200   373 Engineering         0.145          17
 7     7       6202 ACTUARI…  3777  2110  1667 Business            0.441          51
 8     8       5001 ASTRONO…  1792   832   960 Physical Scie…      0.536          10
 9     9       2414 MECHANI… 91227 80320 10907 Engineering         0.120        1029
10    10       2408 ELECTRI… 81527 65511 16016 Engineering         0.196         631
```  
  
**arrange**  
Now that our data is grouped, we can arrange it based on our Major Category groups.  
```
recentgrads_df %>% group_by(Major_category) %>% arrange(Major_category)
```
```
# Groups:   Major_category [16]
    Rank Major_code Major    Total   Men Women Major_category ShareWomen Sample_size
   <int>      <int> <chr>    <int> <int> <int> <chr>               <dbl>       <int>
 1    22       1104 FOOD SC…    NA    NA    NA Agriculture &…     NA              36
 2    64       1101 AGRICUL… 14240  9658  4582 Agriculture &…      0.322         273
 3    65       1100 GENERAL… 10399  6053  4346 Agriculture &…      0.418         158
 4    72       1102 AGRICUL…  2439  1749   690 Agriculture &…      0.283          44
 5   108       1303 NATURAL… 13773  8617  5156 Agriculture &…      0.374         152
 6   112       1302 FORESTRY  3607  3156   451 Agriculture &…      0.125          48
 7   113       1106 SOIL SC…   685   476   209 Agriculture &…      0.305           4
 8   144       1105 PLANT S…  7416  4897  2519 Agriculture &…      0.340         110
 9   153       1103 ANIMAL … 21573  5347 16226 Agriculture &…      0.752         255
10   162       1199 MISCELL…  1488   404  1084 Agriculture &…      0.728          24
```  

**summarize**
By combining the group_by and summarize functions, we are able to calculate the median salary for the group of majors using the provided median salaries for the individual majors.
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

**select**  
Now we are going to take a closer look at employment rates. I used the select function to choose to only see the variables Employed, Full_time, Part_time, and Unemployed.  
```
recentgrads_df %>% select(Major, Employed, Full_time, Part_time, Unemployed)
```
```
                                      Major Employed Full_time Part_time Unemployed
1                     PETROLEUM ENGINEERING     1976      1849       270         37
2            MINING AND MINERAL ENGINEERING      640       556       170         85
3                 METALLURGICAL ENGINEERING      648       558       133         16
4 NAVAL ARCHITECTURE AND MARINE ENGINEERING      758      1069       150         40
5                      CHEMICAL ENGINEERING    25694     23170      5180       1672
6                       NUCLEAR ENGINEERING     1857      2038       264        400
```  

**mutate**  
Using this selection of information, I am going to compute, out of the number of students that found work in their field, the number of students who are currently working full-time jobs in that field of work.
```
fulltime_Percent <- recentgrads_df %>% select(Major, Employed, Full_time, Part_time) %>% 
  mutate(Fulltime_percent = Full_time/Employed)
```
```
                                      Major Employed Full_time Part_time Fulltime_percent
1                     PETROLEUM ENGINEERING     1976      1849       270        0.9357287
2            MINING AND MINERAL ENGINEERING      640       556       170        0.8687500
3                 METALLURGICAL ENGINEERING      648       558       133        0.8611111
4 NAVAL ARCHITECTURE AND MARINE ENGINEERING      758      1069       150        1.4102902
5                      CHEMICAL ENGINEERING    25694     23170      5180        0.9017669
6                       NUCLEAR ENGINEERING     1857      2038       264        1.0974690
```  

**filter**
I utilized the filter function in order to filter the data to display majors where women were in the majority of graduates.
```
female_Leaning <- recentgrads_df %>% select(Major, ShareWomen, Median) %>% filter(ShareWomen > 0.5)
```
```
                                                       Major ShareWomen Median
1                                 ASTRONOMY AND ASTROPHYSICS  0.5357143  62000
2                                              PUBLIC POLICY  0.5585480  50000
3                                                    NURSING  0.8960190  48000
4 NUCLEAR, INDUSTRIAL RADIOLOGY, AND BIOLOGICAL TECHNOLOGIES  0.7504726  46000
5                                                 ACCOUNTING  0.5241526  45000
6                           MEDICAL TECHNOLOGIES TECHNICIANS  0.7539274  45000
```  
  
b. purrr  
  
**keep**  
Using the keep function, I applied it to the list of majors, opting to only keep the ones that have "engineer" in the name.
```
engineering_Majors <- keep(recentgrads_df$Major, str_detect(recentgrads_df$Major, "ENGINEER"))
```
This provides a list of all of the majors that fall under engineering, providing an alternative to filtering the majors by major category.  
```
[1] "PETROLEUM ENGINEERING"                    
[2] "MINING AND MINERAL ENGINEERING"           
[3] "METALLURGICAL ENGINEERING"                
[4] "NAVAL ARCHITECTURE AND MARINE ENGINEERING"
[5] "CHEMICAL ENGINEERING"                     
[6] "NUCLEAR ENGINEERING" 
```  
  
**discard**  
Using the discard function, I performed the opposite operation and discarded all of the engineering majors. This provides a list of non-engineering fields.
```
non_engineering_Majors <- discard(recentgrads_df$Major, str_detect(recentgrads_df$Major, "ENGINEER"))
```
The output for this variable looks like this:  
```
[1] "ACTUARIAL SCIENCE"          "ASTRONOMY AND ASTROPHYSICS"
[3] "MATERIALS SCIENCE"          "COURT REPORTING"           
[5] "COMPUTER SCIENCE"           "FOOD SCIENCE"   
```
  
c. cbind/rbind  
  
**cbind**  
Using the cbind function, I added the Fulltime_percent column that I had created earlier to the main data frame.  
```
recentgrads_df2 <- cbind(recentgrads_df, Fulltime_percent = fulltime_Percent$Fulltime_percent)
```
```
                                      Major Employed Full_time Part_time Fulltime_percent
1                     PETROLEUM ENGINEERING     1976      1849       270        0.9357287
2            MINING AND MINERAL ENGINEERING      640       556       170        0.8687500
3                 METALLURGICAL ENGINEERING      648       558       133        0.8611111
4 NAVAL ARCHITECTURE AND MARINE ENGINEERING      758      1069       150        1.4102902
5                      CHEMICAL ENGINEERING    25694     23170      5180        0.9017669
6                       NUCLEAR ENGINEERING     1857      2038       264        1.0974690
```   
  
**rbind**
Since there was no additional data to add to this particular data frame, I instead switched over to the housing datasets for this particular function. I used the rbind function to bind the week 6 housing data with the week 7 housing data to create a single set of data.  
```
multi_week_housing_df <- rbind(housing_week_6_df, housing_week_7_df)
```
```
  sale_date sale_price          addr_full  zip5
1    1/3/06     698000  17021 NE 113TH CT 98052
2    1/3/06     649990  11927 178TH PL NE 98052
3    1/3/06     572500 13315 174TH AVE NE 98052
4    1/3/06     420000  3303 178TH AVE NE 98052
5    1/3/06     369900  16126 NE 108TH CT 98052
6    1/3/06     184667   8101 229TH DR NE 98053
```  
  
d. stringr  
  
**str_split**  
I used the split function to split the name of the majors that have an "and" contained in them into two separate words.  
```
str_split(recentgrads_df2$Major, "AND")
```
```
[[1]]
[1] "PETROLEUM ENGINEERING"

[[2]]
[1] "MINING "              " MINERAL ENGINEERING"

[[3]]
[1] "METALLURGICAL ENGINEERING"

[[4]]
[1] "NAVAL ARCHITECTURE " " MARINE ENGINEERING"

[[5]]
[1] "CHEMICAL ENGINEERING"

[[6]]
[1] "NUCLEAR ENGINEERING"
```  
  
**str_flatten**
