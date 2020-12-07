#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, 
             col = 'darkgray', border = 'white',
             main = paste("Utworzono:", input$bins + 1, "przedziałów."))

    })
    
    output$datasetTable <- renderDataTable({
        
        return(faithful)
        
    })
    
    output$scatterPlot <- renderPlot({
        
        plot(x = faithful[,1], y = faithful[,2],
             xlab = "Eruptions", ylab = "waiting",
             main = "Zależność miedzy zmienną eruptions i waiting")
        
    })
    
    output$regresja <- renderPrint({
        model <- lm(eruptions ~ waiting, data = faithful)
        summary(model)
    })

})
