#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

vegaModule <- modules::use("vegaPlot.R")

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
  
  output$ggplot <- renderPlot({
    ggplot(iris, aes(Sepal.Width, Petal.Width, colour = Species)) + 
      geom_point() + geom_smooth(method = "lm", se = TRUE)
  })
  
  output$irisPlot <- renderPlot({
    plot(iris, col=unclass(iris$Species), pch=unclass(iris$Species))
  })

  # two types of modules used here
  # a shiny module that has been encapsulated as an R module
  # here we are calling the R module's Shiny module server method
  vegaModule$vegaPlotServer("vegaId")
})
