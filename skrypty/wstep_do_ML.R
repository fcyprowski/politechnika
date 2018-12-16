head(mtcars)
set.seed(99)
prob = .7
wektor = sample(1:nrow(mtcars), size = nrow(mtcars) * prob)
training = mtcars[wektor, ]
testing = mtcars[-wektor, ]

# dopasowanie modelu
model = lm(mpg ~ disp + hp + wt, data = training)
model2 = randomForest::randomForest(mpg ~ disp + hp + wt,
                                    data = training)
df = data.frame(
  index = 1:500,
  mse = model2$mse
)
ggplot(df) +
  geom_line(aes(x = mse, y = index, group = 1))

# walidacja
predicted.values = predict(model, testing)
predicted.values.dummy = mean(testing$mpg)

testing$mpg_predicted = predicted.values
testing$mpg_mean = predicted.values.dummy
testing$mpg_rf = predict(model2, testing)

# jak dobrze dzialal model
# MSE - Mean Squared Error
mean((testing$mpg - testing$mpg_predicted) ^ 2) %>% sqrt()
mean((testing$mpg - testing$mpg_mean) ^ 2) %>% sqrt()
mean((testing$mpg - testing$mpg_rf) ^ 2) %>% sqrt()

