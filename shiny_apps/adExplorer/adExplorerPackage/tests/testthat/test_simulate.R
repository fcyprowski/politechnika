context("simulate function")

test_that("simulate zwraca jedna wartosc i nie moze to byc wartosc ujemna", {
  output = simulate(input_df)
  expect_is(output, "numeric")
  expect_length(output, 1)
  expect_gte(output, 0)
})