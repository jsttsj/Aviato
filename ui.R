library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(twitteR)

fluidPage(
  verticalLayout(
    titlePanel("Vertical layout example"),
    
    #lable output box
    plotOutput('map'),
    wellPanel(
      helpText("Look at locations of the trending hashtag"),
      textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
      submitButton("Submit")
    )))

shinyUI(
    fluidPage(
       titlePanel("Insert Title here"),
          plotOutput('map'),
            wellPanel(
              helpText("Look at locations of the trending hashtag"),
              textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
              submitButton("Submit")
            )))


#should we add twitter logo somewhere on the top? 
mainPanel(
  img(src='myImage.png', align = "right"),
  ### the rest of your code
)

shinyUI()
8d06760fb918ea2ed65c16bab3b7b7295820a374
