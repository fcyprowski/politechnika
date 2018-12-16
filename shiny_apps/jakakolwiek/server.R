library(dplyr)
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$plot = renderPlot(
    ggplot(starwars) +
      geom_point(
        aes_string(
          x = 'height',
          y = 'mass',
          color = input$selected_column
        )
      ) +
      ylim(c(0, 250))
  )
  output$plot_mtcars = renderPlot(
    ggplot(
      mtcars %>%
        mutate(name = rownames(.)), 
      aes_string(
        x = input$selected_column_mtcars,
        y = "mpg"
      )
    ) +
      geom_point() +
      geom_text(aes(label = name))
  )
  
  
})
