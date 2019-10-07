#Shefali Emmanuel
# HW 8 Monty Hall Problem
# October 6, 2019

# Referenced the following sources
# https://stackoverflow.com/questions/9390965/select-random-element-in-a-list-of-r
# http://www.bodowinter.com/tutorial/bw_doodling_monty_hall.pdf
# https://www.inferentialthinking.com/chapters/09/4/Monty_Hall_Problem.html


goats <- c('first goat', 'second goat')

other_goat<- function(x){
  if (x == 'first goat'){
    return ('second goat')
  }else if (x == 'second goat'){
    return ('first goat')
  }
}

hidden_behind_doors <- c('car','first goat','second goat')

montyHallGame<-function(){
  
    contestant_guests <- sample(hidden_behind_doors,1)
    
    if(contestant_guests == ('first goat')){
      return (c(contestant_guests, 'second goat', 'car'))
    }else if(contestant_guests == ('second goat')){
      return (c(contestant_guests, 'first goat', 'car'))
    }else if(contestant_guests == ('car')){
      revealed <- sample(hidden_behind_doors,1)
      return (c(contestant_guests, revealed, other_goat(revealed)))
    }
}

gameResultsOverIterations<-function(){
  
  games <- c("Guess","Revealed","Remaining")
  
  for(i in 1:10000){
    
    games.append(montyHallGame())
    
    original_choice <- games.group('Guess')
    
    remaining_door <- games.group('Remaining')
    
    joined <- original_choice.join('Guess', remaining_door, 'Remaining')
    
    combined <- joined.relabeled(0, 'Item').relabeled(1, 'Original Door').relabeled(2, 'Remaining Door')
    
  }
}

gameResultsOverIterations()

# Solution came out to Yes Switch as the solution in the Data 8 Textbook had predicted.

