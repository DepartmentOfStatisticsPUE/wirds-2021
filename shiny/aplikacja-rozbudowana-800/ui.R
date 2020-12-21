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
                               buttonLabel = "Przeglądaj...")
                 ),
                 mainPanel(
                     textOutput("informacje"), ## informacje o pliku
                 )
        ),
        
        ## raporty
        tabPanel("Raport", 
                 sidebarPanel(
                     downloadButton("download_report", "Pobierz raport")
                 ),
                 mainPanel(
                     dataTableOutput("google_wynik_tab")
                 )),
        
        ## wizualizacje danych
        tabPanel("Wizualizacja", 
                 mainPanel(
                     plotOutput("google_wykres")
                 ))
    )
)
