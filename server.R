

# CAT boxplots
#server logic

#source("setup.R") # load libraries and set up dataframes for each discipline
# R can't open a helper function consistently

library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)
library(magrittr)
library(grid)# load libraries

## data
apsc_100 = read.csv("APSC 100 CAT Scores.csv")
apsc_200 = read.csv("APSC 200 CAT Scores.csv") 
dram_100 = read.csv("DRAM 100 CAT Scores.csv")
dram_200 = read.csv("DRAM 200 CAT Scores.csv")
dram_400 = read.csv("DRAM 400 CAT Scores.csv")
phys_104 = read.csv("PHYS 104 106 CAT Scores.csv")
phys_239 = read.csv("PHYS 239 CAT Scores.csv")
psyc_100 = read.csv("PSYC 100 CAT Scores.csv")
psyc_203 = read.csv("PSYC 203 CAT Scores.csv")


# tidy data frames
#remove rows with no cat score, add a column for year, then remove unimportant columns

apsc_100 <- apsc_100 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 1) %>% select(Student.ID, year, Subject, CAT.Score) 
apsc_200 <- apsc_200 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 2) %>% select(Student.ID, year, Subject, CAT.Score)
dram_100 <- dram_100 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 1, Subject = 'DRAM') %>% select(Student.ID, year, Subject, CAT.Score)
dram_200 <- dram_200 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 2) %>% select(Student.ID, year, Subject, CAT.Score)
dram_400 <- dram_400 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 4) %>% select(Student.ID, year, Subject, CAT.Score)
phys_104 <- phys_104 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 1) %>% select(Student.ID, year, Subject, CAT.Score)
phys_239 <- phys_239 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 2) %>% select(Student.ID, year, Subject, CAT.Score)
psyc_100 <- psyc_100 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 1) %>% select(Student.ID, year, Subject, CAT.Score)
psyc_203 <- psyc_203 %>% filter(!is.na(CAT.Score)) %>% mutate(year = 2) %>% select(Student.ID, year, Subject, CAT.Score)

# combine into one data frame
cat <- rbind(apsc_100, apsc_200, dram_100, dram_200 ,dram_400, phys_104, phys_239, psyc_100, psyc_203)

# separate into disciplines
apsc <- cat %>% subset(Subject == 'APSC')
dram <- cat %>% subset(Subject == 'DRAM')
phys <- cat %>% subset(Subject == 'PHYS')
psyc <- cat %>% subset(Subject == 'PSYC')

# need null data for 3rd year to plot properly:
fix <- data.frame(c(NA,NA,NA,NA),c(1,2,3,4), c(NA,NA,NA,NA), c(NA,NA,NA,NA))
colnames(fix) <- colnames(cat)



shinyServer(function(input, output) {
  
  output$catPlot <- renderPlot({
    
    if(input$discipline == 2){
      df = psyc
      graph_title = "Psychology CAT Scores"
    }
    else if(input$discipline == 3){
      df = dram
      graph_title = "Drama CAT Scores"
    }
    else if(input$discipline == 4){
      df = apsc
      graph_title = "Engineering CAT Scores"
    } 
    else if(input$discipline == 5){
      df = phys
      graph_title = "Physics CAT Scores"
    } 
    else{
      df = cat
      graph_title = "CAT Scores"
    }
    
    
    df <- df %>% rbind(fix) # add null rows so space for third year shows up
    
    #calculate sample sizes:
    n_1 <-  sum(with(df, year == 1 & CAT.Score > 1), na.rm = TRUE)     
    year1 <- paste0("First Year\nn = ", n_1) #text string for xlabel including sample size
    
    n_2 <-  sum(with(df, year ==2 & CAT.Score > 1), na.rm = TRUE)     
    year2 <- paste0("Second Year\nn = ", n_2) #text string for xlabel
    
    n_3 <-  sum(with(df, year == 3 & CAT.Score > 1), na.rm = TRUE)     
    year3 <- paste0("Third Year\nn = ", n_3) #text string for xlabel
    
    n_4 <-  sum(with(df, year == 4 & CAT.Score > 1), na.rm = TRUE)     
    year4 <- paste0("Fourth Year\nn = ", n_4) #text string for xlabel
    
    
    ## plot description
    ggplot(
      data = df, 
      aes(x = as.factor(year), y = CAT.Score)
    ) +
      stat_boxplot(geom = 'errorbar', stat_params = list(width = 0.3)) + # add perpendicular lines to whiskers
      geom_boxplot(
        width = 0.5
      ) + # geom_boxplot must be after stat_boxplot    
      coord_cartesian(xlim = c(0.5,4.5),ylim = c(0, 40)) +
      scale_x_discrete(labels = c(year1, year2, year3, year4)) + #text strings from above with sample sizes
      labs(title = "CAT Scores", x = "Year", y = "CAT Score")  +
      theme(
        panel.border = element_rect(colour = "grey", fill = NA), #add border around graph
        panel.grid.major.y = element_line("grey"), #change horizonatal line colour (from white)
        panel.background = element_rect("white"), #change background colour
        axis.title.x = element_blank(), # remove x axis title
        axis.text.x = element_text(size = 12) #size of x axis labels
      )
    
    
    
  }#end plot expression
  ) #end render plot
  
  
  
}#end function
) #end shiny server
