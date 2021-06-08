
# find files
list.files('Weather/2017/', full.names = T)

# assign the from path to a var
from_path <- list.files('Weather/2017/', full.names = T)

# how to copay and paste 1 file 
file.copy(from = from_path, to = 'Weather' )


#call tidyverse to be able to use walk

library(tidyverse)


# how to create below vector
# "Weather/2017/2017.csv"
# "Weather/2018/2018.csv"
# .../2019/...
# .../2020/...


# use paste0(), similar to concatenate
paste0("Weather/","2018","/2018.csv")


#replace 2018 with var
y <- 2017
paste0("Weather", y, "/",y,".csv")


#create a vector
y <- 2017:2020
paste0("Weather/", y, "/",y,".csv")
# result -->"Weather2017/2017.csv" "Weather2018/2018.csv" "Weather2019/2019.csv" "Weather2020/2020.csv"


#create a function to perform the actions -- copy files from multi folders and paste to a location

my_copy_function <- function(x){
  
  from_path <- paste0("Weather/", x, "/", x,".csv") # define the from paths, it depends on x (year)
  file.copy(from = from_path, to = 'Weather' ) # from_path is the argument passed from above line, then being copied and pasted
}

my_copy_function(2020)


# use walk to loop through years vector and act on the function
walk(.x =2017:2020 , .f = safely(my_copy_function))



