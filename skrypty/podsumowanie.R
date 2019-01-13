# instalowanie pakietow
if (!require(dplyr)) install.packages("dplyr")
if (!require(caret)) install.packages("caret")
if (!require(ggplot2)) install.packages("ggplot2")
if (!require(ellipse)) install.packages("ellipse")
if (!require(MASS)) install.packages("MASS", dependencies = T)
if (!require(e1071)) install.packages("e1071")

# eksploracja danych ------------------------------------------------------
# ile poziomow ma zmienna objasniana
unique(iris$Species)
# zbalansowanie klas
iris %>%
  group_by(Species) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  mutate(perc = n / sum(n))
# 2 sposob
prop.table(table(iris$Species))
# sprawdzenie typow zmiennych
str(iris)
# statystyczna analiza danych ---------------------------------------------
# szybkie podsumowanie
summary(iris)
# zbadaj rozklady zmiennych
draw_iris_histograms = function(name_of_variable) {
  ggplot(iris, aes_string(x = name_of_variable)) + 
    geom_histogram(bins = 20) +
    facet_wrap(~Species)
}
draw_iris_histograms("Petal.Length")
draw_iris_histograms(names(iris)[2])
lapply(names(iris)[-5], draw_iris_histograms)
# wykresy gestosci
if (!require(reshape2)) install.packages("reshape2")
iris %>%
  melt(id.vars = "Species") -> densities
ggplot(densities, aes(x = value, color = Species)) +
  geom_density() +
  facet_wrap(~variable)

# zbadaj wzajemne relacje miedzy zmiennymi
x = iris[, 1:4] # zmienne objasniajace (niezalezne)
y = iris[, 5] # zmienna objasniana (zalezna)
featurePlot(x, y, plot = "ellipse")
# zbadanie korelacji
cor(x)

# MODELOWANIE -------------------------------------------------------------
indexes = createDataPartition(iris$Species, p = .7)
training = iris[indexes$Resample1, ]
testing = iris[-indexes$Resample1, ]
nrow(training) / nrow(iris)
nrow(testing) / nrow(iris)

tr_control = trainControl(method = "repeatedcv",
                          number = 10, 
                          repeats = 3)
# Accuracy poniewaz klasy zbalansowane oraz niebinarne
performance_metric = "Accuracy"
# trenowanie modeli
train_models = function(method) {
  set.seed(178)
  train(Species~., 
        data = training, 
        trControl = tr_control, 
        metric = performance_metric,
        method = method)
}
# lda = train_models(method = "lda")
# cart = train_models(method = "rpart")
# knn = train_models(method = "knn")
# svm = train_models(method = "svmRadial")
# rf = train_models(method = "rf")
methods = c("lda",
            "rpart",
            "knn",
            "svmRadial",
            "rf")
models = lapply(methods, train_models)
# wybieranie najlepszego modelu
results = resamples(models)
summary(results)

# zapisywanie modelu ------------------------------------------------------
final_model = models[[1]]
save(final_model, file = "final_model.RData")
saveRDS(final_model, "final_model.rds")


# walidacja modelu --------------------------------------------------------
testing$predicted = predict(final_model, testing)
confusionMatrix(testing$Species, testing$predicted)

# parameter tunning
grid = expand.grid(C = seq(0, 1, by = 0.2),
                   sigma = seq(0, 1, by = 0.2))
model = train(Species~., 
              data = training, 
              trControl = tr_control, 
              metric = performance_metric,
              method = "svmRadial",
              tuneGrid = grid)
testing$predicted = predict(model, testing)
