
# user interface definition
# CLA data boxplots

library(shiny)

shinyUI(fluidPage(
  
  
  headerPanel("CAT Scores"), 
  
  sidebarPanel(
    selectInput("discipline", "Program:",
                c("Totals" = 1,
                  "Psychology" = 2,
                  "Drama" = 3,
                  "Engineering" = 4,
                  "Physics" = 5,
                  selected = 1 # default to total
                )#end options
    )#end selectInput
    
  ),#end sidebar panel
  
  mainPanel(
    plotOutput("catPlot")
  )
  
))
