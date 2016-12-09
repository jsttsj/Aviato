# server.R
library(dplyr)
library(shiny)
library(plotly)
library(rsconnect)
library(twitteR)

# Load functions to call API and perform data wrangling on API data and plotting the map.
source("callAPI.R")
source("getData.R")
source("plotMap.R")

# Read in data containing longitudes and lattitudes of cities from the Twitter API
cities <- read.csv("./data/City_Locations.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) { 
  
  # Retrieve search string from user. Remove spaces and change to all lowercase to make
  # topic matching easier. Is put in a reactive function because it is requird by Shiny
  searchString <- reactive({
    tolower(gsub(" ", "", input$search))
  }) 
  
  # Plot the Twitter API data onto a map of the US based on the popularity of certain
  # topics in 63 cities across the US.
  output$map <- renderPlotly({ 
    # Obtain a dataframe of data that will be rendered on the map of the US.
    to.plot <- getData()
    to.plot$inv.rank <- abs((to.plot$ranking) - 21)
    return(plotMap(to.plot))
  }) 
  
  # Render the Twitter API data onto a data table based on the popularity of certain
  # topics in cities across the US.
  output$table <- renderDataTable({ 
    getData() %>%
      select(new.name, related.topic, ranking)
  }) 
  
})
