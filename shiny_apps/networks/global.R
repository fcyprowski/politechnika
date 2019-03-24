createConnection = function() {
  dbConnect(bigquery(),
            project = Sys.getenv("PROJECT"),
            dataset = Sys.getenv("BQ_DATASET"))
}
setBigQueryEnv = function(key_path = "bq_key.json") {
  set_service_token(key_path)
}
getTable = function(con, tablename) {
  con %>%
    tbl(tablename) %>%
    collect()
}
getEdges = function(con) {
  getTable(con, "graph_edges")
}
getNodes = function(con) {
  getTable(con, "graph_nodes")
}
visualiseGraph = function(nodes, edges) {
  visNetwork(nodes, edges) %>%
    # visClusteringByGroup(nodes_with_grouping$group)  # pająk
    # visGroups(groupname = "4", color = "red") %>%
    visEdges(arrows = "from") %>%
    visOptions(highlightNearest = list(
      enabled = TRUE,
      degree = -Inf
    ))
}