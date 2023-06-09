#####
#' Box-Cox Test
#'
#' @description Box-Cox test for functional form. Compares a base model with non transformed endogenous variable to a model with logarithmic endogenous variable. Exogenous variables can be transformed or non-transformed. The object of test results returned by this command can be plotted using the \code{plot()} function.
#'
#' @param basemod estimated linear model object or formula taken as the base model for comparison. Has to have a non-transformed endogenous variable.
#' @param data if \code{mod} is a formula then the corresponding data frame has to be specified.
#' @param exo vector or matrix of transformed exogenous variables to be used in the comparison model. If not specified the same variables from the base model are used ("same").
#' @param sig.level significance level. Default value: \code{sig.level = 0.05}.
#' @param details logical value indicating whether specific details about the test should be returned.
#' @param hyp logical value indicating whether the Hypotheses should be returned.
#'
#' @return A list object including:
#' \tabular{ll}{
#' \code{hyp} \tab character matrix of hypotheses (if \code{hyp = TRUE}).\cr
#' \code{results} \tab a data frame of basic test results.\cr
#' \code{stats} \tab additional statistic of aux. regression.\cr
#' \code{nulldist} \tab type of the Null distribution with its parameters.\cr
#' }
#'
#' @export
#'
#' @importFrom stats qchisq pchisq
#'
#' @references
#' Box, G.E.P. & Cox, D.R. (1964): An Analysis of Transformations. Journal of the Royal Statistical Society, Series B. 26, 211-243.
#'
#' @seealso \code{\link[MASS]{boxcox}}.
#'
#' @examples
#' ## Box-Cox test between a semi-logarithmic model and a logarithmic model
#' semilogmilk.est <- ols(milk ~ log(feed), data = data.milk)
#' results <- bc.test(semilogmilk.est, details = TRUE)
#'
#' ## Plot the test results
#' plot(results)
#'
#' ## Example with transformed exogenous variables
#' lin.est <- ols(rent ~ mult + mem + access, data = data.comp)
#' A <- lin.est$data
#' bc.test(lin.est, exo = log(cbind(A$mult, A$mem, A$access)))
#'
#' @concept htest
#'
#####
bc.test = function(basemod, data = list(), exo = "same", sig.level = 0.05, details = TRUE, hyp = TRUE){

  if (!inherits(basemod, "formula")) { # Wenn Modell übergeben ...
    mf = model.frame(basemod)
    X = model.matrix(terms(basemod), mf)
    y = model.response(model.frame(basemod))
  }
  else { # Wenn Formel übergeben ...
    mf = model.frame(basemod, data = data)
    y = model.response(mf)
    X = model.matrix(basemod, data = data)
  }

  xname = colnames(mf)[2]
  n = nrow(X) # Number of observations
  k = ncol(X) # Number of coefs

  # Basismodell (immer lineare Exogene)
  u = lm.fit(X,y)$resid
  Suu.std = sum((u-mean(u))^2)/exp(mean(log(y)))^2 # standardize SSR

  if (any(exo == "same")){
    X.tr = X
    } else {
      if(is.numeric(exo) | is.matrix(exo)){
        X.tr = cbind(attr(basemod$terms,"intercept"), exo)
      } else {stop("You need to specify an existing transformed data matrix or vector in argument exo.", call. = F)}
  }

  # Vergleichsmodell (immer logarithmische Exogene)
  y.tr = log(y)
  u.star = lm.fit(X.tr, y.tr)$resid
  Suu.star = sum((u.star-mean(u.star))^2)

  # Teststatistik
  l = n/2*abs(log(Suu.std/Suu.star))

  if (hyp){
    H = c("SSR.base = SSR.star", "SSR.base <> SSR.star")
    names(H) = c("H0:", "H1:")
    H = t(H)
  } else {
    H = NULL
  }

  chi.crit = qchisq(1 - sig.level, 1)
  p.val = 1 - pchisq(l, 1)

  title = "Box-Cox test"

  ## Generate other data
  test.result = if (p.val < sig.level) "rejected" else "not rejected"
  results = data.frame(chi.value = l,
                       crit.value = chi.crit,
                       p.value = p.val,
                       sig.level = sig.level,
                       H0 = test.result,
                       row.names = "")

  # Generate details
  stats = matrix(NA, 2L, 1L)
  stats[1] = Suu.std
  stats[2] = Suu.star
  dimnames(stats) = list(c("Standardized SSR of base model", "SSR of model with logarithmic endogenous var.")," ")

  out = list()
  attr(out, "title") = title
  out$hyp = H # Null and alternative hypothesis
  out$results = results # Basic test results

  out$hreg = NULL
  out$stats = stats
  out$nulldist = list(type = "chisq", df = 1)

  attr(out, "direction") = "right"
  attr(out, "details") = if (details) {T} else {F}
  attr(out, "type") = "htest"
  attr(out, "test.type") = "bctest"
  class(out) = c("desk")

  return(out)
}
