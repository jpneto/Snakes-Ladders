# function that plays a snakes'n'ladders type of game
#   it returns a list with several data from the players

# interaction == none, cells can have any amount of players
# interaction == swap, players swap positions when reaching an occupied cell
# interaction == stop, player does not move if the destination is occupied

# end == goose, if dice is more than destination, it moves backwards when reaching end
# end == stop,  if dice is more than destination, don't move
# end == loose, if dice is more than destination, wins

play <- function(game, players, interaction="none", end="goose", verbose=FALSE) {
  
  positions   <- rep(0,players)  # player's positions
  next_player <- 1 
  moves       <- 0
  rounds      <- 1
  
  whos_ahead  <- c(1,rep(0,1500))            # the player ahead at i-th round's end
  
  while (all(positions != game$wins.at)) {  # no one reached the winning cell
    dice <- sample(1:6, 1)
    
    new_position <- positions[next_player] + dice
    
    # apply end rule
    if (new_position > game$size) {               # missed the last cell?
    
      if (end=="stop")
        new_position <- positions[next_player]    # stay where you are
      
      else if (end=="loose") {
        if (game$wins.at == game$size)
           new_position <- game$wins.at           # wins the game
        else
           new_position <- positions[next_player] # stay where you are
      }
      
      # in the other situations, we just go back as many cells as the excess
      else
        new_position <- game$size - (new_position - game$size) # must go back
      
    }
    
    if (is.element(new_position, game$jump)) {     # lands on special cell?
      index <- which(new_position == game$jump)    #  then find where is it
      new_position <- game$into[index]             #  and move there
    } 
    
    # apply interaction rule
    if (interaction=="none")
      positions[next_player] <- new_position
    else {
      find_player_there <- which(positions==new_position)
      
      if (length(find_player_there)>0) {  # there's someone at destination cell
        
      # if (interaction=="stop") do not move
        if (interaction=="swap") {
          tmp <- positions[find_player_there]
          positions[find_player_there] <- positions[next_player]
          positions[next_player] <- tmp
        }
          
      } else   # if cell is empty, there's no limitation
        positions[next_player] <- new_position
    }
    
    # show board status (if verbose mode is on)
    if (verbose) {
      board_description <- paste0(sprintf("%2d", positions), collapse = " ")
      print(paste0("round: ", sprintf("%2d",rounds), 
                   " player: ", next_player, " {d ", dice, "}",
                   " board: [", board_description, "]"))
    }
    
    # update state
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

##################################
# make simulation assuming uniform probability of winning for all players

exec.sim <- function(players, throws) {
  sim    <- sample(1:players, throws, replace=TRUE)
  events <- table(sim)
  max(events) / min(events)  
}

##################################
# compute how surprising is this result
# low  percentile suggests the result is       caused by uniform probability of winning
# high percentile suggests the result is *not* caused by uniform probability of winning

# n      - number of simulations
# throws - how many games are we talking

run <- function(my.value, throws=50000, n=1000, players=6, verbose=FALSE) {
  sims <- replicate(n, exec.sim(players, throws))
  percentil <- round(sum(sims<my.value)/n,2)
  
  if (verbose) {
    hist(sims, breaks=25, prob=T, col="grey80", yaxt='n', xlab="", ylab="", 
         main=paste("Your result is at percentil", percentil))
    abline(v=my.value, col="blue", lty=2, lwd=2)
  }
  
  percentil
}

