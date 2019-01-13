require(caret)
# Przy plikach RData
load("final_model.RData")
iris$predicted = predict(final_model, iris)
# przy plikach rds
model = readRDS("final_model.rds")
iris$predicted = predict(model, iris)