library(shiny)
library(plotly)

shinyUI(fluidPage(
  sidebarLayout(
    
    sidebarPanel(
      
      # Create the controls on what to display on x-axis
      selectInput('data.x', label = 'Variable to Plot on X-Axis', 
                  choices = list(
                    'sepal length' = 'Sepal.Length', 'sepal width' = 'Sepal.Width', 
                    'petal width' = 'Petal.Width', 'petal length' = 'Petal.Length'
                  )
      ),
      
      # Create the controls on what to display on y-axis
      selectInput('data.y', label = 'Variable to Plot on Y-Axis', 
                  choices = list(
                    'sepal length' = 'Sepal.Length', 'sepal width' = 'Sepal.Width', 
                    'petal width' = 'Petal.Width', 'petal length' = 'Petal.Length'
                  )
      )
    ),
    
    # Render the scatter plot on the main panel.
    mainPanel(
      plotlyOutput('scatter')
    )
  )
  
))