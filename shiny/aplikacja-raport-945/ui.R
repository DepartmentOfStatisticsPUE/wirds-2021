#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(

    # Application title
    titlePanel("Aplikacja powstała w ramach przedmiotu WiRDS"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins", ## to jest nazwa zmiennej, która przetrzymuje wynik!!!
                        "Liczba przedziałów:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Histogram", plotOutput("distPlot")),
                        tabPanel("Dane", dataTableOutput("rawData")),
                        tabPanel("Zależność", plotOutput("scatterPlot")),
                        tabPanel("Regresja1", verbatimTextOutput("reg1")))
        )
    )
    )
)
