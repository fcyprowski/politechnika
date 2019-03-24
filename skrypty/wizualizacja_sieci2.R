# http://kateto.net/network-visualization
# igraph, networkD3, nedtv...

if (!require("visNetwork")) install.packages("visNetwork")

nodes = data.frame(
  id = c(1,2,3,4,5)
)
edge_vector = function() {
  sample(nodes$id, length(nodes$id), replace = TRUE)
}
construct_edges = function(nodes) {
  data.frame(
    from = edge_vector(),
    to = edge_vector()
  ) %>%
    distinct()
} 
edges = data.frame(
  from = edge_vector(),
  to = edge_vector()
)
visNetwork(nodes, edges)

# 2 przyklad
nodes = tibble::tibble(
  id = 1:100,
  title = id
)
edges = construct_edges(nodes)
# --------------
library(dplyr)
get_number_of_connection_directed = function(edges, column = "from") {
  names(edges)[names$edges == column] = id
  edges %>% 
    # szukamy node'ow z najwieksza liczba powiazan
    group_by(id) %>% 
    tally() %>%   # skrot dla summarise(n = n())
    arrange(desc(n)) %>%  # tego nie musi byc
    ungroup()
}
get_number_of_connections = function(edges) {
  # uproscilby to purrr
  get_number_of_connection_directed(edges, "from") %>%
    inner_join(
      get_number_of_connection_directed(edges, "to")
    ) %>%
    mutate(n = n.1 + n.2) %>%
    select(id, n) %>%
    rename(group = n)  # zmiana nazwy dla visNetwork
}
# tutaj joinujemy, zeby uzyskać kolumnę "group"
nodes_with_grouping = nodes %>%
  left_join(get_number_of_connections(edges), by = "id") %>%
  mutate(group = ifelse(is.na(group), 0, group) %>%
           as.character())
# -----------

visNetwork(nodes_with_grouping, edges) %>%
  # visClusteringByGroup(nodes_with_grouping$group)  # pająk
  visGroups(groupname = "4", color = "red") %>%
  visEdges(arrows = "from") %>%
  visOptions(highlightNearest = list(
    enabled = TRUE,
    degree = -Inf
  ))
