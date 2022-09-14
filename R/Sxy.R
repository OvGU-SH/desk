#' Variation and Covariation
#'
#' @description Calculates the variation of one variable or the covariation of two different variables.
#'
#' @param x vector of one variable.
#' @param y vector of another variable (optional). If specified then the covariation of \code{x} and \code{y} is calculated. If ommitted then the variation of \code{x} is calculated.
#' @param na.rm a logical value indicating whether NA values should be stripped before the computation proceeds.
#'
#' @return The variaion of \code{x} or the covariation of \code{x} and \code{y}.
#'
#' @export
#'
#' @examples
#' x = c(1, 2)
#' y = c(4, 1)
#' Sxy(x) # variation
#' Sxy(x, y) # covariation
#'
#' ## Second example illustrating the na.rm option
#' x = c(1, 2, NA, 4)
#' Sxy(x)
#' Sxy(x, na.rm = TRUE)
#'
Sxy = function(x, y = x, na.rm = FALSE){
  if(na.rm){
    x = na.omit(x)
    y = na.omit(y)
  }
  if(length(x) == length(y)){
  return(sum( (x - mean(x)) * (y - mean(y))))
  } else {
  cat("Variables must have same length!")
  }
}
