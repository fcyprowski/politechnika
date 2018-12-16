#' @title The function says it, dumbass
#'
#' @param x vector you want to square
#'
#' @return numeric value - surprise, surprise - squared!
#' @export square
#'
#' @examples
#' square(5)
square = function(x) {
  stopifnot(is.numeric(x))
  x ^ 2
}
#' @importFrom dplyr mutate
#' @importFrom magrittr %>%
messWithIris = function(hahaha = sample(1:100, 1)) {
  some_random_number = sample(
    seq(0, 4.5, by = .1), 1
  )
  cat("I hate iris :/")
  iris %>%
    mutate(
      Sepal.Length = ifelse(
        Petal.Length >= some_random_number,
        Sepal.Length * Petal.Length,
        Sepal.Width * hahaha
        )
    )
}



messWithIris = function(hahaha = sample(1:100, 1)) {
  library(dplyr)
  some_random_number = sample(
    seq(0, 4.5, by = .1), 1
  )
  cat("I hate iris :/")
  iris %>%
    mutate(
      Sepal.Length = ifelse(
        Petal.Length >= some_random_number,
        Sepal.Length * Petal.Length,
        Sepal.Width * hahaha
      )
    )
}