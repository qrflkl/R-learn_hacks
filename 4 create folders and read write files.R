
library(tidyverse)

# try using file.remove to delete the folder
file.remove("Weather_test")
#it didn't work, reason 'Permission denied'

# try using unlink()
unlink(x = 'Weather_test', recursive = T)


#create a new folder "Weather_test"
dir.create(path = 'Weather_test')

# to create mutliple folders, /2017, /2018... under /Weather_test/
'Weather_test/2017'

#  one subfolder is like below 
x <-  2017
paste0('Weather_test/',x)
rm(x)  #remove the x var from memory

# create a function to store path name
path_func  <- function(x){
  paste0('Weather_test/',x)
}

path_func(2020)

# create a function to create a folder under another folder
path_func  <- function(x){
  dir.create( paste0('Weather_test/',x))
}

path_func(2020)
path_func('ABCD')  # path_func can create any folders

# remove the folder again
unlink(x = 'Weather_test',recursive = T) 


# %>% is powerful, allows us to create a pipeline of programming process with R

# example

2017:2020 %>% walk(.x = ., .f = path_func)
#create a pipeline by sending 2017:2020 to walk(), ".x=." dot means the thing(2017:2020) before the %>% is passed here


#read one file, without col. names, only read 1000 lines
read_csv(file = 'Zip files/2017.csv', col_names = F, n_max = 1000)


#write a file
write_csv(x = , path = )


# read and write one  file pipeline
read_csv(file = 'Zip files/2017.csv', col_names = F, n_max = 1000) %>% 
  write_csv(x = .,path = 'Weather_test/2017/2017.csv')


#create a read + write function before using walk()

read_n_write <- function(x) {
  read_csv(file = paste0('Zip files/', x,'.csv'), col_names = F, n_max = 10000) %>% 
    write_csv(x = .,path = paste0('Weather_test/',x,'/', x,'.csv'))
  
}

read_n_write(2018)

# use walk() to read from zip files folder and write to weather_test folder's subfolders

2017:2020 %>% 
  walk(.x = ., .f = read_n_write)




#############################################################

###  exercise 3 ##################

#########################################################

# locad the tidyverse library

library(tidyverse)

#Create the 2013 to 2016 sub-folders in the Weather folder using the walk() function

path_13_to_16 <- function(x) {
  dir.create(paste0('Weather_test/',x))
}

2013:2016 %>%  walk( path_13_to_16)


#3 Create a function that would import 100,000 rows from any of the CSV files in the Exercise data folder
#and write into the corresponding folders you created in step 2

list.files(path = 'Zip files/',pattern = 'csv$',full.names = T)
list.files(path = 'Weather_test',full.names = T)

read_write_13_to_16 <- function(x){
  read_csv(paste0("Zip files/Excersise Data/",x, ".csv"), col_names = F, n_max = 10000) %>% 
    write_csv(paste0("Weather_test/",x,"/",x,".csv"))
  
}

2013:2016 %>% walk(read_write_13_to_16)



#5  delete those 2013,... 2016 folders

rm_func <- function(x){
   file.remove(paste0("Weather_test/",x,"/",x,".csv"))
}

2013:2016 %>% walk(rm_func)


#6-8  use copy and paste to do the same

coy_paste <- function(x) {
  
  file.copy(from =paste0("Zip files/Excersise Data/",x, ".csv"),
            to = paste0("Weather_test/",x,"/",x,".csv"))
}

2013:2016 %>%  walk(coy_paste)


unlink('Weather_test',recursive = T)
