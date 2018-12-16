# stworzenie dataframe'a z wektorow
df = data.frame(
  x = c(1,2,3,4,5),
  y = c(5,5,4,4,1)
)
df$x > 3
df[df$x > 3, ]

x = c(1,2,3,4,5)
y = c(5,5,4,4,1)
df2 = data.frame(
  kolumna_x = x,
  kolumna_y = y
)


# pierwszy sposob na dostanie sie do kolumny
iris$Petal.Length
iris$Petal.Length = iris$Petal.Length * 2
iris$calculation = iris$Petal.Length * iris$Sepal.Length
# drugi sposob
iris[["Petal.Length"]]
# trzeci sposob (niepolecany sposob)
iris[[3]] 
iris[, 3]

# wyciaganie obserwacji z dataframe'a
iris[2, 5]
iris[2:10, 4:5]

# wyciaganie obserwacji za pomoca warunkow logicznych
x = iris$Sepal.Length
min(x)
max(x)
x[x > 5]
x[x > 5 & x < 7]
x[x > median(x)]
# filtrowanie dataframe'a
versicolor = iris[iris$Species == "versicolor", ]
# zapisujemy wektor logiczny jako zmienna
only_versicolor = iris$Species == "versicolor"
# i aplikujemy do iris
versicolor = iris[only_versicolor, ]
# co jesli chcemy wyciagnac tylko Sepal.Length i Species
versiocolor2 = iris[only_versicolor, c("Sepal.Length", "Species")]

