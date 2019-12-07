n = nrow(diamonds)
random_vector = sample(1:n,
                       n*.7)
training = diamonds[random_vector, ]
testing = diamonds[-random_vector, ]
# model liniowy
model_lm = lm(price~carat, training)
validate = function(model, training) {
  predicted_values = predict(model_lm, testing)
  ggplot(testing, aes(x = carat, y = price)) +
    geom_point() +
    geom_point(aes(y = predicted_values), color = "red")
}


# wyjaśnić skąd tyle predyktorów
model_lm = lm(price~., training)
validate(model_lm, testing)
