#####
#' Check if Model has a Constant
#'
#' @description Checks if a linear model included a constant level parameter (alpha).
#'
#' @param mod linear model object of class \code{"desk"} or \code{"lm"}.
#'
#' @return A logical value: \code{TRUE} (has contant) or \code{FALSE} (has no constant).
#'
#' @export
#'
#' @examples
#' my.modA = ols(y ~ x, data = data.tip)
#' my.modB = ols(y ~ 0 + x, data = data.tip)
#' ols.has.const(my.modA)
#' ols.has.const(my.modB)
#'
#' @concept level parameter
#' @concept constant
#' @concept intercept
#' @concept linear model
#'
#####
ols.has.const = function(mod){
  if (attr(mod$terms,"intercept") == 0){
    return(FALSE)}
  if (attr(mod$terms,"intercept") == 1){
    return(TRUE)}
  }
