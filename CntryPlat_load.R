#setwd("C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Rproj/CntryPlat")

#install.packages('RJDBC')
#install.packages('plyr')
#install.packages("C:/Users/frankli/Downloads/ebaytd_1.1.tar.gz", repos = NULL, type = "source", lib="C:/Program Files/R/R-3.1.1/library")

############################################
c <- teradataConnect()

CPsqlPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Rproj/CntryPlat/CntryPlatGMB_185d.sql'
CPsqlQuery <- paste(readLines(CPsqlPath), collapse=" ")
CPdf <- dbGetQuery(c,CPsqlQuery)
CPdf2 <- df
