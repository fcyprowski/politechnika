# plot
plot(x =iris$Sepal.Length, y = iris$Petal.Length)
lines(x =iris$Sepal.Length, y = 2*iris$Sepal.Length + 0.5)
hist(iris$Sepal.Length)

install.packages("ggplot2")
library("ggplot2")
ggplot(iris, 
       aes(x = Sepal.Length,
           y = Petal.Length)) +
  geom_point(aes(color = Species, 
                 size = Petal.Width,
                 alpha = .1)) +
  geom_text(aes(label = Sepal.Width,
                vjust = 0)) +
  labs(title = "Iris first plot",
       subtitle = "test",
       caption = "see?",
       x = "Sepal Length",
       y = "Petal Length") +
  theme(axis.title.x = element_blank(),
        panel.background = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank(), 
        plot.title = element_text(size = 40, 
                                  color = "red", 
                                  hjust = .5))

install.packages("tidyr")
library("tidyr")
library("dplyr")
library("ggplot2")
# 1
iris %>%
  group_by(Species) %>%
  summarise_all(sum) %>%
  # 2
  tidyr::gather(key = "metric",
         value = "value", 
         -Species) %>% 
  # wykres
  ggplot(aes(x = Species,
             y = value)) +
  geom_bar(stat = "identity", 
           position = position_dodge()) +
  coord_flip() +
  facet_wrap(~metric)
