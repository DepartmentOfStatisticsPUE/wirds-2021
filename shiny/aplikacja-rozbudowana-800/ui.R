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
        ### zakladka dotyczaca danych wejsciowych
        tabPanel("Dane wejściowe", 
                 sidebarPanel(
                     fileInput("text_file", "Wybierz plik:", 
                               accept = ".csv",
                               buttonLabel = "Przeglądaj..."),
                     actionButton("refresh", "Pobierz dane", class = "btn-primary")
                 ),
                 mainPanel(
                     verbatimTextOutput("informacje"), ## informacje o pliku
                     verbatimTextOutput("test") ## informacje o pliku
                 )
        ),
        
        ## raporty
        tabPanel("Raport", "Nic tu nie ma"),
        
        ## wizualizacje danych
        tabPanel("Wizualizacja", "Nic tu nie ma")
    )
)
