#####
#' Jarque-Bera Test
#'
#' @description Jarque-Bera test for normality. The object of test results returned by this command can be plotted using the \code{plot()} function.
#'
#' @param x a numeric vector, an estimated linear model object or model formula (with \code{data} specified). In the two latter cases the model's residuals are tested for normality.
#' @param data if \code{mod} is a formula then the corresponding data frame has to be specified.
#' @param sig.level significance level. Default value: \code{sig.level = 0.05}.
#' @param details logical value indicating whether specific details about the test should be returned.
#' @param hyp logical value indicating whether the hypotheses should be returned.
#'
#' @details
#' Under H0 the test statistic of the Jarque-Bera test follows a chi-squared distribution with 2 degrees of freedom. If moment of order 3 (skewness) differs significantly from 0 and/or moment of order 4 (kurtosis) differs significantly from 3, H0 is rejected.
#'
#' @return A list object including:
#' \tabular{ll}{
#' \code{hyp} \tab character matrix of hypotheses (if \code{hyp = TRUE}).\cr
#' \code{results} \tab a data frame of basic test results.\cr
#' \code{skew} \tab moment of order 3 (asymmetry, skewness).\cr
#' \code{kur} \tab moment of order 4 (kurtosis).\cr
#' \code{nobs} \tab number of observations (internal purpose).\cr
#' \code{nulldist} \tab type of the Null distribution and its parameter(s).\cr
#' }
#'
#' @export
#'
#' @references
#' Jarque, C.M. & Bera, A.K. (1980): Efficient Test for Normality, Homoscedasticity and Serial Independence of Residuals. Economics Letters 6 Issue 3, 255-259.
#'
#' @seealso \code{\link[moments]{jarque.test}}.
#'
#' @examples
#' ## Test response variable for normality
#' X <- jb.test(data.income$loginc)
#' X
#'
#' ## Estimate linear model
#' income.est <- ols(loginc ~ logsave + logsum, data = data.income)
#' ## Test residuals for normality, print details
#' jb.test(income.est, details = TRUE)
#'
#' ## Equivalent test
#' jb.test(loginc ~ logsave + logsum, data = data.income, details = TRUE)
#'
#' ## Plot the test result
#' plot(X)
#'
#' @concept normality
#' @concept normal distribution
#' @concept test
#'
#####
jb.test = function(x, data = list(), sig.level = 0.05, details = FALSE, hyp = TRUE){

  if (inherits(x, "lm")){ # if x is a fitted lm object ...
    x = x$residuals
  } else if (inherits(x, "formula")){ # if x is a formula...
    X = model.matrix(x, data = data)
    y = model.response(model.frame(x, data = data))
    x = lm.fit(X,y)$residuals
  } else if (is.vector(x) & is.numeric(x)){ # if x is a numeric vector...
    x = x
  } else stop("Argument not recognized!", call. = F)

  asym = function (x, na.rm = FALSE) {
    n = length(x)
    (sum((x - mean(x))^3)/n)/(sum((x - mean(x))^2)/n)^(3/2)
  }

  kur = function (x) {
    n = length(x)
    n * sum((x - mean(x))^4)/(sum((x - mean(x))^2)^2)
  }

  n = length(x)
  K = kur(x)
  A = asym(x)
  JB = (n/6) * (A^2 + 0.25 * ((K - 3)^2))

  if (hyp){
    H = c("skew = 0 and kur = 3 (norm.)", "skew <> 0 or kur <> 3 (non-norm.)")
    names(H) = c("H0:", "H1:")
    H = t(H)
  } else {
    H = NULL
  }

  ## Generate other data
  chi2.crit = qchisq(1 - sig.level, df = 2)
  p.val = 1 - pchisq(JB, df = 2)

  test.result = if (p.val < sig.level) "rejected" else "not rejected"
  results = data.frame(JB = JB,
                       crit.value = chi2.crit,
                       p.value = p.val,
                       sig.level = sig.level,
                       H0 = test.result,
                       row.names = "")

  out = list()
  attr(out, "title") = "Jarque-Bera test for normality"
  out$hyp = H # Null and alternative hypothesis
  out$results = results # Basic test results
  out$skew = A
  out$kur = K
  out$nobs = n
  out$nulldist = list(type = "chisq", df = 2)

  attr(out, "direction") = "right"
  attr(out, "details") = if (details) {T} else {F}
  attr(out, "type") = "htest"
  attr(out, "test.type") = "jbtest"
  class(out) = c("desk")

  return(out)
  }
