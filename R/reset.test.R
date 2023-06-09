#####
#' RESET Method for Non-linear Functional Form
#'
#' @description Ramsey's RESET for non-linear functional form. The object of test results returned by this command can be plotted using the \code{plot()} function.
#'
#' @param mod estimated linear model object or formula.
#' @param data if \code{mod} is a formula then the corresponding data frame has to be specified.
#' @param m the number of non-linear terms of fitted y values that should be included in the extended model. Default is \code{m = 2}, i.e. to add \eqn{\widehat{y}^2} and \eqn{\widehat{y}^3}.
#' @param sig.level significance level. Default value: \code{sig.level = 0.05}.
#' @param details logical value indicating whether specific details about the test should be returned.
#' @param hyp logical value indicating whether the Hypotheses should be returned.
#'
#' @return A list object including:
#' \tabular{ll}{
#' \code{hyp} \tab character matrix of hypotheses (if \code{hyp = TRUE}).\cr
#' \code{results} \tab a data frame of basic test results.\cr
#' \code{SSR0} \tab	SSR of the H0-model.\cr
#' \code{SSR1} \tab	SSR of the extended model.\cr
#' \code{L} \tab numbers of parameters tested in H0.\cr
#' \code{nulldist} \tab	null distribution of the test.\cr
#' }
#'
#' @export
#'
#' @references
#' Ramsey, J.B. (1969): Tests for Specification Error in Classical Linear Least Squares Regression Analysis. Journal of the Royal Statistical Society, Series B 31, 350-371.
#'
#' @seealso \code{\link[lmtest]{resettest}}.
#'
#' @examples
#' ## Numerical illustration 14.2. of the textbook
#' X <- reset.test(milk ~ feed, m = 4, data = data.milk)
#' X
#'
#' ## Plot the test result
#' plot(X)
#'
#' @concept RESET
#' @concept specification
#' @concept functional form
#'
#####
reset.test = function (mod,
                       data = list(),
                       m = 2,
                       sig.level = 0.05,
                       details = FALSE,
                       hyp = TRUE){

  power = 2:(m+1)
  if (!inherits(mod, "formula")) { # Wenn Modell übergeben ...
    X = model.matrix(terms(mod), model.frame(mod))
    y = model.response(model.frame(mod))
  }
  else { # Wenn Formel übergeben ...
    mf = model.frame(mod, data = data)
    y = model.response(mf)
    X = model.matrix(mod, data = data)
  }

  n = nrow(X) # Number of observations
  k = ncol(X) # Number of coefs

  y.hat = lm.fit(X, y)$fitted
  Z = matrix(t(sapply(y.hat, "^", power)), nrow = n)

  XZ = cbind(X, Z)
  L = ncol(Z) # Number of extended coefficients (gamma)
  SSR0 = sum(lm.fit(X, y)$residuals^2)
  SSR1 = sum(lm.fit(XZ, y)$residuals^2)
  df1 = L
  df2 = n - (k + L)
  f.val = (df2/df1) * ((SSR0 - SSR1)/SSR1)

  if (hyp){
    H = c("gammas = 0 (linear)", "gammas <> 0 (non-linear)")
    names(H) = c("H0:", "H1:")
    H = t(H)
  } else {
    H = NULL
  }

  f.crit = qf(1 - sig.level, df1, df2)
  p.val = 1 - pf(f.val, df1, df2)

  test.result = if (p.val < sig.level) "rejected" else "not rejected"
  results = data.frame(f.value = f.val,
                       crit.value = f.crit,
                       p.value = p.val,
                       sig.level = sig.level,
                       H0 = test.result,
                       row.names = "")

  out = list()
  attr(out, "title") = "RESET Method for nonlinear functional form"
  out$hyp = H # Null and alternative hypothesis
  out$results = results # Basic test results
  out$SSR0 = SSR0 # SSR NH-model
  out$SSR1 = SSR1 # SSR extended model
  out$L = L # Number of lin. comb. tested
  out$nulldist = list(type = "f", df = c(df1,df2))

  attr(out, "direction") = "right"
  attr(out, "details") = if (details) {T} else {F}
  attr(out, "type") = "htest"
  attr(out, "test.type") = "resettest"
  class(out) = c("desk")

  return(out)
}
