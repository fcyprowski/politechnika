install.packages("ChannelAttribution")
install.packages("visNetwork")
library(dplyr)
library(magrittr)
library(visNetwork)

model = ChannelAttribution::markov_model(
  data_to_upload, 
  var_path = "sourcePath", 
  var_conv = "totalConversions", 
  out_more = TRUE
)

result = model$result %>%
  mutate_if(is.numeric, round) %>%
  arrange(desc(total_conversions))

# wybierzmy najwieksze 10 kanalow
best_channels = result %>%
  mutate_if(is.factor, as.character) %>%
  arrange(desc(total_conversions)) %>%
  slice(1:5) %>%
  use_series(channel_name)
# wezmy transition probability
transition_matrix = model$transition_matrix %>%
  mutate_if(is.factor, as.character) %>%
  filter(channel_from %in% c("(start)", best_channels),
         channel_to %in% c("(conversion)", best_channels))

# puszczamy wykresy -------------------------------------------------------

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

nodes = data_frame(id = c( c(transition_matrix$channel_from), c(transition_matrix$channel_to) )) %>%
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


visNetwork(nodes,
           edges,
           height = "2000px",
           width = "100%",
           main = "Generic Probabilistic model's Transition Matrix") %>%
  visIgraphLayout(randomSeed = 123) %>%
  visNodes(size = 5) %>%
  visOptions(highlightNearest = TRUE)
