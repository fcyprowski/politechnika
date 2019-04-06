

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  flowLayout( 
     actionButton("start", "generate groups"),
     visNetwork::visNetworkOutput("network") 
  )
))
