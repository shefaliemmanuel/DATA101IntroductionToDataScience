#Shefali Emmanuel
#Data Science 101 HW6
#September 18, 2019

install.packages("nycflights13")
install.packages("tidyverse")

library(nycflights13)
library(tidyverse)

stats::filter()
stats::lag()

#5.5.2.4
#Find the 10 most delayed flights using a ranking function. 
#How do you want to handle ties? Carefully read the documentation for min_rank()

filter(flights, min_rank(desc(dep_delay))<=10)
# or 
flights %>% top_n(n = 10, wt = dep_delay)

#5.6.7.5
#Brainstorm at least 5 different ways to assess the typical delay characteristics of a group of flights. 
#Consider the following scenarios:
#A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.
#A flight is always 10 minutes late.
#A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
#99% of the time a flight is on time. 1% of the time it’s 2 hours late.
#Which is more important: arrival delay or departure delay?

flight_delay_summary <- group_by(flights, flight) %>% summarise(num_flights = n(),
                                                                fifteen_mins_early = sum(sched_arr_time - arr_time == 15)/num_flights,
                                                                fifteen_mins_late = sum(arr_time - sched_arr_time == 15)/num_flights,
                                                                late = sum(arr_time > sched_arr_time)/num_flights,
                                                                early = sum(arr_time < sched_arr_time)/num_flights, 
                                                                on_time = sum(arr_time == sched_arr_time)/num_flights,
                                                                two_hours_late = sum(arr_time - sched_arr_time == 120)/num_flights)
flight_delay_summary

#Arrival delay is most important

#5.7.1.2
#Which plane (tailnum) has the worst on-time record?
flights %>%
  group_by(tailnum) %>%
  filter(all(is.na(arr_delay))) %>%
  tally(sort=TRUE)

