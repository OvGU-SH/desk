.onLoad = function(libname, pkgname){
  # packageStartupMessage("\n\n Loading DESK ... \014")
  # set custom options for the package
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
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
\n"
  )
}

