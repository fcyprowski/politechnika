#' @importFrom assertthat assert_that
#' @importFrom assertthat has_name
#' @importFrom googleCloudStorageR gcs_get_object

bucket = "ad_explorer_shiny_pb"

#' Simulate result given data
#'
#' @param input_df data.frame with creative_id and n
#'
#' @return numeric of length 1
#' @export simulate
simulate = function(input_df) {
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
authorizeAdExplorerGCS = function(auth_location) {
  googleAuthR::gar_auth_service(
    auth_location, 
    scope = "https://www.googleapis.com/auth/devstorage.full_control"
  )
}
readModel = function() {
  model_filename = "model.rds"
  gcs_get_object(model_filename, 
                 bucket,
                 saveToDisk = model_filename,
                 overwrite = TRUE)
  model = readRDS(model_filename)
  file.remove(model_filename)
  return(model)
}