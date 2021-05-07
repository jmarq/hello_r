import(shiny)
import(vegalite)
#import datasets so that 'faithful' is available
import(datasets)

vegaPlotUI <- function(id, label = "vegaPlotLabel") {
  # namespace "translation" function
  ns <- NS(id)
  vegaliteOutput(ns("vegaPlot"))
}

vegaPlotServer <- function(id) {
  moduleServer(id,
               function(input, output, session) {
                 output$vegaPlot <- renderVegalite({
                   vegalite(viewport_width = 500, viewport_height = 500) %>%
                     cell_size(400, 400) %>%
                     add_data(faithful) %>%
                     encode_x("waiting", "quantitative") %>%
                     encode_y("eruptions", "quantitative") %>%
                     bin_x(maxbins = input$bins) %>%
                     mark_point() %>%
                     mark_point()
                 })
               })
}