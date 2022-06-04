install.packages("ChannelAttribution")
install.packages("visNetwork")
library(dplyr)
library(magrittr)
library(visNetwork)


# Deep backend ------------------------------------------------------------

# 1
facts_sourcepath <- readr::read_csv("https://raw.githubusercontent.com/fcyprowski/politechnika/master/data/transactions.csv")

model = ChannelAttribution::markov_model(
  facts_sourcepath, 
  var_path = "sourcePath", 
  var_conv = "totalConversions", 
  out_more = TRUE
)
# 2
result = model$result %>%
  mutate_if(is.numeric, round) %>%
  arrange(desc(total_conversions))
# DBI::dbWriteTable(con, "facts_result", result)
# 3
trans_matrix = model$transition_matrix %>%
  mutate_if(is.factor, as.character)
# DBI::dbWriteTable(con, "facts_transition_matrix", transition_matrix)
# 4
removal_effects = model$removal_effects %>%
  mutate_if(is.factor, as.character)
# DBI::dbWriteTable(con, "facts_removal_effects", removal_effects)

# Backend -----------------------------------------------------------------

# wybierzmy najwieksze 10 kanalow
best_channels = result %>%
  mutate_if(is.factor, as.character) %>%
  arrange(desc(total_conversions)) %>%
  slice(1:5) %>%
  magrittr::use_series(channel_name)
# wezmy transition probability
transition_matrix = trans_matrix %>%
  mutate_if(is.factor, as.character) %>%
  filter(channel_from %in% c("(start)", best_channels),
         channel_to %in% c("(conversion)", best_channels))

edges = data.frame(
    from = transition_matrix$channel_from,
    to = transition_matrix$channel_to,
    label = round(transition_matrix$transition_probability, 2),
    font.size = transition_matrix$transition_probability * 100,
    width = transition_matrix$transition_probability * 15,
    shadow = TRUE,
    arrows = "to",
    color = list(color = "#95cbee", highlight = "red")
  )

nodes = data_frame(
  id = c( c(transition_matrix$channel_from), c(transition_matrix$channel_to) )) %>%
  distinct(id) %>%
  arrange(id) %>%
  mutate(
    label = id,
    color = ifelse(
      label %in% c('(start)', '(conversion)'),
      '#4ab04a',
      ifelse(label == '(null)', '#ce472e', '#ffd73e')
    ),
    shadow = TRUE,
    shape = "box"
  )



# Frontend ----------------------------------------------------------------

library(visNetwork)
visNetwork(nodes,
           edges,
           height = "2000px",
           width = "100%",
           main = "Generic Probabilistic model's Transition Matrix") %>%
  visIgraphLayout(randomSeed = 123) %>%
  visNodes(size = 5) %>%
  visOptions(highlightNearest = TRUE)
