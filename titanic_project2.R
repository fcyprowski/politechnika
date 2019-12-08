library(readr)  # wczytywanie danych
library(dplyr)  # przetwarzanie danych / feature engineering
library(stringr)
library(ggplot2)
library(caret)

# wczytywanie -------------------------------------------------------------
setwd("C:/Users/filip.cyprowski/Documents/politechnika")
train_set = read_csv("data/train.csv")

# library(readr)
# train_set <- read_csv("data/train.csv")


# feature engineering -----------------------------------------------------

processed_set = train_set %>%
  mutate(
    title = str_extract(Name, ", .+\\.") %>%
      str_remove(" ") %>%
      str_remove(",") %>%
      str_remove("\\..+"),
    title =  case_when(
        title %in% c("Dr.", "Major.", "Capt.", 
                     "Jonkheer.", "Rev.", "Mile.", "Col.") ~ "Officer",
        title %in% c("Lady", "Ms.", "Mme.", "the Countess.") ~ "Miss.",
        TRUE ~ title
      ),
    family_size = SibSp + Parch + 1,
    Survived = as.factor(Survived)
  )

# 1 tura EDA --------------------------------------------------------------

# Age vs Survived
ggplot(processed_set, aes(x = Age, fill = Survived)) +
  geom_density(alpha = .3)
# Age vs Sex vs Survived
ggplot(processed_set, aes(x = Age, fill = Survived)) +
  geom_density(alpha = .3) +
  facet_wrap(~Sex)
# czy title jest ok?
processed_set %>%
  group_by(title) %>%
  summarise(n = n()) %>%
  arrange(desc(n))
# Survived vs title
survived_vs_title = processed_set %>%
  group_by(title, Survived) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(title) %>%
  mutate(percent = n/sum(n)) %>%
  ungroup()
# survived vs title - plot
ggplot(survived_vs_title %>% filter(n > 2), 
       aes(x = title, y = percent, fill = Survived)) +
  geom_bar(stat = "identity")
# survived vs family_size
survived_vs_family_size = processed_set %>%
  group_by(family_size, Survived) %>%
  summarise(n = n()) %>%
  ungroup() %>%
  group_by(family_size) %>%
  mutate(percent = n/sum(n)) %>%
  ungroup()
ggplot(survived_vs_family_size %>% filter(n > 2), 
       aes(x = family_size, y = percent, fill = Survived)) +
  geom_bar(stat = "identity")
# survived vs title vs Pclass
survived_vs_title_vs_pclass = processed_set %>%
  group_by(title, Pclass, Survived) %>%
  summarise(n = n())
ggplot(survived_vs_title_vs_pclass %>% filter(n > 2), 
       aes(x = title, 
           y = n, 
           fill = Survived)) +
  geom_bar(stat = "identity", position = "fill") +
  facet_wrap(~Pclass)

# 2 tura feature engineering ----------------------------------------------

processed_set2 = processed_set %>%
  mutate(
    Age = ifelse(is.na(Age), mean(Age, na.rm = T), Age),
    Child = Age < 10
  )
final_set = processed_set2 %>%
  filter(title %in% c("Master.", "Miss.", "Mr.", "Mrs.", "Officer"))


# trenowanie modelu -------------------------------------------------------
# sprawdzamy zbalansowanie klas
final_set %>%
  group_by(Survived) %>%
  tally() %>%
  ungroup() %>%
  mutate(percent = n/sum(n))
# dzielenie setu
split_vector = createDataPartition(final_set$Survived, p = .7)[[1]]
trainig = final_set[split_vector, ]
testing = final_set[-split_vector, ]
# okreslanie metod
# https://topepo.github.io/caret/available-models.html
methods = c("LogitBoost", "rpart", 
            "ctree", "naive_bayes",
            "rf")
tr_control = trainControl("cv", number = 10)
train_models = function(formula, methods) {
  lapply(methods, 
         function(x) {
           message(x)
           train(formula,
                 data = trainig, 
                 method = x,
                 trControl = tr_control)
         })
}
models = train_models(Survived~Child+Sex+title+Pclass+family_size,
                      methods)
results = resamples(models)

models = train_models(Survived~Age+Sex+title+Pclass+family_size,
                      methods)
results = resamples(models)

# walidacja
testing$predictions = predict(models[[5]], testing)
confusionMatrix(testing$predictions, testing$Survived)
