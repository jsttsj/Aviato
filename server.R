# server.R
library(dplyr)
library(shiny)
library(plotly)
library(rsconnect)
library(jsonlite)

# Twitter API calls --Sean
install.packages('twitteR')
library(twitteR)
setup_twitter_oauth("KgSpEvpVmBqyjaHb8NKRS2cbq",
                    "XLGHwHKXUF6rt4m3lXQNhCOVsAyzneQrznBe4INje27olbCUHO",
                    "803743164884340736-ceXBIGtqVWc8wp27jXclV82QX6gWtoT",
                    "Ipi5Fun3ct3xbVFcfsAkCabWYMk0WLTp7Uyq3syYRVhKJ")
data<-getUser("")
dataframe<-data$toDataFrame()
newdata<-searchTwitter("PEOTUS",n=100)
newdata.df<-twListToDF(newdata)
View(dataframe)
twitterR::availableTrendLocations()
trends<-twitterR::getTrends(23424977)

# Obtain geocodes. Merge each data frame with geocodes. --Jon

shinyServer(function(input, output) { 
  
  output$map <- renderPlotly({ 
    
    # Obtain user input string. --Jenny
    
    # For each of the 62 df, run through trending topics/hashtags. Stop at first instance
    # where topic/hashtag contains input string. This will minic "related concepts" --Jenny
    
    # Retrieve row number of topic/hashtag. --Jenny
    
    # Plot the city on Plotly. Display the topic/hashtag being plotted. Modify size of 
    # plotted dot based on the row number of the topic/hashtag. --Jenny
    
    #return()
  }) 
  
})
  
