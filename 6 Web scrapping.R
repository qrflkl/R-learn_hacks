


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
