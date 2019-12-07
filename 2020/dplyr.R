install.packages("dplyr")
library(dplyr)

podsumowanie_grouped = group_by(iris, Species)
podsumowanie = summarise(podsumowanie_grouped, 
                         Petal.Length = sum(Petal.Length,
                                            na.rm = T))
podsumowanie = iris %>%
  group_by(Species) %>%
  summarise(Petal.Length = sum(Petal.Length,
                               na.rm = T))
iris %>%
  # filtrowanie 
  filter(Species == "setosa") %>%
  # wyciąganie zmiennych/kolumn
  select(Petal.Length, Species) %>%
  # dokładanie nowej tabeli
  mutate(squared.Petal.Length = square(Petal.Length)) %>%
  # sortowanie
  arrange(desc(Petal.Length)) %>%
  head()
  

