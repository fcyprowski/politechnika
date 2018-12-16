
library(shiny)
library(dplyr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  tabsetPanel(
    tabPanel(
      "starwars",
      selectInput(
        "selected_column",
        "Wybierz kolumne",
        choices = colnames(starwars)
      ),
      plotOutput("plot")
    ),
    tabPanel(
      "mtcars",
      selectInput(
        "selected_column_mtcars",
        "Wybierz kolumne",
        choices = colnames(mtcars)
      ),
      plotOutput("plot_mtcars")
    )
  )
))
