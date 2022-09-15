#' Breusch-Pagan Test
#'
#' @description Breusch-Pagan test for heteroskedastic errors. The object of test results returned by this command can be plotted using the \code{plot()} function.
#'
#' @param mod estimated linear model object or formula.
#' @param data if \code{mod} is a formula then the corresponding data frame has to be specified.
#' @param varmod formula object (starting with tilde ~) specifying the terms of regressors that explain sigma squared for each observation. If not specified the regular model \code{mod} is used.
#' @param koenker logical value specifying whether Koenker's studentized version or the original Breusch-Pagan test should be performed.
#' @param sig.level significance level. Default value: \code{sig.level = 0.05}.
#' @param details logical value indicating whether specific details about the test should be returned.
#' @param hyp logical value indicating whether the Hypotheses should be returned.
#'
#' @return List object including:
#' \tabular{ll}{
#' \code{hyp} \tab character matrix of hypotheses (if \code{hyp = TRUE}).\cr
#' \code{results} \tab a data frame of basic test results.\cr
#' \code{hreg} \tab matrix of aux. regression results..\cr
#' \code{stats} \tab additional statistic of aux. regression..\cr
#' \code{nulldist} \tab type of the Null distribution with its parameters.\cr
#' }
#'
#' @export
#'
#' @references
#' Breusch, T.S. & Pagan, A.R. (1979): A Simple Test for Heteroscedasticity and Random Coefficient Variation. Econometrica 47, 1287-1294.
#'
#' Koenker, R. (1981): A Note on Studentizing a Test for Heteroscedasticity. Journal of Econometrics 17, 107-112.
#'
#' @seealso \code{\link{wh.test}}, \code{\link[lmtest]{bptest}}.
#'
#' @examples
#' ## BP test with Koenker's studentized residuals
#' X <- bp.test(wage ~ educ + age, data = data.wage, koenker = FALSE)
#' X
#'
#' ## A white test for the same model (auxiliary regression specified by \code{varmod})
#' bp.test(wage ~ educ + age, varmod = ~ (educ + age)^2 + I(educ^2) + I(age^2), data = data.wage)
#'
#' ## Similar test
#' wh.test(wage ~ educ + age, data = data.wage)
#'
#' ## Plot the test result
#' plot(X)
#'
#' @concept heteroskedasticity, Breuch Pagan test, non-constant error variance
#'
bp.test = function(mod,
                   data = list(),
                   varmod = NULL,
                   koenker = TRUE,
                   sig.level = 0.05,
                   details = FALSE,
                   hyp = TRUE){

  if (!inherits(mod, "formula")) { # Wenn Modell uebergeben ...
    X = model.matrix(terms(mod), model.frame(mod))
    y = model.response(model.frame(mod))
    Z = if (is.null(varmod)) {X} else {model.matrix(varmod, data = data)}
  }
  else { # Wenn Formel uebergeben ...
    mf = model.frame(mod, data = data)
    y = model.response(mf)
    X = model.matrix(mod, data = data)
    Z = if (is.null(varmod)) {X} else {model.matrix(varmod, data = data)}
  }

  # Wenn varmod nicht alle Exogenen enthaelt...
  if (!(all(c(row.names(X) %in% row.names(Z), row.names(Z) %in%
                row.names(X))))) {
    allnames = row.names(X)[row.names(X) %in% row.names(Z)]
    X = X[allnames, ]
    Z = Z[allnames, ]
    y = y[allnames]
  }

  n = nrow(X) # Number of observations
  k = ncol(X) # Number of coefs

  ## Original model
  resid = lm.fit(X, y)$residuals # residuals from original model
  w = resid^2/mean(resid^2) # standardized residuals

  # Introduce constant to aux model if orig. model had no intercept
  if(any(X[,1] != 1)){Z = cbind(1,Z)}

  ## Auxiliary model
  aux = lm.fit(Z, w)
  ssr = sum(aux$residuals^2)
  sig.hat = ssr/aux$df.residual
  VC = sig.hat * chol2inv(chol(t(Z) %*% Z))

  ## Test statistic
  if (koenker){
    bp = n * Sxy(aux$fitted)/Sxy(w) # n * R^2
    title = "Breusch-Pagan test (Koenker's version)"
  } else {
    # bp = bp * (n-1)/n * var(resid^2) / (2*((n-1)/n * var(resid))^2)
    title = "Breusch-Pagan test (original version)"
    bp = (Sxy(w) - Sxy(aux$resid))/2
  }

  # Generate aux. reg. table
  hreg = matrix(NA, ncol(Z), 4)
  hreg[,1] = aux$coefficients
  hreg[,2] = sqrt(diag(VC))
  hreg[,3] = aux$coefficients/sqrt(diag(VC))
  hreg[,4] = 2*pt(-abs(hreg[,3]), df = aux$df.residual)
  colnames(hreg) = c("coef", "std.err", "t.value", "p.value")
  rownames(hreg) = names(aux$coefficients)

  # Generate aux. reg. details
  stats = matrix(NA, 4L, 1L)
  stats[1] = length(y)
  stats[2] = aux$df.residual
  stats[3] = ssr
  stats[4] = sig.hat
  dimnames(stats) = list(c("Number of observations", "Degrees of freedom", "Sum of squ. resid.", "sigma2 (est.)")," ")

  if (hyp){
    H = c("sig2(t) = sig2 (Homosked.)", "sig2(t) <> sig2 (Heterosked.)")
    names(H) = c("H0:", "H1:")
    H = t(H)
  } else {
    H = NULL
  }

  df = ncol(Z) - 1
  chi.crit = qchisq(1 - sig.level, df)
  p.val = 1 - pchisq(bp, df)


  ## Generate other data
  test.result = if (p.val < sig.level) "rejected" else "not rejected"
  results = data.frame(chi.value = bp,
                       crit.value = chi.crit,
                       p.value = p.val,
                       sig.level = sig.level,
                       H0 = test.result,
                       row.names = "")

  out = list()
  attr(out, "title") = title
  out$hyp = H # Null and alternative hypothesis
  out$results = results # Basic test results
  out$hreg = hreg
  out$stats = stats
  out$nulldist = list(type = "chisq", df = df)

  attr(out, "direction") = "right"
  attr(out, "details") = if (details) {T} else {F}
  attr(out, "type") = "htest"
  attr(out, "test.type") = "bptest"
  class(out) = c("desk")

  return(out)
}
