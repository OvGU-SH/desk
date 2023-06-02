#####
#' Autocorrelation Coefficient
#'
#' @description Calculates the autocorrelation coefficient between a vector and its k-period lag.
#' This can be used as an estimator for rho in an AR(1) process.
#'
#' @param x a vector, usually residuals.
#' @param lag lag for which the autocorrelation should be calculated.
#'
#' @return Autocorrelation coefficient of lag k, numeric value.
#' @export
#'
#' @references NIST/SEMATECH e-Handbook of Statistical Methods,
#' \url{http://www.itl.nist.gov/div898/handbook/eda/section3/eda35c.htm}.
#'
#' @seealso \code{\link{lagk}}, \code{\link[stats]{acf}}.
#'
#' @examples
#' ## Simulate AR(1) Process with 30 observations and positive autocorrelation
#' X <- ar1sim(n = 30, u0 = 2.0, rho = 0.7, var.e = 0.1)
#' acc(X$u.sim, lag = 1)
#'
#' ## Equivalent result using acf (stats)
#' acf(X$u.sim, lag.max = 1, plot = FALSE)$acf[2]
#'
#' @concept autocorrelation
#' @concept autoregressive model
#' @concept AR1
#' @concept lagged variables
#'
#####
acc = function(x, lag = 1){
  n = length(x)
  x1 = x[1:(n-lag)]
  x2 = x[(lag+1):n]
  out = sum((x1 - mean(x)) * (x2 - mean(x))) / sum( (x - mean(x))^2 )
  return(out)
}
