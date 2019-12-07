library(ggplot2)
library(caret)
library(dplyr)
library(tidyr)
library(readr)


# wczytywanie danych ------------------------------------------------------
setwd("~/politechnika/titanic")
getwd()

train_set = read_csv("../data/train.csv")
test_set = read_csv("../data/test.csv")


# eksploracja -------------------------------------------------------------
dataset = bind_rows(train_set, test_set)
dataset %>%
  group_by(Pclass) %>%
  tally() %>%
  ungroup() %>%
  mutate(percent = n/sum(n)) %>%
  filter(is.na(Pclass))
dataset %>%
  group_by(Age) %>%
  tally() %>%
  ungroup() %>%
  mutate(percent = n/sum(n)) %>%
  filter(is.na(Age))

toplot = dataset %>%
  group_by(Sex, Survived) %>%
  tally() %>%
  ungroup() %>%
  summarise(n)
ggplot(data = na.omit(toplot), 
       aes(x = Sex,
           y = n,
           fill = Survived)) +
  geom_bar(stat = "identity", position = "fill")

# feature engineering -----------------------------------------------------


# druga faza eksploracji --------------------------------------------------


# tranowanie i testowanie -------------------------------------------------


