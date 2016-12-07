# server.R
library(dplyr)
library(shiny)
library(plotly)
library(rsconnect)
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

# @ SEAN: add comments here
for(i in 1:nrow(locations.US)){
  name <- paste0('state.data.', locations.US.nospace$name[i])
  assign(name, twitteR::getTrends(locations.US.nospace$woeid[i]))
  list <- eval(parse(text = name)) %>% select(name) %>% split(seq(nrow(eval(parse(text = name)))))
  list <- list[c(1:20)]
  city.data[[i, 1]] <- list
}

# Read in data containing longitudes and lattitudes of cities from the Twitter API
cities <- read.csv("City_Locations.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) { 
  
  # Retrieve search string from user. Remove spaces and change to all lowercase to 
  # make topic matching easier.
  searchString <- reactive({
    tolower(gsub(" ", "", input$search))
  }) 
  
  # Plot the Twitter API data onto a map of the US based on the popularity of certain
  # topics in 63 cities across the US.
  output$map <- renderPlotly({ 
    # Obtain a dataframe of data that will be rendered on the map of the US.
    to.plot <- getData()
    
    # Specifications of the appearance of the map.
    g <- list(
      scope = 'usa',
      projection = list(type = 'albers usa'),
      showland = TRUE,
      landcolor = toRGB("gray85"),
      subunitwidth = 1,
      countrywidth = 1,
      subunitcolor = toRGB("white"),
      countrycolor = toRGB("white")
    )
    
    # Plot the bubble map on Plotly
    p <- plot_geo(to.plot, locationmode = 'USA-states', sizes = c(1, 150), color=~ranking) %>%
      # Specifications of the bubble markers.
      add_markers(
        x = ~lon, y = ~lat, hoverinfo = "text", size = ~ranking,
        text = ~paste(to.plot$new.name, "<br />", to.plot$related.topic, "<br />", "#", 21 - to.plot$ranking)
        ) %>%
      layout(title = 'Trending levels of topics', geo = g) %>%
      return()
  }) 
  
  # Render the Twitter API data onto a data table based on the popularity of certain
  # topics in 63 cities across the US.
  # @RICH: Make sure the UI and server elements are consistent!
  output$table <- renderDataTable({ 
    getData() %>%
      select("new.name", "ranking")
  }) 
  
  getData <- function() {
    # Obtain a vector of all city names so it is easier to traverse through the matrix.
    all.cities <- rownames(city.data)
    
    # Create vectors for topic ranking and the corresponding related topics based on the
    # search string so that they can be added to the plotted data frame later.
    ranking <- vector(mode="integer", length = length(all.cities))
    related.topic <- vector(mode="character", length = length(all.cities))
    
    # Consolidate the the information into that will be displayed to the user into 
    # a single dataframe
    for(city in 1:length(all.cities)) {
      # Obtain information on the popular topics in a given city.
      current.city <- all.cities[city]
      most.popular <- city.data[[current.city, 1]]
      # Conditions to control the while loop
      has.match <- FALSE
      index <- 1
      # Given the list of popular 
      while(has.match == FALSE && index < length(all.cities) + 1) {
        # Initialize dummy values to be placed in the data frame.
        put.related.topic <- ""
        put.ranking <- NA
        popular.topic <- most.popular[[index]]$name
        # Check if the search string is related to a popular topic in the city.
        # If there is a popular topic, update the dummy values initialized earlier.
        if(grepl(searchString(), tolower(gsub(" ", "", popular.topic))) == TRUE) {
          put.related.topic <- popular.topic
          put.ranking <- index
          has.match <- TRUE
        }
        # Record the values into the data frame.
        ranking[city] <- put.ranking
        related.topic[city] <- put.related.topic
        # Continue traversing the matrix.
        index <- index + 1
      }
    }

    # Return a new data frame containing city name with geographical location and the
    # name and popularity of the matched topic.
    return(cities %>%
             select(new.name, lat, lon) %>%
             mutate(ranking, related.topic))
  }
  
})



 
  
