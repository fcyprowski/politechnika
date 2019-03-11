library(shiny)
library(shinythemes)
library(plotly)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
  "App", theme = shinytheme("united"), inverse = TRUE,
  tabPanel("Distributions", 
           flowLayout(
             textInput("selected_variable", label = "zmienna"),
             plotOutput("histogram")
           ),
           value = "distributions"),
  tabPanel("Hierarchy",
           flowLayout(
             
           ),
           value = "hierarchy")
  
))
