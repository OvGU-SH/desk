#####
#' 1 to k-Period Lags of Given Vector
#'
#' @description Generates a matrix of a given vector and its 1 to k-period lags. Missing values due to lag are filled with NAs.
#'
#' @param u a vector of one variable, usually residuals.
#' @param lag the number of periods up to which lags should be generated.
#' @param delete logical value indicating whether missing data should be eliminated from the resulting matrix.
#'
#' @return Matrix of vector \code{u} and its 1 to k-period lags.
#' @export
#'
#' @examples
#' u = round(rnorm(10),2)
#' lagk(u)
#' lagk(u,lag = 3)
#' lagk(u,lag = 3, delete = FALSE)
#'
#' @concept lag
#' @concept heteroscedasticity
#' @concept lagged residuals
#'
#####
lagk = function(u, lag = 1, delete = TRUE){
  n = length(u)
  out = matrix(NA, n, lag)
  for (i in 1:lag){
    out[(i+1):n, i] = u[1:(n-i)]
  }
  out = cbind(u, out)
  dimnames(out) = list(1:n, paste0("lag", 0:lag))
  if (delete) out = out[(lag+1):n,]
  return(out)
}
