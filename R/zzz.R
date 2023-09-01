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
        "========================== \U0001f173\U0001f174\U0001f182\U0001f17a =========================\n\n",
        " Didactic Econometrics Starter Kit (desk) v",utils::packageDescription("desk")$Version," is re-", "\n",
        " leased for educational purposes, accompanying the Ger-\n",
        " man textbooks:\n\n",
        " - L. v.Auer (2023) \u00d6konometrie - Eine Einf\u00fchrung, 8th ed.", "\n",
        " - L. v.Auer, S. Hoffmann & T. Kranz (2023) \u00d6konometrie - ", "\n",
        "   Das R-Arbeitsbuch, 2nd ed.", "\n\n",
        " More information on these books:\n\n",
        " ", cli::style_hyperlink("https://oekonometrie-lernen.de", "https://www.uni-trier.de/index.php?id=15929"),"\n\n",
        " REMARK: Users of the 1st ed. of the book should install", "\n",
        " and use desk v1.0.x (pre-CRAN release) manually from:", "\n\n",
        " ", cli::style_hyperlink("https://github.com/OvGU-SH/desk1A/releases", "https://github.com/OvGU-SH/desk1A/releases"),"\n\n",
        "===========================================================","\n\n",
        sep="")
}

packageStartupMessage(StartWelcomeMessage())

# .onUnload <- function (libpath) {
#   library.dynam.unload("mypackage", libpath)
# }
