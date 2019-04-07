simulate = function(input_df) {
  library(assertthat)
  assert_that(
    is.data.frame(input_df),
    has_name(input_df, "creative_id"),
    has_name(input_df, "n")
  )
  model = readModel()
  predictions = predict(model, input_df) %>%
    sum()
  return(predictions)
}
readModel = function() {
  readRDS("../../../model.rds")
}