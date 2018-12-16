context("We are really testing it")

test_that('square() is returning square!', {
  expect_equal(square(5), 25)
  expect_equal(square(2), 4)
})