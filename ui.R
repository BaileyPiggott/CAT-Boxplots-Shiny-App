
# user interface definition
# CLA data boxplots

library(shiny)

shinyUI(fluidPage(
  
  
  headerPanel("CAT Scores"), 
  
  sidebarPanel(
    selectInput("discipline", "Program:",
                c(
                  "Psychology" = 2,
                  "Drama" = 3,
                  "Engineering" = 4,
                  "Physics" = 5
                )#end options
    ),#end selectInput
    
    downloadButton("downloadPDF", "Download Plot")
    
    
  ),#end sidebar panel
  
  mainPanel(
    plotOutput("catPlot")
  )
  
))
