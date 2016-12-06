library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(twitteR)
shinyUI(
  fluidPage(
    verticalLayout(
      titlePanel("Aviato"),
      mainPanel(

      img(src="twitter.jpg", height = 100, width =150, align ="right")),

   #lable output box
    plotOutput('map'),
    wellPanel(
      helpText("Look at the locations of trending hashtags"),
      textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
      submitButton("Submit")
    ))))

# mainPanel(
 # img(src='twitter.png', height = 10, width = 10),
  # ),
#shinyUI(
 #   fluidPage(
  #     titlePanel("Insert Title here"),
   #    img(src='twitter.png', align = "right"),
    #      plotOutput('map'),
     #       wellPanel(
      #        helpText("Look at locations of the trending hashtag"),
       #       textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
        #      submitButton("Submit")
         #   )))
#shinyUI()
#8d06760fb918ea2ed65c16bab3b7b7295820a374
