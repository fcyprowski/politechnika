install.packages("ggplot2")
library(ggplot2)
data(iris)
# szybkie wykresy - qplot()
p = qplot(Sepal.Length, Sepal.Width, data = iris, color = Species)
# dluzsze wykresy - ggplot()
# Przyklad 1 z dodawaniem roznych warstw
p = ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = cut))
model = lm(price~carat+clarity+cut, data = diamonds)
diamonds$predicted_price = predict(model, diamonds)
p + geom_line(data = diamonds, aes(y = predicted_price, group = 1), 
              color = "red", size = 2, alpha = .6)
# Przyklad 2 - customizacja wykresu
superwykres = ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(aes(color = Petal.Length, shape = Species), size = 4) +
  scale_color_continuous(low = "#e45873", high = "#86af96") +
  theme(
    panel.background = element_blank(),
    panel.grid.major = element_line(color = "#8f83b1"),
    panel.grid.minor = element_line(color = "#8f83b1"),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    title = element_text(size = 20)
  ) +
  labs(
    title = "Sepal length vs Sepal Width"
  )
# robimy interaktywny wykres
if (!require(plotly)) install.packages("plotly")
ggplotly(superwykres)  


# Przyklad 3 - facets
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point(aes(color = clarity)) +
  facet_wrap(~cut)
