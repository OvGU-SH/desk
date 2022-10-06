#####
#' Generate Artificial, Non-linear Data for Simple Regression
#'
#' @description This command generates a data frame of two variables, x and y, which can be both transformed by a normalized, lambda-deformed logarithm (aka. Box-Cox-transformation). The purpose of this command is to generate data sets that represent a non-linear relationship between exogenous and endogenous variable. These data sets can be used to train linearization and heteroskedasticity issues. Note that the error term is also transformed to make it normal and homoscedastic after re-transformation to linearity. This is why generated data sets may have non-constant variance depending on the transformation parameters.
#'
#' @param lambda.x deformation parameter for the x-values: -1 = inverse, 0 = log, 0.5 = root, 1 = linear, 2 = square ...
#' @param lambda.y deformation parameter for the y-values (see \code{lambda.x}).
#' @param a additive constant to shift the data in vertical direction.
#' @param x.max upper border of x values, must be greater than 1.
#' @param n number of artificial observations.
#' @param sigma standard deviation of the error term.
#' @param seed randomization seed.
#'
#' @return Data frame of x- and y-values.
#' @export
#'
#' @examples
#' ## Compare 4 data sets generated differently
#' par(mfrow = c(2,2))
#'
#' ## Linear data shifted by 3
#' A.dat <- makedata.bc(a = 3)
#'
#' ## Log transformed y-data
#' B.dat <- makedata.bc(lambda.y = 0, n = 100, sigma = 0.2, x.max = 3, seed = 123)
#'
#' ## Concave scatter
#' C.dat <- makedata.bc(lambda.y = 6, sigma = 0.4, seed = 12)
#'
#' ## Concave scatter, x transf.
#' D.dat <- makedata.bc(lambda.x = 0, lambda.y = 6, sigma = 0.4, seed = 12)
#'
#' plot(A.dat, main = "linear data shifted by 3")
#' plot(B.dat, main = "log transformed y-data")
#' plot(C.dat, main = "concave scatter")
#' plot(D.dat, main = "concave scatter, x transf.")
#' par(mfrow = c(1,1))
#'
#' @concept plot, scatter, regression line, confidence band, prediction band
#'
#####
makedata.bc = function(lambda.x = 1, lambda.y = 1, a = 0, x.max = 5, n = 200, sigma = 1, seed = NULL){
 set.seed(seed)
 x = def.log(seq(from = 1, to = x.max, length.out = n), lambda = lambda.x)
 y = def.exp(x + a + rnorm(n, sd = sigma), lambda = lambda.y)
 return(data.frame(x = x, y = y))
}
