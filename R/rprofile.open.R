#' Open User R Startup File Rprofile.site
#'
#' @description Opens the user R startup file "Rprofile.site" for viewing or editing.
#'
#' @return None.
#' @export
#'
#' @examples
#' if (FALSE) rprofile.open() # Open the file if statement = TRUE
#'
#' @concept R, startup, configuration, Rprofile.site
#'
rprofile.open = function(){
  file.show(paste(R.home(component = "etc"),"/Rprofile.site", sep =""))
}
