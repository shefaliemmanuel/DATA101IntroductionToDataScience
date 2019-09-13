#Shefali Emmanuel
#September 11, 2019
#Data 101 HW3 Data Transformation

#import tidyverse and nyc flights
library(tidyverse)
library(nycflights13)
library(dplyr)

#Had an arrival delay of two or more hours
filter(flights, arr_delay>=120)

#Flew to Houston (IAH or HOU)
filter(flights, dest== "IAH" | dest == "HOU")

#Were operated by United, American, or Delta
filter(flights, carrier %in% c('UA', 'AA', 'DL'))

#Departed in summer (July, August, and September)
filter(flights, month >= 7 & month <=9)
#another way to do the same thing
filter(flights, month %in% c(7, 8, 9))

#Arrived more than two hours late, but didn’t leave late
filter(flights, arr_delay >= 120 & dep_delay <= 0)

#Were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, arr_delay >= 60 & dep_delay-arr_delay > 30)

#Departed between midnight and 6am (inclusive)
filter(flights, dep_time <=0600 | dep_time == 2400)

#2. Another useful dplyr filtering helper is between(). What does it do? Can you use it to simplify the code needed to answer the previous challenges?
#The function lets you compare x values between left and right parameter boundries
#between(x, left, right)
#This could be applied with the flight question involving months and .
filter(flights, between(month, 7, 9))
filter(flights, between(dep_time, 600, 2400))
filter(flights, !between(dep_time, 601, 2359))

#Sort flights to find the most delayed flights. 
arrange(flights, dep_delay)
#Find the flights that left earliest.
arrange(flights, desc(dep_delay))
