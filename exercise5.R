library(stringr)

recentgrads_df <- read.csv("data/recent-grads.csv")

recentgrads_df %>% group_by(Major_category)

recentgrads_df %>% group_by(Major_category) %>% arrange(Major_category)

recentgrads_df %>% group_by(Major_category) %>% 
  summarize(Median_salary = mean(Median))

employment_Rates <- recentgrads_df %>% select(Major, Employed, Full_time, 
                    Part_time, Unemployed)

recentgrads_df %>% select(Major, Employed, Full_time, Part_time) %>% 
  mutate(Full_time/Employed)

fulltime_Percent <- recentgrads_df %>% select(Major, Employed, Full_time, Part_time) %>% 
  mutate(Fulltime_percent = Full_time/Employed)

female_Leaning <- recentgrads_df %>% select(Major, ShareWomen, Median) %>% filter(ShareWomen > 0.5)

recent_grads_trimmed <- recentgrads_df$ShareWomen %>% map(compact)

female_Leaning_List <- recent_grads_trimmed %>% keep(recentgrads_df$ShareWomen > 0.5)

recentgrads_df_Majors <- recentgrads_df$Majors

engineering_Majors <- keep(recentgrads_df$Major, str_detect(recentgrads_df$Major, "ENGINEER"))

str_detect(recentgrads_df$Major, "ENGINEER")

non_engineering_Majors <- discard(recentgrads_df$Major, str_detect(recentgrads_df$Major, "ENGINEER"))

recentgrads_df2 <- cbind(recentgrads_df, Fulltime_percent = fulltime_Percent$Fulltime_percent)

recentgrads_df2 %>% select(Major, Employed, Full_time, Part_time, Fulltime_percent)

housing_week_6_df <- read.csv("data/week-6-housing.csv")
housing_week_7_df <- read.csv("data/week-7-housing.csv")

multi_week_housing_df <- rbind(housing_week_6_df, housing_week_7_df)

multi_week_housing_df %>% select(sale_date, sale_price, addr_full, zip5)

split_Grads <- str_split(recentgrads_df2$Major, "AND")

grads_Ampersand <- str_replace_all(recentgrads_df$Major, "AND", "&")

