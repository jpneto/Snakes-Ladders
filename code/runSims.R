source("variants.R")
source("tools.R")

#######################
# choose values

n.players   <- 3:6
game.index  <- 1:7
interaction <- c("none",  "swap", "stop")
end         <- c("goose", "stop", "loose")
n.runs      <- 50000

all.tests <- expand.grid(game.index,n.players,interaction,end)

#######################
# run simulations

for(i in 1:nrow(all.tests)) {
  # get current values
  game     <- games[[all.tests[i,1]]]
  players  <- all.tests[i,2]
  int_rule <- all.tests[i,3]
  end_rule <- all.tests[i,4]
  
  # simulation
  replicate(n.runs, play(game, players, int_rule, end_rule)) %>% 
    create.report(players) -> df

  
  # write result
  filename <- paste0(game$name,"_",players,"p_",int_rule,"_",end_rule,"_",n.runs,".csv")
  write.csv2(df[,-ncol(df)], paste0("../raw_data/",filename))  # save except winning.per.round
}



