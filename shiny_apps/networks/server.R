
library(shiny)
library(bigrquery)
library(dplyr)
library(visNetwork)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  setBigQueryEnv()
  con = createConnection()
  nodes = getNodes(con)
  edges = getEdges(con)
  output$network = renderVisNetwork({
      visualiseGraph(nodes, edges)
    }
  )
})
