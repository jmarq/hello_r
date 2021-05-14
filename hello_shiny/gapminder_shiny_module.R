import(shiny)
import(stats)
import(ggplot2)
import(dplyr)
import(gapminder)
#import datasets so that 'faithful' is available
import(datasets)

gapminderUI <- function(id, label = "gapminderPlotLabel") {
  # namespace "translation" function
  ns <- NS(id)
  div(
    id="yes",
    h1("explore gapminder data"),
    plotOutput(ns("gapminderPlot")),
    plotOutput(ns("meanLinesPlot"))
  )
}

gapminderInput <- function(id, label="gapminderInputLabel") {
  ns <-NS(id)
  sliderInput(ns("maxYear"),
              "max year:",
              min = 1952,
              max = 2007,
              value = 2007)
}

gapminderServer <- function(id) {
  moduleServer(id,
               function(input, output, session) {
                 
                 filteredByYear <- reactive({
                   print("filtering gapminder by year as reactive data")
                   gapminder %>%
                     filter(year <= input$maxYear)
                 })
                 
                 output$gapminderPlot <- renderPlot({
                   filteredByYear() %>%
                     ggplot(aes(x=log(gdpPercap), y=lifeExp, col=year, size=pop))+
                     geom_point(alpha=0.5)+
                     geom_smooth(method=lm) +
                     facet_wrap(~continent)
                 })
                 
                 output$meanLinesPlot <- renderPlot({
                   worldYears <- filteredByYear() %>% group_by(year) %>% summarise(life_mean=mean(lifeExp))
                   worldYears %>% ggplot(aes(x=year, y=life_mean)) + geom_line()
                 })
               })
}