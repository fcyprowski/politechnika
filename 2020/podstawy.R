
# Działania ---------------------------------------------------------------
5 * 5
5 + 5
5 - 5
5 / 5
5^4
5 %% 2

# przypisywanie zmiennych -------------------------------------------------

x <- 5
x = 5
5 -> x

y = 6

z = x * y


# typy zmiennych ----------------------------------------------------------

[1,2,3,45,41]
c(1,2,3,45,51)

integer = as.integer(c(1,2,3,4,5,5))
numeric = c(1, 0.5, .2, 1)
char = c("lol", "lol2")
logical = c(TRUE, FALSE, T, F)
factr = factor(c("lol", "lol2", "lol"))
nas = c(NA, NA)

sum(numeric)
numeric_with_nas = c(numeric, NA)
sum(numeric_with_nas)

# usuwanie NAs
na.omit(numeric_with_nas)
numeric_with_nas[!is.na(numeric_with_nas)]

numeric_with_string = c(numeric, char)

singlenum = 5

numeric[1]
numeric[1:3]
numeric[c(2, 4)]

numeric[numeric > 1]
numeric

bignum = c(1,2,343,5,654,3,2,45,65,675,3)
# >
# <
# >=
# <=
# ==
# %in%
# !=
bignum[bignum %in% c(1,2,5)]
bignum[!(bignum %in% c(1,2,5))]
bignum[bignum > 200 & (bignum %% 2 != 0)]

bignum + bignum
bignum - bignum*2
# działania na stringach (pakiet: stringr)
char[grepl("2", char)]
char[grep("2", char)]


# data.frame --------------------------------------------------------------
head(iris)
str(iris)
summary(iris)

# wyciąganie wektorów
iris$Petal.Length
# działania
iris$nowa_kolumna = iris$Petal.Length * iris$Petal.Width
head(iris)
iris$nowa_kolumna = NULL
# filtrowanie
iris[5:10, ]
iris[5:10, 4:5]
iris[5:10, c("Petal.Width", "Species")]

iris[iris$Species == "setosa", 4:5]
iris[iris$Petal.Length > 5, 
     c("Petal.Length", "Species")]
only_setosa = iris[iris$Species == "setosa", 4:5]
View(only_setosa)


# funkcje -----------------------------------------------------------------

sum(numeric)
mean(numeric)
median(iris$Petal.Length)
iris$Petal.Length[5] = NA
median(iris$Petal.Length)
median(iris$Petal.Length, na.rm = TRUE)

square = function(x) {
  x^2
}

# listy -------------------------------------------------------------------

lista = list(
  x = c(2,3,4,5,1,23),
  y = c("string1", "string2"),
  dataframe = iris
)
result1 = lista[1]
result2 = lista[[1]]
lista$x
lista$dataframe
lista$dataframe$Petal.Width
lista$x = c(0,0,0,0)
lista$nowy_element = "hello"
lista$nowy_element = NULL

splitted = split(iris, iris$Species)
# liczymy sume Petal.Length dla każdego gatunku
# lapply(c(1,2,3,4), square)
aggregated = lapply(splitted, 
                    function(x) sum(x$Petal.Length))


# pętla for ---------------------------------------------------------------
wyniki = list()
for(i in 1:10) {
  forresult = square(i)
  wyniki[[i]] = forresult
}
wyniki = lapply(1:10, square)



# pętla while -------------------------------------------------------------
x = 0
while (x < 10) {
  print(x)
  x = x + 1
}

# ifelse ------------------------------------------------------------------
message = "iris"
if (message == "hello world") {
  print(message)
} else if (message == "iris"){
  head(iris)
} else {
  stop("The message is not hello world :(")
}

