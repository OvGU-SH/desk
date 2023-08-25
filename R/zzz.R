.onLoad = function(libname, pkgname){
  # packageStartupMessage("\n\n Loading DESK ... \014")
  # set custom options for the package
  options(scipen = 999)
}

.onAttach = function(libname, pkgname){
  packageStartupMessage(
    "\n
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
*                                                               *
*   Didactic Econometrics Starter Kit (DESK) is released for    *
*   educational purposes, accompanying the German textbooks:    *
*                                                               *
*   L.v.Auer (2023) \u00d6konometrie - Eine Einf\u00fchrung, 8th ed.      *
*                                                               *
*   L.v.Auer, S.Hoffmann & T.Kranz (2023) \u00d6konometrie - Das     *
*   R-Arbeitsbuch, 2nd ed.                                      *
*                                                               *
*   Remark: Users of the 1st ed. should download v1.0.4         *
*   [https://www.vwl3.ovgu.de/Lehre/desk.html]                  *
*   due to possible compatibility issues.                       *
*                                                               *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
\n"
  )
}

