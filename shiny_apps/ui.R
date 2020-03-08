library(shiny)

shinyUI(fluidPage(
  shiny::numericInput("liczba", 
                      "wpisz liczbe", 
                      value = 2),
  shiny::textOutput("wynik")
))
