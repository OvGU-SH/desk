#####
#' R Session Reset
#'
#' @description Removes all objects from global environment. Removes all plots. Resets the scientific notation (e.g., 1e-04). Clears the console. As default, sets the working directory to source file loction in case the function is used from an R script.
#'
#' @param cd if cd = FALSE, the working directory is not be changend. The default, cd = TRUE, sets the working directory to source file loction.
#'
#' @return None.
#' @export
#'
#' @importFrom grDevices dev.new dev.off
#' @importFrom graphics par
#' @importFrom utils install.packages
#' @importFrom rstudioapi getActiveDocumentContext
#'
#' @examples
#' ## R Session reset without changing the current working directory
#' reset(FALSE) # reset(F)
#'
#' @concept objects
#' @concept remove
#' @concept delete
#' @concept environment
#' @concept .GlobalEnv
#'
#####
reset = function(cd = TRUE) {
  if (cd == TRUE) {
    # if(!require("rstudioapi",character.only = T)) {
    #   install.packages("rstudioapi")
    # }
    requireNamespace("rstudioapi", quietly = TRUE)

    if (getActiveDocumentContext()$path != "") {
      setwd(dirname(getActiveDocumentContext()$path))
    }
  }

  y = function() {
    dev.new()
    x = par(no.readonly = T)
    dev.off()
    x
  }
  par(y())

  options(scipen = 0)

  dev.off()

  rm(list=ls(pos = .GlobalEnv), pos = .GlobalEnv)

  cat('\014')
}
