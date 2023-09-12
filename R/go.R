go = function(cd = TRUE, sci = FALSE) {
  if (cd == TRUE) {
    # if(!require("rstudioapi",character.only = T)) {
    #   install.packages("rstudioapi")
    # }
    requireNamespace("rstudioapi", quietly = TRUE)

    if (getActiveDocumentContext()$path != "") {
      setwd(dirname(getActiveDocumentContext()$path))
    }
  }

  if (sci == TRUE) {
    options(scipen = 0)
  }

  y = function() {
    dev.new()
    x = par(no.readonly = T)
    dev.off()
    x
  }
  par(y())

  dev.off()

  rm(list=ls(pos = .GlobalEnv), pos = .GlobalEnv)

  cat('\014')
}
