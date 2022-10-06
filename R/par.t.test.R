#####
#' t-Test on Estimated Parameters of a Linear Model
#'
#' @description Performs a t-test on a single parameter hypothesis or a hypothesis containing a linear combination of parameters of a linear model. The object of test results returned by this command can be plotted using the \code{plot()} function.
#'
#' @param mod model object estimated by \code{ols()} or \code{lm()}.
#' @param data name of the data frame to be used if \code{mod} is a formula and the variables are not present in the environment.
#' @param nh vector of the coefficients of the linear combination of parameters.
#' @param q value on which parameter (combination) is to be tested against. Default value: q = 0.
#' @param dir direction of the hypothesis: \code{"both"}, \code{"left"}, \code{"right"}, Default value: \code{"both"}.
#' @param sig.level significance level. Default value: \code{sig.level = 0.05}.
#' @param details logical value indicating whether specific details about the test should be returned.
#' @param hyp logical value indicating whether the Hypotheses should be returned.
#'
#' @return A list object including:
#' \tabular{ll}{
#' \code{hyp} \tab character matrix of hypotheses (if \code{hyp = TRUE}).\cr
#' \code{nh} \tab null hypothesis as parameters of a linear combination (for internal purposes).\cr
#' \code{lcomb} \tab the linear combination of parameters tested.\cr
#' \code{results} \tab a data frame of basic test results.\cr
#' \code{std.err} \tab standard error of the linear estimator.\cr
#' \code{nulldist} \tab type of the null distribution with its parameters.\cr
#' }
#'
#' @export
#'
#' @examples
#' ## Test H1: "phos + nit <> 1"
#' fert.est <- ols(barley ~ phos + nit, data = log(data.fertilizer))
#' x = par.t.test(fert.est, nh = c(0,1,1), q = 1, details = TRUE)
#' x # Show the test results
#'
#' plot(x) # Visualize the test result
#'
#' ## Test H1: "phos > 0.5"
#' x = par.t.test(fert.est, nh = c(0,1,0), q = 0.5, dir = "right")
#' plot(x)
#'
#' @concept t-test, linear hypothesis, linear model
#'
#####
par.t.test = function(mod,
                       data = list(),
                       nh,
                       q = 0,
                       dir = c("both", "left", "right"),
                       sig.level = 0.05,
                       details = FALSE,
                       hyp = TRUE){

  if (inherits(mod, "formula")) { # Wenn Formel übergeben ...
    mod = ols(mod, data = data)
  }

  dir = match.arg(dir) # Take the first default argument

  df = mod$df.residual # T-K-1
  sd = sqrt(nh %*% vcov(mod) %*% nh)
  bhat = coef(mod)
  coefnames = names(bhat)

  # Calculate t-Value
  t.val = (bhat %*% nh - q)/sd

  ## Critical and p-value
  if (dir == "both"){
    t.crit = sign(t.val) * qt(1 - sig.level/2, df)
    p.val = pt(-abs(t.val), df)*2
    H0sgn = " = "
    H1sgn = " <> "
  }
  if (dir == "right"){
    t.crit = qt(1-sig.level, df)
    p.val = 1 - pt(t.val, df)
    H0sgn = " <= "
    H1sgn = " > "
  }
  if (dir == "left"){
    t.crit = qt(sig.level, df)
    p.val = pt(t.val, df)
    H0sgn = " >= "
    H1sgn = " < "
  }

  ## Generate Hypothesis
    H = matrix(NA, 1, 2L)
      h = ""
      for (i in 1:length(coefnames)){
        tmp = coefnames[i]
        if (nh[i] != 0){ # If coef not zero...
          tmp = paste(as.character(abs(nh[i])),"*",tmp, sep = "")
          tmp = paste(if ((nh[i]>0) & (h != "")) " + " else if (nh[i]<0) " - ", tmp, sep = "")
        } else {tmp = ""}# If coef zero, then no name
        h = paste(h, tmp, sep = "")
      } # end of inner for
  if (hyp) {
    H = c(paste(h, H0sgn , q, sep = ""), paste(h, H1sgn, q, sep = ""))
    names(H) = c("H0:", "H1:")
    H = t(H)
  } else {
    H = NULL
  }

  test.result = if (p.val < sig.level) "rejected" else "not rejected"
  results = data.frame(t.value = t.val,
                       crit.value = t.crit,
                       p.value = p.val,
                       sig.level = sig.level,
                       H0 = test.result,
                       row.names = "")

  out = list()
  attr(out, "title") = "t-test on one linear combination of parameters"
  out$hyp = H # Null and alternative hypothesis
  out$nh = nh # Null and alternative hypothesis (Vector form)
  out$lcomb = h
  out$results = results # Basic test results
  out$std.err = sd
  out$nulldist = list(type = "t", df = df)

  attr(out, "direction") = dir
  attr(out, "details") = if (details) {T} else {F}
  attr(out, "type") = "htest"
  attr(out, "test.type") = "ttest"
  class(out) = c("desk")

  return(out)
}
