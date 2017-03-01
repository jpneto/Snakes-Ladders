library(readr)
library(dplyr)

source("tools.R")
source("variants.R")

#######################
# game parameter values

n.players   <- 3:6
game.index  <- 1:7
interaction <- c("none",  "swap", "stop")
end         <- c("goose", "stop", "loose")
n.runs      <- 50000

all.tests <- expand.grid(game.index,n.players,interaction,end)
size <- nrow(all.tests)

#######################
# create data frame for game statistics

name.stats <- c(".mean", ".sd", ".min", ".25%", ".median", ".75%", ".max")

names <- c(
  "game",
  "n.players",
  "int.rule",
  "end.rule",
  paste0("winner", 1:6, ".perc"),    # winning percentage for each player
  paste0("moves",  name.stats),
  paste0("rounds", name.stats),
  paste0("ahead1", name.stats, ".perc"),  # %rounds the 1st player was ahead
  paste0("ahead2", name.stats, ".perc"),  # %rounds the 2nd player was ahead
  paste0("ahead3", name.stats, ".perc"),  # ...
  paste0("ahead4", name.stats, ".perc"),
  paste0("ahead5", name.stats, ".perc"),
  paste0("ahead6", name.stats, ".perc"),
  paste0("persistence", name.stats, ".perc"), # %rounds the winner was ahead b4 winning
  paste0("persistence.", 1:20, "rounds"),
  paste0(1:6, ".players.ahead"),     # how many player were ahead during the match
  "not.random",
  "lognorm.mean",
  "lognorm.sd",
  "lognorm.logLik",
  "lognorm.AIC"
)

game.stats <- matrix(NA, nrow=size, ncol=length(names))
game.stats <- as.data.frame(game.stats)
colnames(game.stats) <- names

#######################
# create statistics for each game

for(i in 1:nrow(all.tests)) {
  # define game rules
  game     <- games[[all.tests[i,1]]]
  players  <- all.tests[i,2]
  int_rule <- all.tests[i,3]
  end_rule <- all.tests[i,4]
  
  # read respective table
  filename <- paste0(game$name,"_",players,"p_",int_rule,"_",end_rule,"_",n.runs,".csv")
  df <- read_csv2(paste0("../raw_data/",filename))[-1]
  
  cat(paste(i, "Processing ", filename, "...\n"))
  
  game.stats[i,"game"]      <- game$name
  game.stats[i,"n.players"] <- players
  game.stats[i,"int.rule"]  <- interaction[int_rule]
  game.stats[i,"end.rule"]  <- end[end_rule]
  
  winners <- df$winner  
  game.stats[i,paste0("winner",1:players,".perc")] <- 
    as.numeric(table(winners)/length(winners))

  game.stats[i,paste0("moves", name.stats)] <- 
    c(mean(df$n.moves), sd(df$n.moves), quantile(df$n.moves))
    
  game.stats[i,paste0("rounds", name.stats)] <- 
    c(mean(df$n.rounds), sd(df$n.rounds), quantile(df$n.rounds))

  for(k in 1:players) {
    ahead <- collect(df[,paste0("ahead.",k)])[[1]] / df$n.rounds  # get percentages
    game.stats[i,paste0("ahead",k, name.stats,".perc")] <-
      c(mean(ahead), sd(ahead), quantile(ahead))
  }
  
  persistance.perc <- df$persistence / df$n.rounds
  game.stats[i,paste0("persistence", name.stats, ".perc")] <- 
    c(mean(persistance.perc), sd(persistance.perc), quantile(persistance.perc))
  
  game.stats[i,paste0("persistence.", 1:20, "rounds")] <- 
    sapply(1:20, function(p) sum(df$persistence==p))

  game.stats[i,paste0(1:players, ".players.ahead")] <-
    as.numeric(table(df$n.players.ahead))
  
  ################
  # Compute how surprising is this result
  #  low  percentile suggests the result is       caused by uniform probability of winning
  #  high percentile suggests the result is *not* caused by uniform probability of winning
  more.wins <- max(table(winners))  # victories of 'best' player
  less.wins <- min(table(winners))  # victories of 'worst' player
  
  game.stats[i,"not.random"] <- run(more.wins/less.wins, players=players)
  
  ################
  # log-normal fit
  library('fitdistrplus')
  
  fit <- fitdist(df$n.rounds, "lnorm") # using MLE
  
  game.stats[i,"lognorm.mean"]   <- fit$estimate[1]
  game.stats[i,"lognorm.sd"]     <- fit$estimate[2]
  game.stats[i,"lognorm.logLik"] <- fit$loglik      # fit measure
  game.stats[i,"lognorm.AIC"]    <- fit$aic         # fit measure
}

write.csv2(game.stats, "../stats/game.stats.csv")

#######################
# egs of data presentation

# res <- df$n.rounds
# 
# hist(res, breaks=30, ylab=NA, xlab="turns", prob=T, yaxt='n',
#      main="", sub=paste0(players, " players"))
# fit <- fitdist(res, "lnorm")
# xs  <- seq(min(res), max(res), len=100)
# ys  <- dlnorm(xs, fit$estimate[1], fit$estimate[2])
# points(xs,ys,type="l", col="red", lwd=2)
 
