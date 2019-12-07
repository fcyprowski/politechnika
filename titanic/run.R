library(ggplot2)
library(caret)
library(dplyr)
library(readr)


# wczytywanie danych ------------------------------------------------------
setwd("~/politechnika/titanic")
getwd()

train_set = read_csv("../data/train.csv")
