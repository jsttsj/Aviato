library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(twitteR)

navbarPage("Aviato!", 
  tabPanel("Map",
           verticalLayout(
             titlePanel("Aviato"),
             mainPanel(
               img(src="twitter.jpg", height = 100, width =150, align ="right")),
             plotlyOutput('map'),
             wellPanel(
               helpText("Look at the locations of trending hashtags"),
               textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
               submitButton("Submit")
             )
             )
           ))
#  tabPanel("Table",
 #          DT::dataTableOutput("table"))
  #)
#shinyUI()
#8d06760fb918ea2ed65c16bab3b7b7295820a374
