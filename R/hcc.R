#####
#' Heteroskedasticity Corrected Covariance Matrix
#'
#' @description Calculates Whites (1980) heteroskedasticity corrected covariance matrix in a linear model.
#'
#' @param mod estimated linear model object or formula.
#' @param data if \code{mod} is a formula then the corresponding data frame has to be specified.
#' @param digits number of decimal digits in rounded values.
#'
#' @return The heteroskedasticity corrected covariance matrix.
#'
#' @export
#'
#' @references
#' White, H. (1980): A Heteroskedasticity-Consistent Covariance Matrix Estimator and a Direct Test for Heteroskedasticity. Econometrica 48, 817-838.
#'
#' @seealso \code{\link{wh.test}}, \code{\link[lmtest]{bptest}}.
#'
#' @examples
#' rent.est <- ols(rent ~ dist, data = data.rent)
#' hcc(rent.est)
#'
#' hcc(wage ~ educ + age, data = data.wage)
#'
#' @concept heteroskedasticity
#' @concept correction
#'
#####
hcc = function(mod, data = list(), digits = 4) {

  if (!inherits(mod, "formula")) { # Wenn Modell übergeben ...
    X = model.matrix(terms(mod), model.frame(mod))
    y = model.response(model.frame(mod))
    resid = mod$resid
  }
  else { # Wenn Formel übergeben ...
    mf = model.frame(mod, data = data)
    y = model.response(mf)
    X = model.matrix(mod, data = data)
    resid = lm.fit(X,y)$resid
  }

  XXi = chol2inv(chol(t(X) %*% X))
  out = XXi %*% t(X) %*% diag(resid^2) %*%  X %*% XXi
  return(round(out, digits))
}
