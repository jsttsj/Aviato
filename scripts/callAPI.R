library(dplyr)
library(twitteR)

# Set up token
options(httr_oauth_cache=T)
twitteR:::setup_twitter_oauth("KgSpEvpVmBqyjaHb8NKRS2cbq",
                              "XLGHwHKXUF6rt4m3lXQNhCOVsAyzneQrznBe4INje27olbCUHO",
                              "803743164884340736-ceXBIGtqVWc8wp27jXclV82QX6gWtoT",
                              "Ipi5Fun3ct3xbVFcfsAkCabWYMk0WLTp7Uyq3syYRVhKJ")

# This code is supposed to get the trend locations, and then get the trends for each location --Sean

# trend locations
locations <- twitteR::availableTrendLocations()
# getting only the locations and the id's associated
locations.US <- locations %>% 
  filter(country == 'United States', name != 'United States') %>% 
  select(name, woeid)
#removing spaces and hyphens for easier storage
locations.US.nospace <- locations.US
locations.US.nospace$name <- gsub(" ", "", locations.US.nospace$name)
locations.US.nospace$name <- gsub("-", "", locations.US.nospace$name)
#initializing an empty matrix, and changing the names 
city.data <- matrix(list(), nrow = 63, ncol = 1)
dimnames(city.data) <- list(unlist(locations.US$name), c("Data"))
# To control the number of API calls the web application makes every time the page is refreshed
size <- 63

# This loop prepares the matrix with all of the trend data
for(i in 1:size){ 
  # creating a variable name to store the data
  name <- paste0('state.data.', locations.US.nospace$name[i])
  # Assigning the trend data to that variable name
  assign(name, twitteR::getTrends(locations.US.nospace$woeid[i]))
  # Creating a list out of that data frame
  list <- eval(parse(text = name)) %>% select(name) %>% split(seq(nrow(eval(parse(text = name)))))
  # Truncating the list to 20 for uniformity
  list <- list[c(1:20)]
  # Storing the list in the matrix
  city.data[[i, 1]] <- list
}