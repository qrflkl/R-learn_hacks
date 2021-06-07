
.libPaths()
.libPaths('C:/R_library')

#install package
install.packages('R.utils')

#call the library
library(R.utils)


#call functions
# list.files --  produce a character vector of the names of files or directories in the named directory.
list.files(path = 'Zip files')
#"2017.csv.gz"    "2018.csv.gz"    "2019.csv.gz"    "2020.csv.gz"    "Excersise Data"


list.files(path = 'Zip files', pattern = 'gz')
# "2017.csv.gz" "2018.csv.gz" "2019.csv.gz" "2020.csv.gz"


list.files(path = 'Zip files', pattern = 'gz', full.names = T)
#"Zip files/2017.csv.gz" "Zip files/2018.csv.gz" "Zip files/2019.csv.gz" "Zip files/2020.csv.gz"


# assign to a var - char vector-- has 4 element
myzipfile <- list.files(path = 'Zip files', pattern = 'gz', full.names = T)

myzipfile[1]
# "Zip files/2017.csv.gz"

# if want to unzip a particular single, can use gunzip()
R.utils::gunzip(myzipfile[1],remove = F)


#use For loop to loop through the 4 files and unzip them

myzipfile

for( i in myzipfile) {   # i is iteration count
  print(i)
  gunzip(i, remove=F)
  }



#####################################################

## use walk() to unzip

install.packages("R.utils","tidyverse")

library(R.utils)
library(tidyverse) 

walk(.x = myzipfile, .f = gunzip, remove = F)


walk(.x = myzipfile, .f = safely(gunzip), remove = F)


##################################################

zipfiles <-  list.files(path = "Zip files/Excersise Data", full.names = T)

#list.files(path = "Zip files/Excersise Data", pattern = "csv", full.names = T) %>% 

zipfiles

# use for loop to unzip files
for( n in zipfiles){
    print(n)
   gunzip(n, remove=F)
  
}

# use walk() to unzip files
walk(.x = zipfiles,.f = safely(gunzip),remove = F)


# manually remove one of the files
file.remove("Zip files/Excersise Data/2013.csv")


# use Walk() to remove multiple files with certain pattern, e.g. all csvs.
rm_files <- list.files(path = 'Zip files/Excersise Data/', pattern = 'csv$', full.names = T)

walk(.x = rm_files, .f = file.remove)


# unzip all files using walk()

zipfiles

walk(.x = zipfiles,.f = safely(gunzip),remove=F)
