

# CAT boxplots
#server logic

source("setup.R") # load libraries and set up dataframes for each discipline


shinyServer(function(input, output) {
  
  output$catPlot <- renderPlot({
    
    if(input$discipline == 2){
      df = psyc
      prog_name = "Psychology"
      dummy = dummy_4 %>% mutate(Subject = "PSYC")#just missing 4th year
    }
    else if(input$discipline == 3){
      df = dram
      prog_name = "Drama"
      dummy = fix # not missing any years
    }
    else if(input$discipline == 4){
      df = apsc
      prog_name = "Engineering"
      dummy = dummy_4 %>% mutate(Subject = "APSC")#just missing 4th year
    } 
    else if(input$discipline == 5){
      df = phys
      prog_name = "Physics"
      dummy = dummy_4 %>% mutate(Subject = "PHYS")#just missing 4th year
    } 
    else{
      df = fix
      prog_name = "Queen's"
      dummy = fix #not missing data
    }
     
    #calculate sample sizes:
    n_1 <-  sum(with(df, year == 1 & CAT.Score > 1), na.rm = TRUE)     
    year1 <- paste0("First Year\nn = ", n_1, "   n = ", n_q_1) #text string for xlabel including sample size
    n_2 <-  sum(with(df, year ==2 & CAT.Score > 1), na.rm = TRUE)     
    year2 <- paste0("Second Year\nn = ", n_2, "   n = ", n_q_2) #text string for xlabel
    n_3 <-  sum(with(df, year == 3 & CAT.Score > 1), na.rm = TRUE)     
    year3 <- paste0("Third Year\nn = ", n_3, "   n = ", n_q_3) #text string for xlabel
    n_4 <-  sum(with(df, year == 4 & CAT.Score > 1), na.rm = TRUE)     
    year4 <- paste0("Fourth Year\nn = ", n_4, "   n = ", n_q_4) #text string for xlabel
    
    # set up data frame and title
    df <- rbind(df, queens, fix, dummy) # combine with all queens data
    graph_title <- paste0(prog_name,  " CAT Scores")
    
    
    ## plot description
    ggplot(
      data = df, 
      aes(x = as.factor(year), y = CAT.Score, fill = Subject)
      ) +
      geom_boxplot(width = 0.5) +    
      coord_cartesian(xlim = c(0.5,4.5),ylim = c(0, 40)) +
      scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
      labs(title = graph_title, x = "Year", y = "CAT Score")  +
      scale_fill_manual(
        values =  c("darkgoldenrod1", "steelblue3"),
        labels = c(prog_name, "Queen's")
        )+
      theme(
        panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
        panel.grid.major.y = element_line("grey"), #change horizonatal line colour (from white)
        panel.background = element_rect("white"), #change background colour
        legend.position = "bottom", # position legend below graph
        legend.title = element_blank(), #remove legend title
        axis.title.x = element_blank(), # remove x axis title
        axis.text.x = element_text(size = 12), #size of x axis labels
        panel.grid.major.x = element_blank() # remove white vertical lines
        ) # end ggplot description 
     
  }#end plot expression
  ) #end render plot
    
}#end function
) #end shiny server
