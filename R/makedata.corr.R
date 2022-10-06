#####
#' Generate Exogenous Normal Data with Specified Correlations
#'
#' @description This command generates a data frame of exogenous normal regression data with given correlation between the variables. This can, for example, be used for analyzing the effects of autocorrelation.
#'
#' @param n number of observations to be generated.
#' @param k number of exogenous variables to be generated.
#' @param CORR (k x k) Correlation matrix that specifies the desired correlation structure of the data to be generated. If not specified a random positive definite covariance matrix will be used.
#' @param sample logical value indicating whether the correlation structure is applied to the population (false) or the sample (true).
#'
#' @return The generated data frame of exogenous variables.
#'
#' @export
#'
#' @importFrom stats cov
#'
#' @examples
#' ## Generate desired correlation structure
#' corr.mat <- cbind(c(1, 0.7),c(0.7, 1))
#'
#' ## Generate 10 observations of 2 exogenous variables
#' X <- makedata.corr(n = 10, k = 2, CORR = corr.mat)
#' cor(X) # not exact values of corr.mat
#'
#' ## Same structure applied to a sample
#' X <- makedata.corr(n = 10, k = 2, CORR = corr.mat, sample = TRUE)
#' cor(X) # exact values of corr.mat
#'
#' @concept variation, covariation, variance, covariance
#'
#####
makedata.corr = function(n = 10, k = 2, CORR, sample = FALSE){

# Function to generate random correlation matrix
rnd.cov = function(k){
  x = matrix(rnorm(k^2), nrow=k, ncol=k)
  x = x/sqrt(rowSums(x^2))
  x = x %*% t(x)
  return(x)
}

if(missing(CORR)){CORR = rnd.cov(k)}
if(dim(CORR)[1] != dim(CORR)[2]){
  stop("Correlation Matrix is not a square matrix")
}
if(dim(CORR)[1] != k | dim(CORR)[2] != k){
  stop("Correlation Matrix has not dimension k x k")
}

var.names = c(paste("x", 1:k, sep = ""))
X = matrix(rnorm(k * n), n)
if (sample){
  X = sweep(X, 2, colMeans(X), "-")
  # X = X %*% chol2inv(chol(cov(X))) # NOT WORKING??
  X = X %*% solve(chol(cov(X)))
}
X = X %*% chol(CORR)
colnames(X) = var.names
#cat("Covariance matrix is: \n")
#print(cov(X))
#cat("Correlation matrix is: \n")
#print(cor(X))
return(as.data.frame(X))
}
