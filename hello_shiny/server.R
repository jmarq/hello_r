#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(vegalite)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  output$simplePlot <- renderPlot({
    
    nums = c(1,2,3)
    multiplied_nums <- nums * input$bins
    plot(nums, multiplied_nums)
    
  })

  output$vegaPlot <- renderVegalite({
    vegalite(viewport_width=500, viewport_height=500) %>%
      cell_size(400, 400) %>%
      add_data(faithful) %>%
      encode_x("waiting", "quantitative") %>%
      encode_y("eruptions", "quantitative") %>%
      bin_x(maxbins=input$bins) %>%
      mark_point()
  })
  
})
