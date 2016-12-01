# server.R
library(dplyr)
library(jsonlite)

# source('./scripts/CreateMap.R')

# Start shinyServer
shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your map
  output$map <- renderPlotly({ 
    base.url <- "https://api.twitter.com/1.1/search/tweets.json?q=%23"
    hashtag <- input$search
    query <- paste0(base.url, hashtag)
    return(CreateMap())
  }) 
  
})
  