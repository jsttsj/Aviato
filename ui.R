library(shiny)
library(plotly)
library(dplyr)
library(rsconnect)
shinyUI(navbarPage('1',
                   # Create a tab panel
                   tabPanel('2',
                            titlePanel('3'),
                            # Create sidebar layout
                            sidebarLayout(
                              
                              # Side panel for controls
                              sidebarPanel(
                                
                                # Create selectable input based on the type of measurement. 
                                textInput("hash", label = h3("Enter Hashtag"), value = "#Hashtag")),
                              selectInput('mapvar', label = 'Variable to Map', choices = list("Population" = 'population', 'Electoral Votes' = 'votes', 'Votes / Population' = 'ratio'),
                              
                              # Main panel: display plotly graph
                              mainPanel(
                                #lable output box
                                plotlyOutput('bubble')
                              )
                            )
                   )
))