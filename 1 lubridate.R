
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

month(today())



d <- '2011-12-12'

d2 <- ymd(d)

class(d)
#"character"

class(d2)
#"Date"


Sys.Date()


Sys.sleep(20)
