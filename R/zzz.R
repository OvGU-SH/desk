.onLoad = function(libname, pkgname){
  # packageStartupMessage("\n\n Loading DESK ... \014")
  # set custom options for the package
}

# .onAttach = function(libname, pkgname){
#   packageStartupMessage(
#     "\n
# This package includes tools and procedures that may be helpful for learning and teaching undergraduate econometrics.
# Its main purpose is to help students to get a quick introduction into basic econometrics using R. Basically this package
# can be used with any undergraduate econometrics textbook, however, it was written to accompany the german textbook
#
#      Ökonometrie - Das R-Arbeitsbuch, by L. v. Auer and S. Hoffmann, Springer Gabler, 2017.
# \n"
#   )
# }

.onAttach = function(libname, pkgname){
  packageStartupMessage(
    "\n
*******************************************************************
* Package DESK is released for EDUCATIONAL PURPOSES, accompanying *
*								  *
*  L. von Auer: Oekonometrie - Eine Einfuehrung, Springer-Gabler. *
*								  *
*******************************************************************
\n"
  )
}
