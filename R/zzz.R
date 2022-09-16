.onLoad = function(libname, pkgname){
  # packageStartupMessage("\n\n Loading DESK ... \014")
  # set custom options for the package
}

.onAttach = function(libname, pkgname){
  packageStartupMessage(
    "\n
*********************************************************************************
* DESK is released for EDUCATIONAL PURPOSES, accompanying the german textbooks: *
*                                                                               *
* L.v.Auer (2023) \u00d6konometrie - Eine Einf\u00fchrung, 8th ed.                        *
* L.v.Auer, S.Hoffmann & T.Kranz (2023) \u00d6konometrie - Das R-Arbeitsbuch, 2nd ed.*
*                                                                               *
*********************************************************************************
\n"
  )
}

# This package includes tools and procedures that may be helpful for learning and teaching undergraduate econometrics.
# Its main purpose is to help students to get a quick introduction into basic econometrics using R. Basically this package
# can be used with any undergraduate econometrics textbook, however, it was written to accompany the german textbook
