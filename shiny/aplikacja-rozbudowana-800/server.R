#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readr)

options(shiny.maxRequestSize = 30*1024^2) ## 30 mb

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    # output$informacje <- renderPrint({
    # 
    #     req(input$text_file)
    # 
    #     google <- read_csv(file = input$text_file$datapath, progress = FALSE)
    # 
    #     print(dim(google))
    # })
    
    observe({
        
        req(input$text_file)
        google <- read_csv(file = input$text_file$datapath, progress = FALSE)
        
        output$informacje <- renderPrint({
            dim(google)
        })
        
        output$test <- renderPrint({
            summary(google)
        })
        
    })
    
})
