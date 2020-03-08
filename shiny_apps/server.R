library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$wynik = renderText({
    input$liczba ^ 2
  })  
  
})
