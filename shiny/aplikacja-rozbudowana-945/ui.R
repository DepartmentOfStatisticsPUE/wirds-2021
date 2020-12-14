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
                     verbatimTextOutput("file_summary"),
                     tableOutput("file_head")
                 )),
        
        tabPanel("Raport", "jeszcze cos dodamy"),
        
        tabPanel("Wizualizacja", 
                 plotOutput("pzn_summary")),
        
        navbarMenu("O aplikacji",
                   tabPanel("O autorze", "TBA"),
                   tabPanel("O danych", "TBA"),
                   tabPanel("Kontakt", includeMarkdown("about/contact.md")))
    )
)

