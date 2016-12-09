library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(twitteR)
library(rmarkdown)

#navbar makes navigation bars for separate tabs 
navbarPage("Aviato!", 
  tabPanel("Map",
           #This makes the plotly output the main focus of the Map pannel
           verticalLayout(
             titlePanel("Locations of Trending Topics!!"),
             mainPanel(
               #pulls out twitter logo 
               img(src="twitter.jpg", height = 100, width =130, align ="right")),
             #outputs the plotly map! 
             plotlyOutput('map'),
             wellPanel(
               helpText("Find the locations of trending hashtags or related keywords"),
               textInput("search", label = h3("Enter Hashtag or Related Keyword"), value = "a"),
               submitButton("Submit")
             )
             )
           ),
           #new tab for the data table 
  tabPanel("Table",
           dataTableOutput("table")), 
           #new tab that explains the whole project 
  tabPanel("About",
           includeMarkdown("About.md"))
  )
