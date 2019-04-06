library(shiny)
library(bigrquery)
library(dplyr)
library(visNetwork)
source("env_vars.R")
source("global.R")


setBigQueryEnv()
con = createConnection()
nodes = getNodes(con)
edges = getEdges(con)
vis = visualiseGraph(nodes, createRandomGrouping(edges))
visNetworkEditor(vis)
