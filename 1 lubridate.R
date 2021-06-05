#.libPaths()

#.libPaths("C:/R_library")

#install packages
install.packages('lubridate')
install.packages("tidyverse")


library(lubridate)

#date functions

lubridate::date()  
#"Sat Jun 05 11:18:28 2021"

lubridate::today()
#"2021-06-05"


lubridate::month(lubridate::today())
#6



#date functions from tidyverse

library(tidyverse)


date()

today()

#month function 
#(x, label = FALSE, abbr = TRUE, locale = Sys.getlocale("LC_TIME")) UseMethod("month")


month(x = today(),label = T)
#[1] Jun
#12 Levels: Jan < Feb < Mar < Apr < May < Jun < Jul < Aug < Sep < ... < Dec


d <- '2011-12-12'

d2 <- ymd(d)
# ymd() -- Transforms dates stored in character and numeric vectors to Date 

class(d)
#"character"

class(d2)
#"Date"

#system dates 
Sys.Date()

#Suspend execution of R expressions for a specified time interval.
Sys.sleep(20)
#sleep for 20 seconds

