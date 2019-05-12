# ladowanie danych
load("../../data/display_data.RData")
# przetwarzanie danych
library(dplyr)
input_df = display_data %>%
  group_by(creative_id) %>%
  summarise(n = n())
# konstruowanie modelu
data_for_modelling = display_data %>%
  group_by(day, creative_id) %>%
  summarise(conversions = sum(conversion),
            n = n()) %>%
  ungroup() %>%
  select(-day)

library(caret)
model1 = lm(conversions~., data = data_for_modelling)
saveRDS(model1, "model.rds")
# model = train(conversions~., 
#               data = data_for_modelling,
#               method = "glm")

# zarys funkcji
simulate = function(input_df) {
  library(assertthat)
  assert_that(
    is.data.frame(input_df),
    has_name(input_df, "creative_id"),
    has_name(input_df, "n")
  )
  
}
# test
if (!require(testthat)) install.packages("testthat")
library(testthat)

test_that("simulate zwraca jedna wartosc i nie moze to byc wartosc ujemna", {
  output = simulate(input_df)
  expect_is(output, "numeric")
  expect_length(output, 1)
  expect_gte(output, 0)
})
