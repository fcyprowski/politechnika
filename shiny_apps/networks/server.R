#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- visNetwork::renderVisNetwork({
    visNetwork(nodes_with_grouping, edges) %>%
      # visClusteringByGroup(nodes_with_grouping$group)  # pająk
      visGroups(groupname = "4", color = "red") %>%
      visEdges(arrows = "from") %>%
      visOptions(highlightNearest = list(
        enabled = TRUE,
        degree = 2
      ))
  })
  
})
