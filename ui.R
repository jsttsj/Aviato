library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
library(twitteR)
shinyUI(navbarPage('1',
                   # Create a tab panel
                   tabPanel('2',
                            titlePanel('3'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                helpText("Look at locations of the trending hashtag"),
                                # Create selectable input based on the type of measurement. 
                                textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
                                submitButton("Submit")
                              ),
                              
                              # Main panel: display plotly graph
                              mainPanel(
                                img(src="#putintwitterimagehere", height = 20, width = 20),
                                
                                #lable output box
                                plotlyOutput('map')
                              )
                            )
                   )
))

shinyUI()
8d06760fb918ea2ed65c16bab3b7b7295820a374
