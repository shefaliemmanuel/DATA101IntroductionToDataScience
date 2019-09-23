#Shefali Emmanuel
#Data Science 101 HW6
#September 18, 2019

install.packages("nycflights13")
install.packages("tidyverse")

library(nycflights13)
library(tidyverse)

nycflights13::flights

#5.5.2.4
#Find the 10 most delayed flights using a ranking function. 
#How do you want to handle ties? Carefully read the documentation for min_rank()

filter(flights, min_rank(desc(dep_delay))<=10)
# or 
flights %>% top_n(n = 10, wt = dep_delay)

#min_rank() is the most usual type of ranking (e.g. 1st, 2nd, 2nd, 4th)
#default gives smallest values the small ranks; use desc(x) to give the largest values the smallest ranks.
#is the same thing as rank(ties.method = "min")
#reference: https://dplyr.tidyverse.org/reference/ranking.html

#5.6.7.5
#Brainstorm at least 5 different ways to assess the typical delay characteristics of a group of flights. 
#Consider the following scenarios:
typical_flight_delays <- flights %>% filter(!is.na(dep_delay), !is.na(arr_delay)) %>% group_by(flight) %>% summarise(n = n(),
                                                                    fifteen_mins_early = mean(arr_delay == -15, na.rm = T),
                                                                    fifteen_mins_late = mean(arr_delay == 15, na.rm = T),
                                                                    ten_mins_late = mean(arr_delay == 10, na.rm = T),
                                                                    thirty_mins_early = mean(arr_delay == -30, na.rm = T),
                                                                    thirty_mins_late = mean(arr_delay == 30, na.rm = T),
                                                                    perfect = mean(arr_delay == 0, na.rm = T),
                                                                    two_hours_late = mean(arr_delay > 120, na.rm = T))
typical_flight_delays

#A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.
fifteen_50 <- typical_flight_delays %>% filter(fifteen_mins_early == 0.5, fifteen_mins_late == 0.5)
fifteen_50
# or 
typical_flight_delays %>% filter(fifteen_mins_early == 0.5 | fifteen_mins_late == 0.5)

#A flight is always 10 minutes late.
typical_ten_min_delay <- typical_flight_delays %>% filter(ten_mins_late == 1)
typical_ten_min_delay

#A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
thirty_50 <- typical_flight_delays %>% filter(thirty_mins_early == 0.5 & thirty_mins_early == 0.5)
thirty_50
# or 
typical_flight_delays %>% filter(thirty_mins_early == 0.5 | thirty_mins_early == 0.5)

#99% of the time a flight is on time. 1% of the time it’s 2 hours late.
onT_or_2HRLate <- typical_flight_delays %>% filter(perfect == 0.99 & two_hours_late == 0.01)
onT_or_2HRLate
#or
typical_flight_delays %>% filter(perfect == 0.99 && two_hours_late == 0.01)

#Which is more important: arrival delay or departure delay?
#Arrival delay is most important because if it was departure delay, the flight would have time to make up for the difference while in the air
#Also with departure delay, the customer is able to nofity any post flight requirements of their current flight status till take off

#5.7.1.2
#Which plane (tailnum) has the worst on-time record?

flights %>%
  group_by(tailnum) %>% #group by talinum
  filter(all(is.na(arr_delay))) %>% #is.na determines if a value is missing, in this case there are 7 values missing
  tally(sort=TRUE) # sort output in descending order of n

# I would not say 1 plan has the worst on-time record since 7 did not even show up. I would say these 7 all equally have the worst time on record.

