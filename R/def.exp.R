#####
#' Lambda Deformed Exponential
#'
#' @description Calculates the lambda deformed exponential.
#'
#' @param x a numeric value.
#' @param lambda deformation parameter. Default value: \code{lambda = 0} (regular exponential).
#' @param normalize logical value to indicate normalization.
#'
#' @return The function value of the lambda deformed exponential at x.
#'
#' @export
#'
#' @seealso \code{\link{def.log}}.
#'
#' @examples
#' def.exp(3)   # Natural exponential of 3
#' def.exp(3,2) # Deformed by lambda = 2
#'
#' @concept deformation, exponential
#'
#####
def.exp = function(x, lambda = 0, normalize = FALSE){
  if(normalize){
      corr = (exp(mean(log(x))))^(lambda - 1)
  } else {
    corr = 1
  }
  if(lambda == 0){
    xt = exp(x)/corr
  } else {
    xt = (corr*x*lambda + 1)^(1/lambda)
  }
  return(xt)
}
