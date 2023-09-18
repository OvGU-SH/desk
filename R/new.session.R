new.session = function(cd = TRUE, sci = FALSE) {
  # Set new working directory:
  if (cd == TRUE) {
    oldwd <- getwd()
    on.exit(setwd(oldwd))

    requireNamespace("rstudioapi", quietly = TRUE)

    if (getActiveDocumentContext()$path != "") {
      setwd(dirname(getActiveDocumentContext()$path))
    }
  }

  # Restore scientific notation:
  if (sci == TRUE) {
    options(scipen = 0)
  }

  # Restore parameter settings:
  oldpar <- par(no.readonly = TRUE)
  on.exit(par(oldpar))

  y = function() {
    dev.new()
    x = par(no.readonly = T)
    dev.off()
    x
  }
  par(y())

  # Delete graphics:
  dev.off()

  # Delete objects:
  rm(list=ls(pos = .GlobalEnv), pos = .GlobalEnv)

  # Delete console:
  cat('\014')
}
