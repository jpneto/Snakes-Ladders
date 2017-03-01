abstract <- 
  list(name = "abstract",
       wins.at = 100,         # the winning cell
       size = 100,            # total number of cells
       jump = c(),            # cells that require a jump
       into = c())            # where to go?

ayres <- 
  list(name = "ayres",
       wins.at = 100,      
       size = 100,         
       jump = c( 6,20,23,43,60, 48,58,76,83,97),         
       into = c(40,90,54,70,95, 15,27,21,33,10))         

tantra <- 
  list(name = "tantra",
       wins.at = 100,      
       size = 100,         
       jump = c(14,47,50,58, 78,76,67,61,48,45,13,17),         
       into = c(44,83,84,79, 52, 2,16,42,10, 9, 8, 1))

althoen <- 
  list(name = "althoen",
       wins.at = 100,      
       size = 100,         
       jump = c( 1, 4, 9,21,28,36,51,71, 80, 16,47,49,56,62,64,87,93,95,98),         
       into = c(38,14,31,42,84,44,67,91,100,  6,26,11,53,19,60,24,73,75,78))
 
daykin <-
  list(name = "daykin",
       wins.at = 100,
       size = 100,
       jump = c( 6, 8,13,20,33,37,41,57,66,77, 27,55,61,69,79,81,87,91,95,97),
       into = c(23,30,47,39,70,75,62,83,89,96, 10,16,14,50, 5,44,31,25,49,59))

historical72 <- 
  list(name = "historical72",
       wins.at = 68,
       size = 72,
       jump = c(12,16,24,29,44,52,55,61,63,72, 10,17,20,22,27,28,37,45,46,54),
       into = c( 8, 4, 7, 6, 9,35, 2,13, 3,51, 23,69,32,60,41,59,66,67,62,58))

historical84 <- 
  list(name = "historical84",
       wins.at = 84,
       size = 84,
       jump = c(13,17,45,48,58,60,67,75,76,  7,38,44,47,65),
       into = c( 8, 1, 9,10,21,41,23, 2,52, 44,80,61,84,68))

games <- list(abstract, ayres, tantra, althoen, daykin, historical72, historical84)

#####################################################

# # Snakes and Ladders, UK, 19th century
# snakes <- list(name = "snakes.UK.1800s",
#                wins.at = 100,
#                size = 100,
#                jump = c(44,46,48,52,55,64,69,73,83,92,95,98, 08,21,43,50,54,62,66, 80),
#                into = c(19,05,09,11,07,36,33,01,19,51,24,28, 26,82,77,91,93,96,87,100))
# 
# 
# # Chutes and Ladders (Milton Bradley, 1943)
# chutes <- list(name = "chutes.US.1943",
#                wins.at = 100,
#                size = 100,
#                jump = c(01,04,09,21,28,36,51,71, 80,16,47,49,56,62,64,87,93,95,98),
#                into = c(38,14,31,42,84,44,67,91,100,06,26,11,53,19,60,24,73,75,78))
# 
# # Hindu percursor of classical version, 16th century
# gyan.chaupar <- list(name = "gyan.chaupar.1500s",
#                      wins.at = 68,
#                      size = 72, 
#                      jump = c(12,16,24,29,44,52,55,61,63,72,10,17,20,22,27,28,37,45,46,54),
#                      into = c(08,04,07,06,09,35,02,13,03,51,23,69,32,60,41,59,66,67,62,68))
# 
# # Hindu percursor of classical version (9 snakes, 6 ladders), Jain version
# # gyan.chaupar.jain9  <- list(wins.at = 84,
# #                             size = 84, 
# #                             jump = c(13,17,45,48,59,65,72,73,74, 13,44,47,55,64, 50),
# #                             into = c(08,01,12,27,34,16,36,02,54, 44,50,83,83,66, 83))
# 
# # Hindu percursor of classical version (10 snakes, 5 ladders), Jain version
# gyan.chaupar.jain10 <- list(name = "gyan.chaupar.jain.version",
#                             wins.at = 84,
#                             size = 84, 
#                             jump = c(13,17,45,48,59,65,72,73,74, 07,44,47,55,64, 83),
#                             into = c(08,01,12,27,34,16,36,02,54, 44,50,83,83,66, 50))
# 
# # India, Andhra Pradesh region
# vaikuntapaali <- 
#   list(name = "vaikuntapaali",
#        wins.at = 132,
#        size = 132, 
#        jump = c(17,26,43,47,55,59,75,97,106,111,113,119,121, 16,19,30,41,52,63,065,74,079,087),
#        into = c(06,03,21,25,33,08,10,73,001,089,109,095,099, 28,39,50,61,72,83,105,94,117,115))
# 

