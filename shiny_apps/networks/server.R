
library(shiny)
library(bigrquery)
library(dplyr)
library(visNetwork)
source("env_vars.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  setBigQueryEnv()
  con = createConnection()
  nodes = getNodes(con)
  edges = getEdges(con)
  observeEvent(input$start, {
    output$network = renderVisNetwork({
      visualiseGraph(createRandomGrouping(nodes), edges)
    }
    )
  })
})
