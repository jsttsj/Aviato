# server.R
library(dplyr)
library(shiny)
library(plotly)
library(rsconnect)

install.packages('twitteR')
library(twitteR)
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

cities <- read.csv('City_Locations.csv', stringsAsFactors = FALSE)

for(i in 1:nrow(locations.US)){
  name <- paste0('state.data.', locations.US.nospace$name[i])
  assign(name, twitteR::getTrends(locations.US.nospace$woeid[i]))
  list <- eval(parse(text = name)) %>% select(name) %>% split(seq(nrow(eval(parse(text = name)))))
  list <- list[c(1:20)]
  city.data[[i, 1]] <- list
}

# as an example of how to call something specific.  This calls the third most popular thing 
# in Baton Rouge
city.data[["Baton Rouge",1]]$`3`

shinyServer(function(input, output) { 
  
  # Retrieve search string from user.
  search.string <- tolower(gsub(" ", "", input$search))
    
  # For each of the 62 df, run through trending topics/hashtags. Stop at first instance
  # where topic/hashtag contains input string. This will minic "related concepts" --Jenny
  all.cities <- rownames(city.data)
  ranking <- vector(mode="integer", length = length(all.cities))
  related.topic <- vector(mode="character", length = length(all.cities))
  for(city in 1:length(all.cities)) {
    current.city <- all.cities[i]
    most.popular <- city.data[[current.city, 1]]
    has.match <- FALSE
    index <- 1
    while(has.match == FALSE) {
      new.val <- ""
      popular.topic <- most.popular[[index]]
      if(grepl(search.string, gsub(" ", "", popular.topic)) == TRUE || index == 20) {
        new.val <- popular.topic
        has.match <- TRUE
      }
      ranking[i] <- index
      related.topic[i] <- popular.topic
    }
  }
  
  to.plot <- cities %>%
    select(new.name, lat, lon) %>%
    mutate(ranking, related.topic)
  
  output$map <- renderPlotly({ 
    
    # Plot the city on Plotly. Display the topic/hashtag being plotted. Modify size of 
    # plotted dot based on the row number of the topic/hashtag. --Jenny
    
    #return()
  }) 
  
})

 
  
