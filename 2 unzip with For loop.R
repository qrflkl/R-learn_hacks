
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

