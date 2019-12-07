install.packages("readr")
library(readr)
library(ggplot2)

# gdzie jest nasz folder roboczy
getwd()
setwd("C:/Users/filip.cyprowski/Downloads")

# zapisujemy csv
write.csv(diamonds, "diamonds.csv")
write.csv2(diamonds, "diamonds.csv")
write.csv(diamonds, "C:/Users/filip.cyprowski/Documents/politechnika/diamonds2.csv")

# wczytywanie csv
dane = read.csv("diamonds.csv", sep = ";", header = TRUE, dec = ",")

# wczytywanie awaryjne
dane_awaryjne = readLines("diamonds.csv")
strsplit(dane_awaryjne[1], split = ";")

library(xlsx)
install.packages("readxl")
library(readxl)

# wczytywanie xlsx
danexl = read_excel("diamonds.xlsx")



# formaty R
# .RData
x = 5
y = 10
z = 100
save(x, y, z, file = "xyz.RData")

x = 25
y = 15
z = 1001
load("xyz.RData")
# .rds
saveRDS(diamonds, "diamonds.rds")
new_diamonds = readRDS("diamonds.rds")
