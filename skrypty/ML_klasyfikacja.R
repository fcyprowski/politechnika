library(caret)

split_vector = createDataPartition(iris$Species, p = .7)[[1]]
train_set = iris[split_vector, ]
test_set = iris[-split_vector, ]

# trenujemy!!!
methods = c("ctree", "rpart", "naive_bayes")
tr_control = trainControl(method = "cv",
                          number = 10, 
                          search = "random")

train_trees = function(formula, methods) {
  lapply(methods, function(x) {
    message(x)
    train(form = formula, 
          data = train_set,
          method = x,
          trControl = tr_control)
  })
}
trees = train_trees(Species~., 
                    methods = methods)
all_results = resamples(trees)

test_set$predicted = predict(trees[[3]], test_set)
confusionMatrix(test_set$predicted, test_set$Species)

