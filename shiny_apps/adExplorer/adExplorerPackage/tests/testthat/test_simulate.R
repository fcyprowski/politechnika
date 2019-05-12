context("simulate function")

auth_location = Sys.getenv("TEST_GCS_AUTH_LOCATION")
stopifnot(nchar(auth_location) < 1)
googleAuthR::gar_auth_service(
  auth_location, 
  scope = "https://www.googleapis.com/auth/devstorage.full_control"
)
test_that("simulate zwraca jedna wartosc i nie moze to byc wartosc ujemna", {
  output = simulate(input_df)
  expect_is(output, "numeric")
  expect_length(output, 1)
  expect_gte(output, 0)
})
test_that("Working directory doesnt affect simulate", {
  setwd("../../")
  expect_error(
    simulate(input_df),
    NA
  )
})