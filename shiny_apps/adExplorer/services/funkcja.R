#* @get /square
function(x) {
  as.numeric(x) * as.numeric(x)
}
# http://localhost:5000/square?x=5
# RESPONSE: [25]

#* @get /model/predict
function(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width) {
  require(dplyr)
  df = data.frame(Sepal.Length = Sepal.Length,
             Sepal.Width = Sepal.Width,
             Petal.Length = Petal.Length,
             Petal.Width = Petal.Width) %>%
    lapply(as.numeric) %>%
    as.data.frame()
  df$Species = (predict(readRDS(getLastModels()), df) %>%
    as.data.frame() %>%
    names())[1]
  return(df)
}
# http://localhost:5000/model/predict?Sepal.Length=0.2&Sepal.Width=1.5&Petal.Length=4&Petal.Width=4.5

#* @get /model/train
function() {
  require(caret)
  # split datasetu
  split_vector = createDataPartition(iris$Species, p = .7)[[1]]
  train = iris[split_vector, ]
  test = iris[-split_vector, ]
  
  tr_control = trainControl(method = "cv",
                            number = 5,
                            p = .7)
  models = c('rpart', 'naive_bayes')
  train_with_what_we_have = function(method) {
    print(method)
    train(
      Species~., 
      data = train,
      trControl = tr_control,
      method = method)
  }
  lista_modeli = lapply(models, train_with_what_we_have)
  final_model = getBestModel(lista_modeli)
  # zapisywanie finalnego modelu z identyfikatorem
  filename = paste0("models/model", gsub(":", "_", Sys.time()), ".rds")
  saveRDS(final_model, filename)
  return(paste0("Model saved: ", filename))
}