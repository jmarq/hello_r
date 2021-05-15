#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(vegalite)
vegaModule <- modules::use("vegaPlot.R")
gapminderModule <- modules::use("gapminder_shiny_module.R")


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  uiOutput("css"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      radioButtons("page", label = h3("pages"),
                   choices = list("vegalite" = 1, "ggplot2" = 2, "r plots" = 3, "gapminder" = 4), 
                   selected = 1),
      conditionalPanel("input.page == 1",
                   vegaModule$vegaPlotInput("vegaId")
      ),
      conditionalPanel("input.page == 3",
                       sliderInput("bins",
                                   "Number of bins for histogram:",
                                   min = 1,
                                   max = 50,
                                   value = 30)
      ),
      conditionalPanel("input.page == 4",
                       gapminderModule$gapminderInput("gapminderId")
      )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      conditionalPanel("input.page == 1",
      # vega
        vegaModule$vegaPlotUI("vegaId")
      ),
      conditionalPanel("input.page == 2",
                       # ggplot2
                       h1("ggplot2"),
                       plotOutput("ggplot")
      ),
      conditionalPanel("input.page == 3",
                       # "regular" plots
                       plotOutput("distPlot"),
                       plotOutput("simplePlot"),
                       plotOutput("irisPlot")      
      ),
      conditionalPanel("input.page == 4",
                       gapminderModule$gapminderUI("gapminderId")
      )
      
    )
  )
))
