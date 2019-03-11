

library(shiny)
library(plotly)
shinyServer(function(input, output) {
   data("mpg")
   # dane = mpg
   # output$histogram = renderPlot({
   #   dane$selected_variable = dane[[input$selected_variable]]
   #   p = ggplot(dane, aes(x = selected_variable)) %>%
   #     geom_histogram()
   #   return(p)
   # })
   output$histogram = plotly::renderPlotly({
     dane$selected_variable = dane[[input$selected_variable]]
     p = plot_ly(dane, x = ~selected_variable) %>%
       add_histogram()
     return(p)
   })
})
