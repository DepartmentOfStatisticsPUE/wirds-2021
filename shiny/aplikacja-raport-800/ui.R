#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(
    
    fluidPage(
    
    theme = shinytheme("paper"),
    
    # Application title
    titlePanel("Moja pierwsza aplikacja w Shiny"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Wykres", plotOutput("distPlot")),
                        tabPanel("Dane", dataTableOutput("datasetTable")),
                        tabPanel("Zależność", plotlyOutput("scatterPlot")),
                        tabPanel("Regresja", verbatimTextOutput("regresja")))
            
        )
    )
))
