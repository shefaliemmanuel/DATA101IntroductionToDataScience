# Data Science in Action
# Shefali's Example
# R part

library(dplyr)
library(dbplyr)

#create acc table
acc.uid1 <- c(1, 4, 3, 6)
acc.name <- c("Sam", "Leo", "Steph", "Manana")
acc <- data.frame(acc.uid1, acc.name)
str(acc)

#create fact table
fact.uid2 <- c(4, 4, 3, 2)
fact.fid <- c(1,2,4,1)
fact <- data.frame(fact.uid2,fact.fid)
str(fact)

#create fly table
fly.fid <- c(1,2,3,4)
fly.orig <- c("LA","LA","SF","SD")
fly.dest <- c("SF","SF","MN","NY")

fly.orig <- as.character(fly.orig)
fly.dest <- as.character(fly.dest)
fly.price <- c(110,90,240,370)
fly <- data.frame(fly.fid, fly.orig,fly.dest,fly.price)
str(fly)


# Flatten the Database
allTables <- data.frame(acc.uid1, acc.name,fact.uid2,fact.fid,
                        fly.fid, fly.orig,fly.dest,fly.price)

# Question 1
# Find the names of all users that did not book any flight
# select(filter(acc, uid1), filter(allTables, acc.uid1 != fact.uid2), acc.name)
select(filter(allTables, acc.uid1 != fact.uid2), acc.name)


# Question 2
# For each flight, find the total amount of seats that are booked
nrow(fact) # counts the number of rows in the fact table

# Question 3
# For each unique pair of origin and destination cities,
    # find fid of the flight that offers the lowest price.

fly %>% 
  group_by(fly.orig, fly.dest)%>%
  distinct(min(fly.price))

