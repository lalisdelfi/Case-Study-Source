install.packages(c("tidyverse", "dplyr","skimr","ggplot2","lubridate"))

library(tidyverse)
library(skimr)
library(lubridate)
library(knitr)

glimpse(dailyActivity)
glimpse(dailyCalories) #this is in dailyActivity
glimpse(dailyIntensities)
glimpse(dailySteps) #this is in dailyActivity
glimpse(sleepDay) #this is in dailyActivity
glimpse(weightLog)

summary(dailyActivity)
summary(weightLog) # there were 65 NA calues
summary(weightLogInfo) # after cleaning NA values in sheets, I reuploaded
summary(dailyIntensities)

#check number of users in each dataset by ID
length(unique(dailyActivity$Id)) # 33
length(unique(weightLogInfo$Id)) # 8 !!
length(unique(dailyIntensities$Id)) # 33
length(unique(dailySteps$Id)) # 33
length(unique(sleepDay$Id)) # 24

#checking for duplicate IDs
dailyActivity[duplicated(dailyActivity),]
sleepDay[duplicated(sleepDay),] # three duplicated records, lets drop them
sleepDay <- dplyr::distinct(sleepDay)
dailyIntensities[duplicated(dailyIntensities),]
dailySteps[duplicated(dailySteps),]

#Is there a relationship between total steps / activity level and calories burned?
dailyActivity %>%
  ggplot() +
  aes(x = TotalSteps, y = Calories) +
  geom_point(shape = "circle", size = 1, colour = "#D8888B")
  labs(
    title = "Total Steps VS Calories",
  )

dailyActivity %>%
  ggplot() +
  aes(x = VeryActiveDistance, y = Calories) +
  geom_point(shape = "circle", size = 1, colour = "#D8888B")
labs(
  title = "Very Active Distance VS Calories",
  )

dailyActivity %>%
  ggplot() +
  aes(x = VeryActiveMinutes, y = Calories) +
  geom_point(shape = "circle", size = 1, colour = "#D8888B")
labs(
  title = "Very Active Minutes VS Calories",
)


dailyActivity %>%
  ggplot() +
  aes(x = FairlyActiveMinutes, y = Calories) +
  geom_point(shape = "circle", size = 1, colour = "#D8888B")
labs(
  title = "Fairly Active Minutes VS Calories",
)

dailyActivity %>%
  ggplot() +
  aes(x = LightlyActiveMinutes, y = Calories) +
  geom_point(shape = "circle", size = 1, colour = "#D8888B")
labs(
  title = "Lightly Active Minutes VS Calories",
)

dailyActivity %>%
  ggplot() +
  aes(x = SedentaryMinutes, y = Calories) +
  geom_point(shape = "circle", size = 1, colour = "#D8888B")
labs(
  title = "Sedentary Minutes VS Calories",
)

# Is there a trend between sleep and calories burned?
#before merging, i need to fix SleepDay to match the columns in dailyActivity
library(setnames)
setnames(sleepDay, "SleepDay", "ActivityDate")
dailyActivitySleep <- merge(dailyActivity, sleepDay, by=c("Id", "ActivityDate"))

dailyActivitySleep %>%
  ggplot() +
  aes(x = TotalMinutesAsleep, y = TotalSteps) +
  geom_point(shape = "circle", size = 1, color = "blue")+
  geom_vline(xintercept=420, linetype = "dashed", size=0.5, color = "black") +
labs(
  title = "Total Minutes Asleep VS Total Steps",
)


dailyActivitySleep %>%
  ggplot() +
  aes(x = TotalMinutesAsleep, y = Calories) +
  geom_point(shape = "circle", size = 1, color = "blue")+
  geom_vline(xintercept=420, linetype = "dashed", size=0.5, color = "black") +
  labs(
    title = "Total Minutes Asleep VS Total Calories",
  )
install.packages("rmarkdown")
library(rmarkdown)
