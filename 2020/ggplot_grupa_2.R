library('ggplot2')

plot(x = iris$Sepal.Length, y = iris$Sepal.Width)
hist(iris$Sepal.Length)

ggplot(iris, aes(x = Sepal.Length, 
                 y = Petal.Length)) +
  geom_point(aes(color = Species, 
                 size = Sepal.Width^2,
                 alpha = .05)) +
  geom_text(aes(label = Sepal.Width)) +
  labs(
    title = "Wykres 1",
    subtitle = "test",
    caption = "see?",
    x = "sepal length",
    y = "petal length"
  ) +
  theme(
    panel.background = element_blank(),
    panel.grid = element_blank(), 
    plot.title = element_text(size = 40),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

library(dplyr)
library(tidyr)

iris %>%
  group_by(Species) %>%
  summarise_all(mean) %>%
  # 2
  gather("metric", "value", -Species) %>%
  ggplot(aes(x = Species, y = value)) +
  geom_bar(stat = "identity",
           position = position_dodge()) +
  coord_flip() +
  facet_wrap(~metric)
