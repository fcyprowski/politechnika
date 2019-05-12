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
  df$Species = (predict(readRDS("model.rds"), df) %>%
    as.data.frame() %>%
    names())[1]
  return(df)
}
# http://localhost:5000/model/predict?Sepal.Length=0.2&Sepal.Width=1.5&Petal.Length=4&Petal.Width=4.5