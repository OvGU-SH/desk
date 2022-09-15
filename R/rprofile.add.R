#' Add a Command to User R Startup File Rprofile.site
#'
#' @description Adds a specified R command to file "Rprofile.site" for automatic execution during startup.
#'
#' @param line a text string specifying the command to be added.
#'
#' @return None.
#' @export
#'
#' @examples
#' if (FALSE) rprofile.add("library(desk)") # Makes package desk to be loaded at startup
#'
#' @concept R, startup, configuration, Rprofile.site
#'
rprofile.add = function(line){
  write(line, file = paste(R.home(component = "etc"),"/Rprofile.site", sep =""), append = T)
}
