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

cities <- read.csv("City_Locations.csv", stringsAsFactors = FALSE)

for(i in 1:5){
  name <- paste0('state.data.', locations.US.nospace$name[i])
  assign(name, twitteR::getTrends(locations.US.nospace$woeid[i]))
  list <- eval(parse(text = name)) %>% select(name) %>% split(seq(nrow(eval(parse(text = name)))))
  list <- list[c(1:20)]
  city.data[[i, 1]] <- list
}

shinyServer(function(input, output) { 
  
  # Retrieve search string from user.
  searchString <- reactive({
    tolower(gsub(" ", "", input$search))
  }) 
  
  output$map <- renderPlotly({ 

    to.plot <- getData()
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
    
      p <- plot_geo(to.plot, locationmode = 'USA-states', sizes = c(1, 150), color=~ranking) %>%
      add_markers(
        x = ~lon, y = ~lat, hoverinfo = "text", size = ~ranking,
        text = ~paste(to.plot$new.name, "<br />", to.plot$related.topic, "<br />", "#", 21 - to.plot$ranking)
      ) %>%
      layout(title = 'Trending levels of topics', geo = g) %>%
    
    return()
  }) 
  
  # @RICH: Make sure the UI and server elements are consistent!
  output$table <- renderPlot({ 
    getData() %>%
      select("new.name", "ranking") %>%
      return()
  }) 
  
  getData <- function() {
    all.cities <- rownames(city.data)
    ranking <- vector(mode="integer", length = length(all.cities))
    related.topic <- vector(mode="character", length = length(all.cities))
    for(city in 1:5) {
      current.city <- all.cities[city]
      most.popular <- city.data[[current.city, 1]]
      has.match <- FALSE
      
      index <- 1
      while(has.match == FALSE && index < 6) {
        put.related.topic <- ""
        put.ranking <- 0
        popular.topic <- most.popular[[index]]$name
        if(grepl(searchString(), tolower(gsub(" ", "", popular.topic))) == TRUE) {
          put.related.topic <- popular.topic
          put.ranking <- index
          has.match <- TRUE
        }
        ranking[city] <- put.ranking
        if(put.ranking > 0) {
          ranking[city] <- 21 - put.ranking
        }
        related.topic[city] <- put.related.topic
        index <- index + 1
      }
    }
    
    return(cities %>%
             select(new.name, lat, lon) %>%
             mutate(ranking, related.topic))
  }
  
})



 
  
