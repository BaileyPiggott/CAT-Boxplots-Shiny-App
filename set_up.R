
# CAT boxplots test



## data
setwd("C:/Users/Bailey/Dropbox/SWEP/2015 CAT data") # take this out for Shiny App


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
