#Shefali Emmanuel
# HW 8 Monty Hall Problem
# October 6, 2019

#Referenced the following sources
# https://stackoverflow.com/questions/9390965/select-random-element-in-a-list-of-r
# http://www.bodowinter.com/tutorial/bw_doodling_monty_hall.pdf
# https://www.inferentialthinking.com/chapters/09/4/Monty_Hall_Problem.html

doors <- c("A","B","C")

games <- c("Guess","Revealed","Remaining")

options = c() #create object

for(i in 1:10000){
  
  openGoatDoor <- sample(doors,1)
  
  goat <- sample(doors[which(doors != openGoatDoor)],1)
  
  car <- sample(doors[which(doors != openGoatDoor & doors != goat)],1)
  
  switchThis <-doors[which(doors != goat & doors != car)]

  if(openGoatDoor == goat){
    options=c(options,"noSwitch")
  }
  
  if(switchThis == openGoatDoor){
    options=c(options,"yesSwitch")
  }
  
  length(which(options == "noSwitch"))
  length(which(options == "yesSwitch"))
  
}

# Solution came out to Yes Switch as the solution in the Data 8 Textbook had predicted.

