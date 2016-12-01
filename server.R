library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)

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
  output$bubble <- renderPlotly({ 
    return(
      #Show data only of selected species  
      filter(iris,Species==input$species.type)%>%
        
        #convert string into object to select measurement, make histogram of data,
        plot_ly( x = ~eval(parse(text=input$hash)),type = "histogram")%>%
        
        #title graph based on species and measurement, lable axis. 
        layout(title=paste("Histogram of the", input$measure,"of the",input$species.type,"Flower"),xaxis=list(title="Size"),yaxis=list(title="Count")))
  }) 
  
  
})