import(shiny)
import(vegalite)
#import datasets so that 'faithful' is available
import(datasets)

vegaPlotUI <- function(id, label = "vegaPlotLabel") {
  # namespace "translation" function
  ns <- NS(id)
  div(
    h1("vega time, pals"),
    p("trying out Shiny modules and this vegalite R package"),
    vegaliteOutput(ns("vegaPlot"))
  )
}

vegaPlotInput <- function(id, label="vegaPlotSlider") {
  ns <-NS(id)
  sliderInput(ns("bins"),
              "max bins for vega:",
              min = 1,
              max = 50,
              value = 30)
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