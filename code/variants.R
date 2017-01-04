
abstract <- list(name = "abstract",
                 wins.at = 100,         # the winning cell
                 size = 100,            # total number of cells
                 jump = c(),            # cells that require a jump
                 into = c())            # where to go?

# Snakes and Ladders, UK, 19th century
snakes <- list(name = "snakes.UK.1800s",
               wins.at = 100,
               size = 100,
               jump = c(44,46,48,52,55,64,69,73,83,92,95,98, 08,21,43,50,54,62,66, 80),
               into = c(19,05,09,11,07,36,33,01,19,51,24,28, 26,82,77,91,93,96,87,100))


# Chutes and Ladders (Milton Bradley, 1943)
chutes <- list(name = "chutes.US.1943",
               wins.at = 100,
               size = 100,
               jump = c(01,04,09,21,28,36,51,71, 80,16,47,49,56,62,64,87,93,95,98),
               into = c(38,14,31,42,84,44,67,91,100,06,26,11,53,19,60,24,73,75,78))

# Hindu percursor of classical version, 16th century
gyan.chaupar <- list(name = "gyan.chaupar.1500s",
                     wins.at = 68,
                     size = 72, 
                     jump = c(12,16,24,29,44,52,55,61,63,72,10,17,20,22,27,28,37,45,46,54),
                     into = c(08,04,07,06,09,35,02,13,03,51,23,69,32,60,41,59,66,67,62,68))

# Hindu percursor of classical version (9 snakes, 6 ladders), Jain version
# gyan.chaupar.jain9  <- list(wins.at = 84,
#                             size = 84, 
#                             jump = c(13,17,45,48,59,65,72,73,74, 13,44,47,55,64, 50),
#                             into = c(08,01,12,27,34,16,36,02,54, 44,50,83,83,66, 83))

# Hindu percursor of classical version (10 snakes, 5 ladders), Jain version
gyan.chaupar.jain10 <- list(name = "gyan.chaupar.jain.version",
                            wins.at = 84,
                            size = 84, 
                            jump = c(13,17,45,48,59,65,72,73,74, 07,44,47,55,64, 83),
                            into = c(08,01,12,27,34,16,36,02,54, 44,50,83,83,66, 50))

# India, Andhra Pradesh region
vaikuntapaali <- 
  list(name = "vaikuntapaali",
       wins.at = 132,
       size = 132, 
       jump = c(17,26,43,47,55,59,75,97,106,111,113,119,121, 16,19,30,41,52,63,065,74,079,087),
       into = c(06,03,21,25,33,08,10,73,001,089,109,095,099, 28,39,50,61,72,83,105,94,117,115))

###########################################

