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
library(writexl) ## powinno byc openxlsx 

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
        
        ## dane wczytane
        dane <- read_csv(file = input$text_file$datapath,
                     progress = FALSE)
        
        ## dane dla poznania
        pzn <- dane %>% 
            filter(str_detect(sub_region_2, "Poznań")) %>%
            select(date, region = sub_region_2,
                   handel_i_rekreacja = retail_and_recreation_percent_change_from_baseline,
                   sklepy_i_apteki = grocery_and_pharmacy_percent_change_from_baseline,
                   parki = parks_percent_change_from_baseline,
                   przystanki = transit_stations_percent_change_from_baseline,
                   miejsca_pracy = workplaces_percent_change_from_baseline,
                   miejsca_zamieszkania = residential_percent_change_from_baseline)
        
        ggplot_google_pzn <- pzn %>%
            ggplot(data = ., aes(x = date, 
                                 y = handel_i_rekreacja, 
                                 group = region,
                                 color = region)) +
            geom_line() + 
            scale_color_brewer(type = "qual", palette = "Set1") + 
            labs(x = "Date", y = "Retail and recreation change", color = "Powiat") 

        
        output$file_summary <- renderText({
            paste("Wczytano:", nrow(dane), "wierszy oraz", ncol(dane), "kolumn.")
        })
        
        
        output$pzn_summary <- renderPlot({
            ggplot_google_pzn
        })
        
        output$plot_download <- downloadHandler(
            filename = function() { 
                paste0("wykres_google_pzn_", Sys.Date(), ".png") 
                },
            content = function(file) {
                ## musi byc funkcja z R do zapisu
                ggsave(filename = file, plot = ggplot_google_pzn, device = "png", 
                       width = 8, height = 5)
            }
        )
        
        output$pzn_tab <- renderDataTable({
            pzn
        })
        
        output$tab_download <- downloadHandler(
            filename = function() { 
                paste0("google_tabela_", Sys.Date(), ".xlsx") 
            },
            content = function(file) {
                ## musi byc funkcja z R do zapisu
                write_xlsx(x = pzn, path = file)  ## write.xlsx
            }
        )
        
    })
    
})
