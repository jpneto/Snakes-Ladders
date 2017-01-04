source("variants.R")
source("tools.R")

games <- list(abstract, snakes, chutes, gyan.chaupar, gyan.chaupar.jain10, vaikuntapaali)

#######################
# choose values

n.players  <- 6
game.index <- 5
n.runs     <- 500

#######################
# simulation

replicate(n.runs, play(games[[game.index]], n.players)) %>% 
  create.report(n.players) -> df

#######################
# data presentation

hist(df$n.rounds, breaks=50)

# what % of wins for each player?
winners <- df$winner  
table(winners)/length(winners)

#######################

write.csv2(df[,-ncol(df)], paste0(game$name,".csv"))  # save except winning.per.round


