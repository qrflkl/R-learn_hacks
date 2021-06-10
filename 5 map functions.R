
# change the default library to the one I can install packsges
.libPaths("C:/R_library")

library(tidyverse)

read_csv()

sqrt(100)

# calc the sqrt for a list of numbers 
a <- 1:10 %>% 
  map(.x = ., .f = sqrt)
# it returns a list


b <-  1:10 %>% 
      map_dbl(sqrt)
# it returns a vector of doubles
# typeof(a)
# class(b)


c <- 1:10 %>% 
  map_chr(sqrt)
# it returns a vector of chars

map_df()
# it is a powerful function, can bind multiple files together into one file


list.files(path = 'Zip files')

weather_data <-  list.files(path = 'Zip files/Excersise Data',  pattern = 'csv$', full.names = T) %>% 
  map_df(.x = ., .f = read_csv, col_names = F, n_max = 5000)

#do it antoher way

weather_data_2 <-  list.files(path = 'Zip files/Excersise Data',  pattern = 'csv$', full.names = T) %>% 
  map_df(~ read_csv(file = ., col_names = F, n_max = 5000))

#the ‘~’ operator is called tilde

# randomly generate 10 numbers from normal distritubion
rnorm(n = 10)
# [1] -1.754867652  0.572742225 -0.194165928  0.343948475  0.133376393 -0.008370260  1.471709122
# [8]  0.441039363  0.601937856 -0.006534211


rnorm(n=10, mean = 5, sd = 2)


#randomly generate a list of 10, each list has n of numbers from normal distribution
 1:10 %>% 
  map(rnorm)
 
 
# randomly generate a list of 10, each list has 10 numbers from normal distribution
1:10 %>% 
   map(rnorm, n= 10)
 
#randomly generate a list of 10, each list has 10 numbers from normal distribution with mean value =5 and 1 std 
1:10 %>% 
  map(~ rnorm(n=10,mean = 5, sd = 1))  
# this is a fomular way

rnorm(n=10,mean = 5, sd = 1)
#this returns a vector of numeric value, so need ~ to convert to list like (1:10)


# randomly generate a list of 10, each list has 10 numbers from normal distribution with mean value =5 and 1 std 
# and then pass it to another map_dbl function to get the mean of each list  
1:10 %>% 
  map(~ rnorm(n=10,mean = 5, sd = 1))  %>% 
  map_dbl(mean)


# randomly generate a list of 10, each list has 10 numbers from normal distribution 
#with mean value (dot here) is following with the item in the 1:10 list and 1 std 
# and then pass it to another map_dbl function to get the mean from each list  
1:10 %>% 
  map(~ rnorm(n=1000,mean = ., sd = 1))  %>% 
  map_dbl(mean)


# same as above, use dot on sd
1:10 %>% 
  map(~ rnorm(n=1000,mean = 5, sd = .))  %>% 
  map_dbl(sd)

