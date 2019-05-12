
model = rpart::rpart(Species~., data = iris)
saveRDS(model, "model.rds")