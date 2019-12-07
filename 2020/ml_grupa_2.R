library(ggplot2)
n = nrow(diamonds)
random_vector = sample(1:n, n*.7)
training = diamonds[random_vector, ]
testing = diamonds[-random_vector, ]
# model liniowy
model_lm = lm(price~carat, training)
validate_graphically = function(model_lm, testing, ...) {
  testing$predicted = predict(model_lm, testing, ...)
  ggplot(testing, aes(x = carat, y = price)) +
    geom_point() +
    geom_line(aes(y = predicted), color = "red")
}

model_lm2 = lm(price~., training)
validate_graphically(model_lm2, testing)

model_lm3 = lm(price~table+x+depth+carat, training)
validate_graphically(model_lm3, testing)


library("randomForest")
model_gbm = gbm::gbm(price~., data = training, 
                     distribution = "gaussian")
validate_graphically(model_gbm, testing, n.trees = 20)


