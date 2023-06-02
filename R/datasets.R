#####
#' Datasets in DESK
#'
#' @description Generates a table of data set names and descriptions available in package \code{desk}.
#'
#' @return An object of class \code{table}.
#'
#' @export
#'
#' @importFrom utils data
#'
#' @examples
#' datasets()
#'
#' @concept datasets
#' @concept desk
#'
#####
datasets = function(){
  cat("====================================\n")
  cat("Available datasets in package desk. \n")
  cat("====================================\n\n")
  a = data(package = "desk")$results[,3:4]
  a = as.table(cbind(Name = a[,1], Description = a[,2]))
  row.names(a) = 1:dim(a)[1]
  return(a)
}
