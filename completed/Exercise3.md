i.	The elements in this set of data are:
-	Id (nominal)
-	Id2 (nominal)
-	Geography (nominal)
-	PopGroupID (nominal)
-	POPGROUP.display-label (nominal)
-	RacesReported (ratio)
-	HSDegree (ratio)
-	BachDegree (ratio)

ii.	str()
```
'data.frame':	136 obs. of  8 variables:
 $ Id                    : chr  "0500000US01073" "0500000US04013" "0500000US04019" "0500000US06001" ...
 $ Id2                   : int  1073 4013 4019 6001 6013 6019 6029 6037 6059 6065 ...
 $ Geography             : chr  "Jefferson County, Alabama" "Maricopa County, Arizona" "Pima County, Arizona" "Alameda County, California" ...
 $ PopGroupID            : int  1 1 1 1 1 1 1 1 1 1 ...
 $ POPGROUP.display.label: chr  "Total population" "Total population" "Total population" "Total population" ...
 $ RacesReported         : int  660793 4087191 1004516 1610921 1111339 965974 874589 10116705 3145515 2329271 ...
 $ HSDegree              : num  89.1 86.8 88 86.9 88.8 73.6 74.5 77.5 84.6 80.6 ...
 $ BachDegree            : num  30.5 30.2 30.8 42.8 39.7 19.7 15.4 30.3 38 20.7 ...
 ```

  nrow()  
  136
  
  ncol()  
  8
  
iii.	
```
censusData <- read.csv("data/acs-14-1yr-s0201.csv", header = TRUE)
```
```
censusHistogram <- ggplot(censusData, aes(HSDegree)) + geom_histogram(bins = 100) +   
xlab("% of Adults With High School Degree Per County") + ylab("Number of Counties With Given Percentage of HS Completion")
```

![censusHistogram](https://user-images.githubusercontent.com/95236375/161357925-a9e6c7c0-001f-4d82-9374-b65571489776.jpg)

 
iv.	    
1. Yes, the distribution is unimodal. There is one distinct peak around 90% high school       completion.  
2.  It is not approximately symmetrical. The tail is much longer on the left hand side, meaning it has negative skew.  
3. It has a general bell shape centered around the 90% mark, however, the left tail is much longer.  
4. It is not approximately normal, due to the skew mentioned earlier.
5. Yes, the distribution is skewed negatively. The tail to the left is much longer due to the fact that the peak is around 90% and there is no possibility of any county having higher than a 100% degree completion.
6. 
```
censusHistogramScaled <- ggplot(censusData, aes(HSDegree)) + geom_histogram(bins = 100, aes(y=..density..)) +   
ggtitle("Rates of High School Completion Per County") + xlab("% of Adults With High School Degree") + 
ylab("Percentage of Counties With \n Given Percentage of HS Completion")
```
```
censusHistogramNormalDist < - censusHistogramScaled + stat_function(fun = dnorm, args =   
list(mean = mean(censusData$HSDegree, na.rm = TRUE), sd = sd(censusData$HSDegree, na.rm = TRUE)),   
colour = "black", size = 1)
```

![censusHistogramNormalDist](https://user-images.githubusercontent.com/95236375/161367589-3b651744-0bed-4bfa-953c-450c6e3b9372.jpg)
 7. The normal distribution is not an accurate representation for this model due to the nature of the high school completion data. The peak is roughly at 90% which would require, in order to be symmetrical, a tail that extended far past the 100% limit. There is no way for a county to have more than 100% of high school degree completion, so the distribution hits a wall there. The peak is also much higher than would be predicted by a normal distribution.

v.

```
probabilityPlot <- ggplot(censusData, aes(sample = HSDegree)) + stat_qq_point(size = 1) + 
  stat_qq_line(color="violet") + ggtitle("Comparison Between HS Degree Measurement
  Distribution And the Normal Distribution") + xlab("") + ylab("")
```

![ProbabilityPlot](https://user-images.githubusercontent.com/95236375/161396402-7c0a7007-25e6-4728-a932-f35d0fe6164e.jpg)

vi. 
1. The distribution is not approximately normal. The purple line shows the plot of a normal distribution using the HS Degree data, while the black plot points show the actual distribution. The curve does not follow the line particularly well.
2. The distrubution has a significant left-skew, evidenced by the curve of the line on the probability plot opening downwards. This indicates that the data has a very long tail to the left, which is true due to the HSDegree variable peaking around 90%.

vii. 
```
stat.desc(censusData$HSDegree)
```
```
     nbr.val     nbr.null       nbr.na          min          max        range 
     136.000        0.000        0.000       62.200       95.500       33.300 
         sum       median         mean      SE.mean CI.mean.0.95          var 
   11918.000       88.700       87.632        0.439        0.868       26.193 
     std.dev     coef.var 
       5.118        0.058 
```
