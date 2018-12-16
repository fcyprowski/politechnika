library(ggplot2)
library(caret)
data("diamonds")
formula = as.formula(price ~ .)
# rozdzielenie datasetu
partition = createDataPartition(diamonds$price, p = .7)
wektor = partition$Resample1
training = diamonds[wektor, ]
testing = diamonds[-wektor, ]
# cross-validation
tr_control = trainControl(method = "repeatedcv",
                          number = 10,
                          repeats = 3,
                          p = .7)
models = c('lm', 'lars', 'leapSeq', 'relaxo')
train_with_what_we_have = function(method) {
  print(method)
  train(
    formula, 
    data = training,
    trControl = tr_control,
    method = method,
    metric = "RMSE")
}
# library(purrr)
# train_with_what_we_have = partial(train, 
#                                   formula, 
#                                   data = training,
#                                   trControl = tr_control,
#                                   metric = "RMSE")
lista_modeli = lapply(models, train_with_what_we_have)
comparison = resamples(lista_modeli)
summary(comparison)
