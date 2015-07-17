# CAT_boxplots_by_program
Shiny app of Cat boxplots for eng, psyc, phys, dram

Select discipline from dropdown menu and the app plots a boxplot of that program's CAT scores compared to the intstitutional level(all scores, including the chosen discipline)


Some data frames have to be added so that boxes plot along the x axis properly: (i.e. leave a space for 3rd year and keep box widths the same when there is no discipline data for a year)

<b>fix</b>
4 null entries - one for each year- to make graph plot with a space for 3rd year and any other year with no data

<b>dummy</b>
data frame that is made up of dummy_2 and/or dummy_4 which add a score for second/ fourth that is outside the range of the plot. This makes the institutional level box plot at the proper width when there is no discipline specific score. dummy is assigned a Subject value in the if/else statements and row bound to the main data frame AFTER sample sizes are calculated, so it will not affect the calculations
