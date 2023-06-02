#####
#' Lambda Deformed Logarithm
#'
#' @description Calculates the lambda deformed logarithm.
#'
#' @param x a numeric value.
#' @param lambda deformation parameter. Default value: \code{lambda = 0} (natural log).
#' @param normalize normalization (internal purpose).
#'
#' @return The function value of the lambda deformed logarithm at x.
#'
#' @export
#'
#' @seealso \code{\link{def.exp}}.
#'
#' @examples
#' def.log(3)   # Natural log of 3
#' def.log(3,2) # Deformed by lambda = 2
#'
#' @concept deformation
#' @concept logarithm
#'
#####
def.log = function(x, lambda = 0, normalize = FALSE){
  if(normalize){
      corr = (exp(mean(log(x))))^(lambda - 1)
  } else {
    corr = 1
  }
  if(lambda == 0)
    xt = log(x)/corr
  else
    xt = (x^lambda - 1)/(corr*lambda)
  return(xt)
}
