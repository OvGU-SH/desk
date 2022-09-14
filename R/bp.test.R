#' Breusch-Pagan Test
#'
#' @description Breusch-Pagan test for heteroskedastic errors. The object of test results returned by this command can be plotted using the \code{plot()} function.
#'
#' @param mod estimated linear model object or formula.
#' @param data if \code{mod} is a formula then the corresponding dataframe has to be specified.
#' @param varmod formula object (starting with tilde ~) specifying the terms of regressors that explain sigma squared for each observation. If not specified the regular model \code{mod} is used.
#' @param koenker logical value specifying whether Koenker's studentized version or the original Breusch-Pagan test should be performed.
#' @param sig.level significance level. Default value: \code{sig.level = 0.05}.
#' @param details logical value indicating whether specific details about the test should be returned.
#' @param hyp logical value indicating whether the Hypotheses should be returned.
#'
#' @return List object including:
#' \tabular{ll}{
#' \code{hyp} \tab character matrix of hypotheses (if \code{hyp = TRUE}).\cr
#' \code{results} \tab a dataframe of basic test results.\cr
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
#' #> $hyp
#' #>      H0:                          H1:
#' #> [1,] "sig2(t) = sig2 (Homosked.)" "sig2(t) <> sig2 (Heterosked.)"
#' #>
#' #> $results
#' #>  chi.value crit.value     p.value sig.level       H0
#' #>   13.44889   5.991465 0.001201186      0.05 rejected
#' #>
#' #> $hreg
#' #>                    coef    std.err  t.value    p.value
#' #> (Intercept) -1.96333877 1.13700095 -1.72677 0.10233361
#' #> educ         0.16929646 0.14649074  1.15568 0.26379682
#' #> age          0.05820528 0.03163742  1.83976 0.08333218
#' #>
#' #> $stats
#' #>
#' #> Number of observations 20.000000
#' #> Degrees of freedom     17.000000
#' #> Sum of squ. resid.     45.767858
#' #> sigma2 (est.)           2.692227
#' #>
#' #> $nulldist
#' #> $nulldist$type
#' #> [1] "chisq"
#' #>
#' #> $nulldist$df
#' #> [1] 2
#' #>
#' #>
#' #> attr(,"title")
#' #> [1] "Breusch-Pagan test (original version)"
#' #> attr(,"direction")
#' #> [1] "right"
#' #> attr(,"details")
#' #> [1] FALSE
#' #> attr(,"type")
#' #> [1] "htest"
#' #> attr(,"test.type")
#' #> [1] "bptest"
#' #> attr(,"class")
#' #> [1] "desk"
#'
#' ## A white test for the same model (auxiliary regression specified by \code{varmod})
#' bp.test(wage ~ educ + age, varmod = ~ (educ + age)^2 + I(educ^2) + I(age^2), data = data.wage)
#' #> $hyp
#' #>      H0:                          H1:
#' #> [1,] "sig2(t) = sig2 (Homosked.)" "sig2(t) <> sig2 (Heterosked.)"
#' #>
#' #> $results
#' #>  chi.value crit.value    p.value sig.level       H0
#' #>   14.18569    11.0705 0.01447192      0.05 rejected
#' #>
#' #> $hreg
#' #>                      coef     std.err      t.value     p.value
#' #> (Intercept)  0.1206767038 2.620027788  0.046059322 0.963913530
#' #> educ        -0.1208914111 0.489006685 -0.247218320 0.808327856
#' #> age         -0.0001395378 0.137171769 -0.001017249 0.999202706
#' #> I(educ^2)   -0.1319749196 0.044670040 -2.954439254 0.010453628
#' #> I(age^2)    -0.0012245961 0.001937493 -0.632051718 0.537538626
#' #> educ:age     0.0381454099 0.011471242  3.325307681 0.005003863
#' #>
#' #> $stats
#' #>
#' #> Number of observations 20.00000
#' #> Degrees of freedom     14.00000
#' #> Sum of squ. resid.     21.12502
#' #> sigma2 (est.)           1.50893
#' #>
#' #> $nulldist
#' #> $nulldist$type
#' #> [1] "chisq"
#' #>
#' #> $nulldist$df
#' #> [1] 5
#' #>
#' #>
#' #> attr(,"title")
#' #> [1] "Breusch-Pagan test (Koenker's version)"
#' #> attr(,"direction")
#' #> [1] "right"
#' #> attr(,"details")
#' #> [1] FALSE
#' #> attr(,"type")
#' #> [1] "htest"
#' #> attr(,"test.type")
#' #> [1] "bptest"
#' #> attr(,"class")
#' #> [1] "desk"
#'
#' ## Similar test
#' wh.test(wage ~ educ + age, data = data.wage)
#' #> $hyp
#' #>      H0:                          H1:
#' #> [1,] "sig2(t) = sig2 (Homosked.)" "sig2(t) <> sig2 (Heterosked.)"
#' #>
#' #> $results
#' #>  chi.value crit.value    p.value sig.level       H0
#' #>   14.18569    11.0705 0.01447192      0.05 rejected
#' #>
#' #> $hreg
#' #>                   Coeff.    Std. Err.      t-value     p-value
#' #> (Intercept)  5778.592573 125459.78338  0.046059322 0.963913530
#' #> I(educ^2)   -6319.606569   2139.02065 -2.954439254 0.010453628
#' #> I(age^2)      -58.639668     92.77669 -0.632051718 0.537538626
#' #> educ        -5788.873814  23416.03894 -0.247218320 0.808327856
#' #> age            -6.681755   6568.45724 -0.001017249 0.999202706
#' #> educ:age     1826.589355    549.29935  3.325307681 0.005003863
#' #>
#' #> $stats
#' #>
#' #> Number of observations          20
#' #> Degrees of freedom              14
#' #> Sum of squ. resid.     48438920020
#' #> sigma2 (est.)           3459922859
#' #>
#' #> $nulldist
#' #> $nulldist$type
#' #> [1] "chisq"
#' #>
#' #> $nulldist$df
#' #> [1] 5
#' #>
#' #>
#' #> attr(,"title")
#' #> [1] "White test for heteroskedastic errors"
#' #> attr(,"direction")
#' #> [1] "right"
#' #> attr(,"details")
#' #> [1] FALSE
#' #> attr(,"type")
#' #> [1] "htest"
#' #> attr(,"test.type")
#' #> [1] "whtest"
#' #> attr(,"class")
#' #> [1] "desk"
#'
#' ## Plot the test result
#' plot(X)
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
