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
'data.frame':	136 obs. of  8 variables:
 $ Id                    : chr  "0500000US01073" "0500000US04013" "0500000US04019" "0500000US06001" ...
 $ Id2                   : int  1073 4013 4019 6001 6013 6019 6029 6037 6059 6065 ...
 $ Geography             : chr  "Jefferson County, Alabama" "Maricopa County, Arizona" "Pima County, Arizona" "Alameda County, California" ...
 $ PopGroupID            : int  1 1 1 1 1 1 1 1 1 1 ...
 $ POPGROUP.display.label: chr  "Total population" "Total population" "Total population" "Total population" ...
 $ RacesReported         : int  660793 4087191 1004516 1610921 1111339 965974 874589 10116705 3145515 2329271 ...
 $ HSDegree              : num  89.1 86.8 88 86.9 88.8 73.6 74.5 77.5 84.6 80.6 ...
 $ BachDegree            : num  30.5 30.2 30.8 42.8 39.7 19.7 15.4 30.3 38 20.7 ...

  nrow()
  136
  
  ncol()
  8
  
iii.	censusData <- read.csv("data/acs-14-1yr-s0201.csv", header = TRUE)

     censusHistogram <- ggplot(censusData, aes(HSDegree)) + geom_histogram(bins = 100) + xlab("% of Adults With High School Degree Per County") + ylab("Number of Counties With Given Percentage of HS Completion")
      
![censusHistogram](https://user-images.githubusercontent.com/95236375/161357925-a9e6c7c0-001f-4d82-9374-b65571489776.jpg)

 
iv.	  1. Yes, the distribution is unimodal. There is one distinct peak around 90% high school completion.
      2.  It is not approximately symmetrical. The tail is much longer on the left hand side, meaning it has negative skew.
      3. It has a general bell shape centered around the 90% mark, however, the left tail is much longer.
      4. It is not approximately normal, due to the skew mentioned earlier.
      5. Yes, the distribution is skewed negatively. The tail to the left is much longer due to the fact that the peak is around 90% and there is no possibility of any county having higher than a 100% degree completion.
      6. censusHistogramScaled <- ggplot(censusData, aes(HSDegree)) + geom_histogram(bins = 100, aes(y=..density..)) + ggtitle("Rates of High School Completion Per County") + xlab("% of Adults With High School Degree") + ylab("Percentage of Counties With \n Given Percentage of HS Completion")

         censusHistogramNormalDist < - censusHistogramScaled + stat_function(fun = dnorm, args = list(mean = mean(censusData$HSDegree, na.rm = TRUE), sd = sd(censusData$HSDegree, na.rm = TRUE)), colour = "black", size = 1)
