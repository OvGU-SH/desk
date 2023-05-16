#####
#' Rolling Window Analysis of a Time Series
#'
#' @description Helps to (visually) detect whether a time series is stationary or non-stationary. A time series is a data-generating process with every observation - as a random variable - following a distribution. When expectational value, variance, and covariance (between different points in time) are constant, the time series is indicated as weekly dependent and seen as stationary. This desired property is a requirement to overcome the problem of spurious regression. Since there is no distribution but only one observation for each point in time, adjacent observations will be used as stand-in to calculate the indicators. Therefore, the chosen window should not be too large.
#'
#' @param x a vector, usually a time series.
#' @param window the width of the window to calculate the indicator.
#' @param indicator character string specifying type of indicator: expected value (\code{"mean"}), variance (\code{"var"}) or covariance (\code{"cov"}).
#' @param tau number of lags to calculate the covariance. When not specified using \code{"cov"}, the variance is calculated.
#'
#' @return a vector of the calculated indicators.
#'
#' @export
#'
#' @importFrom stats var
#'
#' @note Objects generated by \code{roll.win()} can be plotted using the regular \code{plot()} command.
#'
#'
#' @examples
#' ## Plot the expected values with a window of width 5
#' exp.values <- roll.win(1:100, window = 5, indicator = "mean")
#' plot(exp.values)
#'
#' ## Spurious regression example
#' set.seed(123)
#' N <- 10^4
#' p.values <- rep(NA, N)
#'
#' for (i in 1:N) {
#'   x <- 1:100 + rnorm(100) # time series with trend
#'   y <- 1:100 + rnorm(100) # time series with trend
#'   p.values[i] <- summary(ols(y ~ x))$coef[2,4]
#' }
#' sum(p.values < 0.05)/N    # share of significant results (100%)
#'
#' for (i in 1:N) {
#'   x <- rnorm(100)         # time series without trend
#'   y <- 1:100 + rnorm(100) # time series with trend
#'   p.values[i] <- summary(ols(y ~ x))$coef[2,4]
#' }
#' sum(p.values < 0.05)/N    # share of significant results (~ 5%)
#'
#' @concept rolling window, stationarity, non-stationarity, weak dependence
#'
#####
roll.win <- function(x, window = 3, indicator = "mean", tau = NULL) {

  if (is.vector(x) == TRUE) {
    if (length(x) < window) {
      stop("The window is too large.", call. = F)
    }
    n <- length(x) - window + 1
  }
  else {
    stop("x has to be a vector.", call. = F)
  }
  out <- rep(NA, n)

  if (indicator == "mean") {
    for (i in 1:n) {
      out[i] <- mean(x[i:(i+window-1)])
    }
  }

  if (indicator == "var") {
    for (i in 1:n) {
      out[i] <- var(x[i:(i+window-1)])
    }
  }

  if (indicator == "cov") {
    n <- n - tau
    for (i in 1:n) {
      out[i] <- cov(x[i:(i+window-1)],x[(i+tau):(i+window-1+tau)])
    }
  }

  return(out)

}