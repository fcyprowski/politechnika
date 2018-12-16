x = c(1,2,3,4,6, "lalalal")
lista = list(1,2,3,4,6, "lalalal")
lista_data_frameow = list(iris, mtcars, iris2 = iris, c(1,2,3,4))
df = lista_data_frameow$iris2
df2 = lista_data_frameow[["iris2"]]
y = lista_data_frameow["iris2"]


# SAC / MapReduce
# chcemy uzyskac srednia wartosc Petal.Width dla kazdego gatunku
# 1. SPLIT
splitted = split(iris, iris$Species)
# 2. APPLY
# applied = lapply(splitted, summary)
# lista_wektorow = list(c(1,2,3,4), c(432,45,3,21,3), c(84372,322,1))
# lapply(lista_wektorow, mean)
# 1 rozwiazanie - zadeklarowanie funkcji
mean_from_PetalWidth = function(tabela) {
  srednia = mean(tabela$Petal.Width)
  nazwa_gatunku = unique(tabela$Species)
  df_to_return = data.frame(
    Species = nazwa_gatunku,
    mean_Petal.Width = srednia
  )
  return(df_to_return)
}
applied = lapply(splitted, mean_from_PetalWidth)
# 2 rozwiazanie - funkcja anonimowa
applied = lapply(splitted, function(tabela) {
  srednia = mean(tabela$Petal.Width)
  nazwa_gatunku = unique(tabela$Species)
  df_to_return = data.frame(
    Species = nazwa_gatunku,
    mean_Petal.Width = srednia
  )
  return(df_to_return)
})
# COMBINE
result = do.call("rbind", applied)

library(dplyr)
iris %>%
  group_by(Species) %>%
  summarise(mean(Petal.Width))

iris %>%
  group_by(Species)
group_by(iris, Species)