library(dplyr)  # data wrangling
library(ggplot2)  # exploratory data analysis
if (!require(e1071)) install.packages("e1071")
getwd()


# wczytywanie danych ------------------------------------------------------

train_set = read.csv("data/train.csv")
test_set = read.csv("data/test.csv")
# dataset = bind_rows(train_set, test_set)
# 
# # podsumowanie danych
# View(dataset)
# summary(dataset)
# ggplot2
ggplot(train_set, 
       aes(x = Age,
           fill = as.character(Survived)
       )
) +
  geom_density(alpha = .3)

sex_vs_survived = train_set %>%
  group_by(Sex, Survived) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(Sex) %>%
  mutate(percent = n/sum(n)) %>%
  ungroup()


sex_vs_class_vs_survived = train_set %>%
  group_by(Sex, Pclass, Survived) %>%
  summarise(n = n()) %>%
  ungroup()
ggplot(sex_vs_class_vs_survived, 
       aes(x = Sex, y = n, fill = as.character(Survived))) +
  geom_bar(stat = "identity", position = "fill") +
  facet_wrap(~Pclass)

ggplot(train_set, 
       aes(x = Age,
           fill = as.character(Survived))) +
  geom_density(alpha = .3) +
  facet_wrap(~Sex)

sibsp_vs_parch_vs_survived = train_set %>%
  group_by(SibSp, Parch, Survived) %>%
  summarise(n = n()) %>%
  ungroup()
ggplot(sibsp_vs_parch_vs_survived, 
       aes(x = Parch, y = n, fill = as.character(Survived))) +
  geom_bar(stat = "identity", position = "fill") +
  facet_wrap(~SibSp)

# feature engineering -----------------------------------------------------

if (!require(stringr)) install.packages("stringr")
library(stringr)
# nowe kolumny
final_train = train_set %>%
  mutate(title = str_extract(Name, ", .+\\.") %>%
           str_remove(", "),
         Age = round(ifelse(is.na(Age), mean(Age, na.rm = T), Age)),
         child = ifelse(Age < 10, TRUE, FALSE),
         family_size = Parch + SibSp + 1,
         Survived = as.factor(Survived))


# trenowanie modelu -------------------------------------------------------
library(caret)
split_vector = createDataPartition(final_train$Survived, p = .7)$Resample1
training = final_train[split_vector, ]
testing = final_train[-split_vector, ]

methods = c("rpart", "naive_bayes", "ctree", "rf")
tr_control = trainControl("cv", number = 10)

train_models = function(methods) {
  lapply(methods, function(x) {
    message(x)
    train(Survived~Sex+Pclass+family_size+child+title,
          data = training,
          trControl = tr_control,
          method = x)
  })
}
models = train_models(methods)
results = resamples(models)

models[[1]]
models[[2]]
models[[3]]
models[[4]]

testing = testing %>%
  filter(!(title %in% (unique(training$title) %>% setdiff(unique(testing$title)))),
         !(title %in% (unique(testing$title) %>% setdiff(unique(training$title)))))
testing$predicted = predict(models[[4]], testing)
confusionMatrix(testing$predicted, testing$Survived)
