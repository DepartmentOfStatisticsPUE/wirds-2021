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
    navbarPage(
        "Aplikacja",
        
        tabPanel("Dane wejściowe", 
                 sidebarPanel(
                     fileInput("text_file", label = "Wybierz plik:", accept = ".csv",
                               buttonLabel = "Przeglądaj...")
                 ),
                 mainPanel(
                     textOutput("file_summary")
                 )),
        
        tabPanel("Raport", 
                 sidebarPanel(
                     downloadButton("tab_download", "Zapisz plik do xlsx")
                 ),
                 mainPanel(
                     dataTableOutput("pzn_tab")
                 )),
        
        tabPanel("Wizualizacja", 
                 sidebarPanel(
                     downloadButton("plot_download", "Zapisz wykres do PNG")
                 ),
                 mainPanel(
                     plotOutput("pzn_summary") 
                 )
                 ),
        
        navbarMenu("O aplikacji",
                   tabPanel("O autorze", "TBA"),
                   tabPanel("O danych", "TBA"),
                   tabPanel("Kontakt", includeMarkdown("about/contact.md")))
    )
)

