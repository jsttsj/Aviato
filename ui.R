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
      sliderInput("n", "Number of points", 10, 200,
                  value = 50, step = 10)
    )
  )
)

shinyUI(
    fluidPage(
       titlePanel("Insert Title here"),
          plotOutput('map'),
            wellPanel(
              helpText("Look at locations of the trending hashtag"),
              textInput("search", label = h3("Enter Hashtag"), value = "#Hashtag"),
              submitButton("Submit")
            )))
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
                                plotOutput('map')
                              )
                            )
                   )
))

shinyUI()
8d06760fb918ea2ed65c16bab3b7b7295820a374
