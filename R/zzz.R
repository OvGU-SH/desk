.onLoad = function(libname, pkgname){
  # packageStartupMessage("\n\n Loading DESK ... \014")
  # set custom options for the package
}

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
