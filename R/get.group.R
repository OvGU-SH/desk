#' Get a Random Draw from Specified Group of Numbers
#'
#' @description Get a random draw from specified group of numbers. This can be used for assigning groups of students to some exercises.
#'
#' @param grps vector of group numbers.
#'
#' @return None.
#' @export
#'
#' @examples
#' get.group() # Draw group from group numbers 1 to 5
#' get.group(c(1,6,3)) # Draw group from specified group numbers
#'
get.group = function(grps = seq(1,5)){
  set.seed(NULL) # reset seed in case it is stored in an environment image
  dgrp = sample(grps, size = 1) # Ziehe Gruppe
  cat(paste("Drawn group:" , dgrp),"\n")
  grps = grps[-which(grps == dgrp)] # Lösche gezogene Gruppe
  #assign("rgrps", grps, envir = .GlobalEnv)
  cat("Remaining groups: ")
  cat(grps,"\n")
}
