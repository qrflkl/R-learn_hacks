


.libPaths("C:/R_library")


# 1. install below packate
install.packages("rvest")


library(rvest)
library(tidyverse)

# 2. assign url to a var

u <- "https://www.imdb.com/chart/moviemeter/?sort=nv,desc&mode=simple&page=1"

# 3. read html and save it to a var
page <- read_html(x = u)

# 4. retrieve movie titles from this page, start off from page then pipe, use html_nodes function
# then use html_text() to extract the title
title <- page  %>% 
  html_nodes(".titleColumn a") %>% 
  html_text(trim = T)


# 5. retrieve the years
year <- page  %>% 
  html_nodes("a+ .secondaryInfo") %>% 
  html_text(trim = T) %>% 
  parse_number()


# 6. retrieve the ratings
ratings <- page %>% 
  html_nodes("strong") %>% 
  html_text(trim = T) %>% 
  parse_number()


# 7. fix the gaps, as ratings has only 78 ones, but movies have 100, similar year also miss values

n_ratings_missed <- length(title) -length(ratings)

#repeat NA multiple times as desired
rep(x = NA,n_ratings_missed)

#add the NA to ratings to reach 100 elements
ratings <- c(ratings, rep(x = NA,n_ratings_missed))


n_year_missed <- length(title) -length(year)
year <- c(year, rep(x = NA,n_year_missed))


# 8.  retrieve the links
links <- page  %>% 
  html_nodes(".titleColumn a") %>% 
  html_attr('href')

# fix above with adding the prefix
links <- paste0("www.imdb.com", links)

# 9.create a dataset to store all above scrapped info
movie_data <- tibble(title,year,ratings,link = links)

# check the movies of 2019
movie_data %>% 
  filter(year == 2019, ratings>=8.0)


#####################################################
##  web scraping from zillow.com
##############################################

# url from the webpage of zillow for po code =20744
url <- 'https://www.zillow.com/homes/for_sale/07002_rb/'

# read the page into Rstudio
pg <- read_html(url)


## scrape the price, and string transformation to numbers
price <- pg %>% 
  html_nodes('.list-card-price') %>% 
  html_text(trim =T) %>% 
  tolower() %>% 
  str_replace_all(string = .,pattern = '[,|$|\\s|-]',replacement = '') %>% #stringr  remove chars like $ --,white space
  as.numeric()


## scrpae the address
address <- pg %>% 
  html_nodes('.list-card-addr') %>% 
  html_text(trim =T)


## scrape the property types

type <-  pg %>% 
  html_nodes('.list-card-statusText') %>% 
  html_text(trim =T)


# get links for each property

property_link <-  pg %>% 
  html_nodes('.list-card-info .list-card-link-top-margin') %>% 
  html_attr(x=., name='href')

# create a table to combine above information
for_sale <-  tibble(address, price, type, property_link)


############################################################
###   loop through multi web pages
############################################################

# extract the pages urls
pg %>% 
  html_nodes('.ekGcXR a') %>% 
  html_attr('href')

# consturct the url for each pages
links <- paste0('https://www.zillow.com/bayonne-nj-07002/',1:3,'_p/')


# to loop through each of above urls and extract infos like price, addr, urls...
# then apply map() to execute the loop, so we need to build the function first

#build a function to extract price, addr, type...

my_scrape <- function(x) {
  
  Sys.sleep(time = sample(7:12, size = 1, replace = T))
  pg <- read_html(x)
  
  price <- pg %>% 
    html_nodes('.list-card-price') %>% 
    html_text(trim =T) %>% 
    tolower() %>% 
    str_replace_all(string = .,pattern = '[,|$|\\s|-|k|est|.]',replacement = '') %>% #stringr  remove chars like $ --,white space
    parse_number() 
  
  address <- pg %>% 
    html_nodes('.list-card-addr') %>% 
    html_text(trim =T)
  
  type <-  pg %>% 
    html_nodes('.list-card-statusText') %>% 
    html_text(trim =T)
  
  property_link <-  pg %>% 
    html_nodes('.list-card-info .list-card-link-top-margin') %>% 
    html_attr(x=., name='href')
  
    tibble(address, price, type, property_link)
  
}

my_scrape(links[2])

## loop through all pages of prop. related to 07002 
my_results <- links %>% 
  map_df(.x=., .f=my_scrape)

