.onLoad = function(libname, pkgname){
  # packageStartupMessage("\n\n Loading DESK ... \014")
  # set custom options for the package
  options(scipen = 999)
}

.onAttach = function(libname, pkgname){
  cat("* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*                                                               *
*   Didactic Econometrics Starter Kit (DESK) v",as.character(utils::packageVersion("desk")),"           *
*   is released for educational purposes, accompanying the      *
*   the German textbooks:                                       *
*                                                               *
*   L.v.Auer (2023) \u00d6konometrie - Eine Einf\u00fchrung, 8th ed.      *
*                                                               *
*   L.v.Auer, S.Hoffmann & T.Kranz (2023) \u00d6konometrie - Das     *
*   R-Arbeitsbuch, 2nd ed.                                      *
*                                                               *
*   REMARK: Users of the 1st ed. should download and use        *",
      "\n*   desk v1.0.4 from",
      cli::style_hyperlink("HERE", "https://www.vwl3.ovgu.de/Lehre/desk.html"),
      "due to name incompatibilies.          *",
      "\n*                                                               *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *\n\n")
}

