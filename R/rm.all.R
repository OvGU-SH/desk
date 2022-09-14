#' Remove All Objects
#'
#' @description Removes all objects from global environment, except specified ones.
#'
#' @param keep a vector of strings specifying object names to be kept in environment, optional, if omitted then all objects in global environment are removed.
#'
#' @return None.
#' @export
#'
#' @examples
#' x = c(1,2)
#' y = c(4,1)
#' z = c(3,1)
#'
#' ## Delete all but x and z
#' rm.all(c("x","z"))
#'
#' ## Delete everything
#' rm.all()
#'
rm.all = function(keep = NULL) {
  rm(list = ls(pos = .GlobalEnv)[! ls(pos = .GlobalEnv) %in% keep], pos = .GlobalEnv)
}
