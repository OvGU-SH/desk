reset.session = function(cd = TRUE) {
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
