# server.R
library(dplyr)
library(shiny)
library(plotly)
library(rsconnect)
library(jsonlite)

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

shinyServer(function(input, output) { 
  
  # Render a plotly object that returns your map
  output$map <- renderPlotly({ 
    base.url <- "https://api.twitter.com/1.1/search/tweets.json?q=%23"
    hashtag <- input$search
    query <- paste0(base.url, hashtag)
    #return(CreateMap())
  }) 
  
})
  
