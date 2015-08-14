
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
    
    downloadButton("downloadPDF", "Download Plot"),
    
    #text description of app ------------------------
    
    br(),br(), 
    h4("About This App"),
    p("This app displays the CAT (Critical Thinking Assessment Test) scores of Queen's students from 4
      departments. This test has a maximum score of 36."),
    br(),
    p("Learn more about the HEQCO Learning Outcomes Assessment Project", 
      a("here.", href = "http://www.queensu.ca/qloa/"))
    # end text description    
    
    
  ),#end sidebar panel
  
  mainPanel(
    plotOutput("catPlot")
  )
  
))
