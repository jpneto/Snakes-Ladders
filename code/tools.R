# function that plays a snakes'n'ladders type of game
#   it returns a list with several data from the players

play <- function(game, players, verbose=FALSE) {
  
  positions   <- rep(0,players)  # player's positions
  next_player <- 1 
  moves       <- 0
  rounds      <- 1
  
  whos_ahead  <- c(1,rep(0,1e3))           # the player ahead at i-th round's end
  
  while (all(positions != game$wins.at)) {  # no one reach the winning cell
    dice <- sample(1:6, 1)
    
    new_position <- positions[next_player] + dice
    
    if (new_position > game$size)                            # missed the last cell?
      new_position <- game$size - (new_position - game$size) # must go back
    
    if (is.element(new_position, game$jump)) {     # lands on special cell?
      index <- which(new_position == game$jump)    #  then find where is it
      new_position <- game$into[index]             #  and move there
    } 
    
    positions[next_player] <- new_position
      
    next_player <- fetch_next(next_player, players)
    moves <- moves+1
    if (next_player==1)  {
      rounds <- rounds+1
      whos_ahead[rounds] <- which.max(positions)   # keep who's ahead
    }
  }
  
  list(winner   = which(positions==game$wins.at),  # who won
       n.moves  = moves,                           # how many moves were made
       n.rounds = rounds,                          # how many complete rounds (inc. last)
       winners.per.round = whos_ahead[1:rounds])   # who was ahead the each round's end
}


fetch_next <- function(player, n.players) { 
  res <- (player+1)%%n.players
  if (res==0) 
    n.players 
  else 
    res
}

###################################
# criteria for drama
###################################

# criterium: persistence of winner, how many turns does she kept her winning position?

crit_persistence_winner <- function(v) {
  d <- diff(v)
  if (max(d)==0) # always the same winner
    length(v)
  else
    which(rev(d)!=0)[1]
}

# criterium: how many players were ahead during the game

num_players_ahead <- function(v) {
  length(unique(v))
}


###################################
# create data frame with all collected information

create.report <- function(res, n.players) {
  
  winners <-   sapply(res[1,], function(col) col[1])
  moves   <-   sapply(res[2,], function(col) col[1])
  rounds  <-   sapply(res[3,], function(col) col[1])
  winning <-   lapply(res[4,], function(col) col)
  aheads  <- t(sapply(res[4,], 
                      function(col) table(factor(col, levels=c(1:n.players)))[1:n.players]))
  
  df.report <- data.frame(winner   = winners,
                          n.moves  = moves,
                          n.rounds = rounds)
  
  colnames(aheads) <- paste0('ahead.',1:n.players)
  df.report <- cbind(df.report, aheads)
  
  df.report$persistence       <- sapply(winning, crit_persistence_winner)
  df.report$n.players.ahead   <- sapply(winning, num_players_ahead)
  df.report$winners.per.round <- winning    # eg, df.report[2,]$winners.per.round[[1]]

  df.report
}
