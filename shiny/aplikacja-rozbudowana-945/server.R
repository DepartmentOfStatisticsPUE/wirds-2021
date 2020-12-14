#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(shinythemes)

options(shiny.maxRequestSize = 30*1024^2) ## 30 mb

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # output$file_summary <- renderPrint({
    #
    #     req(input$text_file)
    #
    #     dane <- read_csv(file = input$text_file$datapath, progress = FALSE)
    #     dim(dane)
    # })
    #
    # output$file_head <- renderTable({
    #     head(dane)
    # })
    
    observe({
        req(input$text_file)
        
        dane <- read_csv(file = input$text_file$datapath,
                     progress = FALSE)
        
        output$file_summary <- renderPrint({
            dim(dane)
        })
        
        output$file_head <- renderTable({
            head(dane)
        })
        
        output$pzn_summary <- renderPlot({
            pzn <- dane %>% filter(str_detect(sub_region_2, "Poznań"))
            
            pzn %>%
                ggplot(data = ., aes(x = date, 
                                     y = retail_and_recreation_percent_change_from_baseline, 
                                     group = sub_region_2,
                                     color = sub_region_2)) +
                geom_line() + 
                scale_color_brewer(type = "qual", palette = "Set1") + 
                labs(x = "Date", y = "Retail and recreation change", color = "Powiat") 
            
        })
    })
    
})
