#' Two-Stage Least Squares (2SLS) Instrument Variable Regression
#'
#' @description Performs a two-stage least squares regression.
#'
#' @param formula model formula.
#' @param data name of the data frame used. To be specified if variables are not stored in environment.
#' @param endog character vector of endogenous (to be instrumented) regressors.
#' @param iv character vector of (exogenous) instrumental variables.
#' @param contrasts an optional list. See the \code{contrasts.arg} of \code{\link[stats]{model.matrix.default}}.
#' @param details logical value indicating whether details should be printed out by default.
#' @param ... further arguments that \code{lm.fit()} understands.
#'
#' @return A list object including:
#' \tabular{ll}{
#' \code{adj.r.squ} \tab adjusted coefficient of determination (adj. R-squared).\cr
#' \code{coefficients} \tab IV-estimators of model parameters.\cr
#' \code{data/model} \tab matrix of the variables' data used.\cr
#' \code{data.name} \tab name of the data frame used.\cr
#' \code{df} \tab degrees of freedom in the model (number of observations minus rank).\cr
#' \code{exogenous} \tab exogenous regressors.\cr
#' \code{f.hausman} \tab exogeneity test: F-value for simultaneous significance of all instrument parameters. If H0: "Instruments are exogenous" is rejected, usage of IV-regression can be justified against OLS.\cr
#' \code{f.instr} \tab weak instrument test: F-value for significance of instrument parameter in first stage of 2SLS regression. If H0: "Instrument is weak" is rejected, instruments are usually considered sufficiently strong.\cr
#' \code{fitted.values} \tab fitted values of the IV-regression.\cr
#' \code{fsd} \tab first stage diagnostics (weakness of instruments).\cr
#' \code{has.const} \tab logical value indicating whether model has a constant (internal purposes).\cr
#' \code{instrumented} \tab name of instrumented regressors.\cr
#' \code{instruments} \tab name of instruments.\cr
#' \code{model.matrix} \tab the model (design) matrix.\cr
#' \code{ncoef} \tab integer, giving the rank of the model (number of coefficients estimated).\cr
#' \code{nobs} \tab number of observations.\cr
#' \code{p.hausman} \tab according p-value of exogeneity test.\cr
#' \code{p.instr} \tab according p-value of weak instruments test.\cr
#' \code{p.values} \tab vector of p-values of single parameter significance tests.\cr
#' \code{r.squ} \tab coefficient of determination (R-squared).\cr
#' \code{residuals} \tab residuals in the IV-regression.\cr
#' \code{response} \tab the endogenous (response) variable.\cr
#' \code{shea} \tab Shea's partial R-squared quantifying the ability to explain the endogenous regressors.\cr
#' \code{sig.squ} \tab estimated error variance (sigma-squared).\cr
#' \code{ssr} \tab sum of squared residuals.\cr
#' \code{std.err} \tab vector of standard errors of the parameter estimators.\cr
#' \code{t.values} \tab vector of t-values of single parameter significance tests.\cr
#' \code{ucov} \tab the (unscaled) variance-covariance matrix of the model's estimators.\cr
#' \code{vcov} \tab the (scaled) variance-covariance matrix of the model's estimators.\cr
#' \code{modform} \tab the model's regression R-formula.\cr
#' }
#'
#' @export
#'
#' @importFrom foreign read.dta
#'
#' @references
#' Greene, W.H. (1993): Econometric Analysis, 2nd ed., Macmillan.
#'
#' Kmenta, J. (1971): Elements of Econometrics, 2nd ed., The University of Michigan Press.
#'
#' Murray, M.P. (2006): Econometrics - A Modern Introduction, Pearson.
#'
#' @examples
#' ## Insurance Example, Chapter 20, Textbook
#' ivr(contr ~ score, endog = "score", iv = "contrprev", data = data.insurance, details = TRUE)
#'
#' ## Stata example
#' library(foreign)
#' data.educwages <- read.dta("http://www.stata-press.com/data/r12/educwages.dta")
#' ivr(wages ~ union + education, endog = "education", iv = c("meducation", "feducation"),
#' data = data.educwages)
#'
#' ## Replicating Murray (2006) Table 14.1 (page 612)
#' #data.graddy =
#' #read.table("http://wps.aw.com/wps/media/objects/2387/2445250/Data_Sets/ASCII/whiting.csv",
#' #header = TRUE, sep = ",")
#' #ivr(QTY ~ PRICE, endog = c("PRICE"), iv = "WINDSPD", details = TRUE, data = data.graddy)
#'
#' ## Replicating Murray (2006) Table 14.3 (page 622-623)
#' endog = c("PRICE")
#' #iv = c("WINDSPD","WINDSPD2", "STORMY", "COLD", "RAINY", "MIXED")
#' #ivr(QTY ~ PRICE + DAY1 + DAY2 + DAY3 + DAY4, endog = endog, iv = iv,
#' #details = TRUE, data = data.graddy)
#'
#' endog = c("QTY")
#' #iv = iv = c("DAY1", "DAY2", "DAY3", "DAY4")
#' #ivr(PRICE ~ QTY + WINDSPD + WINDSPD2 + STORMY + COLD + RAINY + MIXED, endog = endog, iv = iv,
#' #details = TRUE, data = data.graddy)
#'
#' ## Demand and supply estimation (Kmenta, 1971)
#' ## Copy variables to environment
#' consump <- data.kmenta$consump
#' price <- data.kmenta$price
#' income <- data.kmenta$income
#' farmPrice <- data.kmenta$farmPrice
#' trend <- data.kmenta$trend
#'
#' ## Define model equations
#' eqD <- consump ~ price + income
#' eqS <- consump ~ price + farmPrice + trend
#'
#' ## Estimate demand function with instruments "farmPrice"" and "trend""
#' D.est <- ivr(eqD, endog = "price", iv = c("farmPrice", "trend"))
#'
#' ## Estimate supply function with instrument "income"
#' S.est <- ivr(eqS, endog = "price", iv = "income")
#'
#' ## Calculate y-axis intersection and slope with averaged exogenous regressors
#' aD <- c(1, mean(income)) %*% D.est$coef[-2]
#' bD <- D.est$coef[2]
#' aS <- c(1, mean(farmPrice), mean(mean(trend))) %*% S.est$coef[-2]
#' bS <- S.est$coef[2]
#'
#' ## Plot data and estimated functions
#' plot(price, consump, xlim = c(0,120), ylim = c(0,120))
#' abline(a = aD, b = bD)
#' abline(a = aS, b = bS)
#'
#' @concept endogeneity, instrument variable
#'
ivr = function(formula,
               data = list(),
               endog,
               iv,
               contrasts = NULL,
               details = FALSE,
               ...){

  dname = paste(deparse(substitute(data)))

  # Model setup
  mf = model.frame(formula, data = data, drop.unused.levels = TRUE) # Data matrix
  mt = attr(mf, "terms") # Model terms
  y = model.response(mf, "numeric") # Response data
  X = model.matrix(mt, mf, contrasts) # Regressor data
  n = nrow(X) # Number of observations
  k = ncol(X) # Number of coefs in the model
  df = n - k # Number of coefs in the model

  getEnv = function(x) {
    #xobj = deparse(substitute(x))
    gobjects = ls(envir = .GlobalEnv)
    envirs = gobjects[sapply(gobjects, function(x) is.environment(get(x)))]
    envirs = c('.GlobalEnv', envirs)
    xin = sapply(envirs, function(e) x %in% ls(envir = get(e)))
    envirs[xin]
  }

  # Get model-matrix of instruments Z (and exogenous regressors)
  Xnames = colnames(X)
  iv.data = if (missing(data)) do.call(cbind, mget(iv, envir = as.environment(getEnv(iv)))) else data[, iv]
  iv.data = as.matrix(na.omit(iv.data))
  Z = as.matrix(cbind(X[,- which(colnames(X) %in% endog)], iv.data))
  colnames(Z) = c(Xnames[- which(colnames(X) %in% endog)], iv)

  # Fist stage regression: exog. and endog. regressors X on exog. regressors and instruments Z
  if(!is.null(Z)) { # If instruments defined ...
    if(ncol(Z) < ncol(X)) warning("Underidentified: More regressors than instruments")
    aux.reg = lm.fit(Z, X, ...)
    XZ = as.matrix(aux.reg$fitted.values)
    colnames(XZ) = colnames(X)
  } else { # If no instruments defined ...
    XZ = X
  }

  # Second stage regression
  main.reg = lm.fit(XZ, y, ...)

  ## Initialize list
  out = list()

  # Fitted values
  yhat = drop(X %*% main.reg$coefficients)
  names(yhat) = names(y)
  out$fitted.values = yhat

  # Residuals and SSR
  out$residuals = y - yhat
  out$ssr = sum(out$residuals^2)

  # Est. error variance
  out$sig.squ = out$ssr/main.reg$df.residual

  # Coefficients
  out$coefficients = main.reg$coefficients

  # Variance-covariance matrices
  # Unscaled:
  out$ucov = chol2inv(main.reg$qr$qr[1:k, 1:k, drop = FALSE])
  dimnames(out$ucov) = list(names(main.reg$coefficients),names(main.reg$coefficients))
  # Scaled:
  out$vcov = out$sig.squ * out$ucov

  # Regression table splitted
  out$std.err = sqrt(diag(out$vcov))
  out$t.values = out$coef/out$std.err
  out$p.values = 2*pt(-abs(out$t.value), df = df)

  # Data
  out$data = mf # Used dataframe
  out$data.name = dname # Name of used dataframe
  out$response = y
  out$model.matrix = XZ

  # Some statistics
  ## R-squared
  if (attr(mt,"intercept") == 1) {
    Syy = sum((y - mean(y))^2)
    dfi = 1
  } else if (attr(mt,"intercept") == 0) {
    Syy = sum(y^2)
    dfi = 0
  }
  out$r.squ = 1 - out$ssr/Syy
  out$adj.r.squ = 1 - (1 - out$r.squ) * ((n - dfi)/main.reg$df.residual)

  # Misc
  out$nobs = n
  out$ncoef = k
  out$df = df
  out$has.const = if (attr(mt,"intercept") == 0){F} else if (attr(mt,"intercept") == 1){T}
  out$instrumented = endog
  out$exogenous = colnames(X)[- which(colnames(X) %in% c("(Intercept)", endog))]
  out$instruments = iv

  # First stage diagnostics (Weakness of instruments)
  fsd = matrix(NA, length(endog), 3)
  for(i in 1:length(endog)) {
    bhat = aux.reg$coef[,endog[i]]
    ZZi = sum(aux.reg$resid[,endog[i]]^2) / aux.reg$df.resid * chol2inv(chol(t(Z) %*% Z))
    if(any(is.nan(ZZi))) {out$f.instr <- out$p.instr <- NA} else {
      nh = as.matrix(diag(ncol(Z))[- which(!(colnames(Z) %in% iv)),], ncol = ncol(Z))
      if (dim(nh)[2] == 1) nh = t(nh)
      Rb = nh %*% bhat
      fsd[i, 1] = as.numeric(t(Rb) %*% chol2inv(chol(nh %*% ZZi %*% t(nh))) %*% (Rb)/nrow(nh))
      fsd[i, 2] = 1 - pf(fsd[i, 1], nrow(nh), aux.reg$df.res)}
    # Shea's partial R^2
      ols.reg = lm.fit(X, y, ...)
      sig2.ols = sum(ols.reg$residuals^2)/ols.reg$df.residual
      V.ols = diag(sig2.ols * chol2inv(chol(t(X) %*% X)))
      names(V.ols) = names(ols.reg$coef)
      V.2sls = diag(out$vcov)
      shea = (V.ols/V.2sls * out$sig.squ/sig2.ols)[endog]
      fsd[, 3] = shea
  }
  dimnames(fsd) = list(endog, c("F-value", "p-value", "Shea's R2"))
  out$fsd = fsd

  out$f.instr = out$fsd[,1]
  out$p.instr = out$fsd[,2]
  out$shea = shea

  # Hausman test (omitted variable version)
  if(length(endog) > 1L){
    aux.reg = lm.fit(Z, X[, which(colnames(X) %in% endog)])
  }
  xfit = as.matrix(aux.reg$fitted[, which((colnames(aux.reg$fitted) %in% endog))])
  colnames(xfit) = paste("fit", colnames(xfit), sep = "_")
  Z = cbind(X, xfit)
  aux.reg = lm.fit(Z, y)
  bhat = aux.reg$coef
  ZZi = sum(aux.reg$resid^2)/aux.reg$df.resid * chol2inv(chol(t(Z) %*% Z))
  if(any(is.nan(ZZi))) {out$f.hausman <- out$p.hausman <- NA} else {
    nh = diag(ncol(Z))
    nh = as.matrix(nh[- (1:(dim(X)[2])),])
    if (dim(nh)[2] == 1) nh = t(nh)
    Rb = nh %*% bhat
    out$f.hausman = as.numeric(t(Rb) %*% chol2inv(chol(nh %*% ZZi %*% t(nh))) %*% (Rb)/nrow(nh))
    out$p.hausman = 1 - pf(out$f.hausman, nrow(nh), aux.reg$df.res)
  }

  # order output alphabetically
  out = out[order(names(out))]

  # Model formula
  out$modform = paste(deparse(mt), collapse = "")
  attr(out, "title") = if(nchar(out$modform) < 50){
    paste("2SLS-Regression of model", paste("", out$modform, "", sep = ""))
  } else {
    "2SLS Instrument Variable Regression"}
  out$model.formula = as.formula(out$modform)
  out$terms = mt

  # Further attributes
  attr(out, "details") = if (details) {T} else {F}
  attr(out, "type") = "ivr"
  class(out) = c("desk")

  return(out)
}
