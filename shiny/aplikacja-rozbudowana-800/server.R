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
library(tidyverse)
library(writexl) ## powinno być openxlsx

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
        
        ## wczytanie danych
        google <- read_csv(file = input$text_file$datapath, progress = FALSE)
        
        ## przetwarzanie
        google_wynik <- google %>%
            filter(sub_region_2 == "Poznań County") %>%
            select(data = date, retail_and_recreation_percent_change_from_baseline:residential_percent_change_from_baseline) %>%
            rename(handel_i_rekreacja = retail_and_recreation_percent_change_from_baseline,
                   sklepy_i_apteki = grocery_and_pharmacy_percent_change_from_baseline,
                   parki = parks_percent_change_from_baseline,
                   przystanki = transit_stations_percent_change_from_baseline,
                   miejca_pracy = workplaces_percent_change_from_baseline,
                   miejsca_zamieszkania = residential_percent_change_from_baseline) %>%
            arrange(desc(data)) 
        
        google_wykres <- ggplot(data = google_wynik, aes(x = data, y = handel_i_rekreacja)) + 
            geom_line() + 
            geom_smooth() + 
            labs(x = "Data", y = "Wskaźnik popularności", 
                 title = "Wskaźnik Google Mobility Trends: Handel i Rekreacja w Poznaniu")
        
        output$informacje <- renderText({
            paste("Wycztano:", nrow(google), "rekordów oraz", ncol(google), "zmiennych.")
            
        })
        
        output$google_wynik_tab <- renderDataTable({
            head(google_wynik, n = 30)
        })
        
        output$google_wykres <- renderPlot({
            plot(google_wykres)
        })
        
        output$download_report <- downloadHandler(
            filename <- function() {
               "covid-google-pzn.xlsx" ## zmienic na xlsx!!!
            },
            content = function(file) {
                write_xlsx(x = google_wynik, file) ## openxlsx::write.xlsx()
            }
        )
    })
    
})
