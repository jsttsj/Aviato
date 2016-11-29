library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
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