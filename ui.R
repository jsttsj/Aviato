library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(twitteR)

#fluidPage(
  #verticalLayout(
    #titlePanel("Vertical layout example"),
    
    #lable output box
    #plotOutput('map'),
    #wellPanel(
      #helpText("Look at locations of the trending hashtag"),
      #textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
      #submitButton("Submit")
    #)
  #)
#)

shinyUI(
    fluidPage(
       titlePanel("Insert Title here"),
          plotlyOutput('map'),
            wellPanel(
              helpText("Look at locations of the trending topic"),
              textInput("search", label = h3("Enter a topic"), value = ""),
              submitButton("Submit")
            )
       )
    )

#should we add twitter logo somewhere on the top? 
