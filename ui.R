library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(twitteR)

fluidPage(
  verticalLayout(
    img(src='twitter.png', align = "right"),
    titlePanel("Find Trending Hashtag"),
    
    #lable output box
    plotOutput('map'),
    wellPanel(
      helpText("Look at locations of the trending hashtag"),
      textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
      submitButton("Submit")
    )))

#shinyUI(
 #   fluidPage(
  #     titlePanel("Insert Title here"),
   #    img(src='twitter.svg', align = "right"),
    #      plotOutput('map'),
     #       wellPanel(
      #        helpText("Look at locations of the trending hashtag"),
       #       textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
        #      submitButton("Submit")
         #   )))
#shinyUI()
#8d06760fb918ea2ed65c16bab3b7b7295820a374
