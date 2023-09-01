.onLoad = function(libname, pkgname){
  # packageStartupMessage("\n\n Loading DESK ... \014")
  # set custom options for the package
  options(scipen = 999)
}

.onAttach <- function(libname, pkgname){
  packageStartupMessage(StartWelcomeMessage())
}

StartWelcomeMessage <- function(){
  paste("\n",
        "====================== \U0001f173\U0001f174\U0001f182\U0001f17a v",utils::packageDescription("desk")$Version, " ======================\n\n",
        " Didactic Econometrics Starter Kit (desk) is released for", "\n",
        " educational purposes, accompanying the German textbooks:", "\n\n",
        " - L. v.Auer (2023) \u00d6konometrie - Eine Einf\u00fchrung, 8th ed.", "\n",
        " - L. v.Auer, S. Hoffmann & T. Kranz (2023) \u00d6konometrie - ", "\n",
        "   Das R-Arbeitsbuch, 2nd ed.", "\n\n",
        " REMARK: Users of the 1st ed. of the book should install", "\n",
        " and use desk v1.0.x manually from:", "\n\n",
        "        ", cli::style_hyperlink("https://cloud.ovgu.de/s/gMHr6p6iFD98WSf", "https://cloud.ovgu.de/s/gMHr6p6iFD98WSf"),"\n\n",
        "===========================================================","\n\n",
        sep="")
}

packageStartupMessage(StartWelcomeMessage())

# .onUnload <- function (libpath) {
#   library.dynam.unload("mypackage", libpath)
# }
