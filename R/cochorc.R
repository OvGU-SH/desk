#####
#' Estimating Linear Models under AR(1) with Cochrane-Orcutt Iteration
#'
#' @description If autocorrelated errors can be modeled by an AR(1) process (rho as parameter) then this function performs a Cochrane-Orcutt iteration. If model coefficients and the estimated rho value converge with the number of iterations, this procedure provides valid solutions. The object returned by this command can be plotted using the \code{plot()} function.
#'
#' @param mod estimated linear model object or formula.
#' @param data data frame to be specified if \code{mod} is a formula.
#' @param iter maximum number of iterations to be performed.
#' @param tol iterations are carried out until difference in rho values is not larger than \code{tol}.
#' @param pwt build first observation using Prais-Whinston transformation. If \code{pwt = FALSE} then the first observation is dropped, Default value: \code{pwt = TRUE}.
#' @param details logical value, indicating whether details should be printed.
#'
#' @return A list object including:
#' \tabular{ll}{
#' \code{results} \tab data frame of iterated regression results.\cr
#' \code{niter} \tab number of iterated regressions performed.\cr
#' \code{rho.opt} \tab rho-value at last iteration performed..\cr
#' \code{y.trans} \tab transformed y-values at last iteration performed.\cr
#' \code{X.trans} \tab transformed x-values (incl. z) at last iteration performed.\cr
#' \code{resid} \tab residuals of transformed model estimation.\cr
#' \code{all.regs} \tab data frame of regression results for all considered rho-values.\cr
#' }
#'
#' @export
#'
#' @references
#' Cochrane, E. & Orcutt, G.H. (1949): Application of Least Squares Regressions to Relationships Containing Autocorrelated Error Terms. Journal of the American Statistical Association 44, 32-61.
#'
#' @examples
#' ## In this example only 2 iterations are needed to achieve (convergence of rho at the 5th digit)
#' sales.est <- ols(sales ~ price, data = data.filter)
#' cochorc(sales.est)
#'
#' ## For a higher precision we need 6 iterations
#' cochorc(sales.est, tol = 0.0000000000001)
#'
#' ## If we allow not more than 4 iterations, a warning message is generated
#' cochorc(sales.est, iter = 4, tol = 0.0000000000001)
#'
#' ## Direct usage of a model formula
#' X <- cochorc(sick ~ jobless, data = data.sick[1:14,], details = TRUE)
#'
#' ## See iterated regression results
#' X$all.regs
#'
#' ## Print full details
#' X
#'
#' ## Suppress details
#' print(X, details = FALSE)
#'
#' ## Plot rho over iterations to see convergence
#' plot(X)
#'
#' ## Replicate Table 11.3 and 11.7 from Murray (2006)
#' data.murray <- read.table(system.file("extdata", "poverty1.csv", package = "desk"),
#'                           header = TRUE, sep = ",")
#' poverty.est <- ols(POVERTY ~ UNEMPLOY, data = data.murray)
#' cochorc(poverty.est, iter = 30, tol = 0.000001)
#'
#' ## Example with interaction
#' dummy <-  as.numeric(data.sick$year >= 2005)
#' kstand.str.est <- ols(sick ~ dummy + jobless + dummy*jobless, data = data.sick)
#' cochorc(kstand.str.est)
#'
#####
cochorc = function(mod, data = list(), iter = 10, tol = 0.0001, pwt = TRUE, details = FALSE){

  if (!inherits(mod, "formula")) { # Wenn Modell übergeben ...
    mf = model.frame(mod)
    X = model.matrix(terms(mod), model.frame(mod))
    y = model.response(model.frame(mod))
  }
  else { # Wenn Formel übergeben ...
    mf = model.frame(mod, data = data)
    y = model.response(mf)
    X = model.matrix(mod, data = data)
    mod = lm.fit(X,y)
  }

  coefnames = names(mod$coefficients)
  y = as.matrix(y)
  colnames(y) = colnames(mf)[1]

  k = ncol(X) # Number of coefs
  n = nrow(X) # Number of observations

  # Prais-Winsten transformation of data (including first obs.)
  pw.trans = function(x, rho){
    pw = sqrt(1 - rho^2) # Prais-Winsten transformation for first observation
    x.trans = rbind(pw * x[1,], as.matrix(x[2:n,]) - as.matrix(rho * x[1:(n-1),]))
    colnames(x.trans) = colnames(x)
    rownames(x.trans) = 1:n
    return(x.trans)
  }

  # Init vector/matrix
  coor = c()

  rho = 0
  # Start iterated regressions
  for (i in 1:iter){

    # Calculate residuals
    u = y - X %*% mod$coefficients

    rho.before = rho
    rho = sum(u[1:(n-1)] * u[2:n])/sum(u[1:(n-1)]^2) # OLS estimator for rho
    niter = i

    # Transform y-vector and x-matrix
    y_trans = pw.trans(y, rho)
    X_trans = pw.trans(X, rho)

    # If no Prais-Winsten Transformation, delete first observations
    if (pwt == F){
      y_trans = y_trans[-1]
      X_trans = X_trans[-1,]
    }

    # OLS estimation
    mod = lm.fit(X_trans, y_trans)
    coor[ (i*(k + 2) - (k + 1)) : (i*(k + 2))] = c(rho, sum(mod$residuals^2), mod$coefficients)

    # Check if convergence archieved
    if (abs(rho - rho.before) < tol) {
      break
    }
  }
  # Convert vector to matrix
  coor = matrix(coor, nrow = niter, ncol = k+2, byrow = TRUE)
  dimnames(coor) = list(1:niter, c("rho.hat", "SSR", colnames(X)))
  if(niter == iter){
    warning("Rho does not converge within given number of iterations and tolerance level.
Please increase max. number of iterations (iter) or increase tolerance level (tol).", call. = F)}

  # Get optimal regression
  rho.opt = as.numeric(coor[niter, 1])
  y.trans = pw.trans(y, rho.opt) # optimal transformed y values
  X.trans = pw.trans(X, rho.opt) # optimal transformed x values (incl. z)
  mod = ols(y.trans ~ X.trans - 1)

  # Generate regression table
  regtab = matrix(NA, mod$ncoef, 4)
  regtab[,1] = mod$coef
  regtab[,2] = mod$std.err
  regtab[,3] = mod$t.value
  regtab[,4] = mod$p.value
  colnames(regtab) = c("coef", "std.err.", "t.value", "p.value")
  rownames(regtab) = coefnames

  out = list()
  attr(out, "title") = "Cochrane-Orcutt estimation given AR(1)-autocorrelated errors"

  out$results = regtab
  out$niter = niter
  out$rho.opt = rho.opt
  out$y.trans = y.trans # optimal transformed y values
  out$X.trans = X.trans # optimal transformed x values (incl. z)
  out$resid = mod$resid
  out$all.regs = coor # iteration results

  attr(out, "details") = if (details) {T} else {F}
  attr(out, "type") = "cochorc"
  class(out) = c("desk")

  return(out)
}
