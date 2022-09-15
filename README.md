# desk
## Änderungen: 1.0.3 -> 1.1.0 (CRAN)
- help-file mit roxygen2-Code in .R-file als Präamble (z.B. \description -> @description)
  - Vorteil: alles in einer Datei
  - auch data-Infos nun in .R-file mit roxygen2-Code und "dataset.abc"
- @keywords -> @concept: Phrasen (z.B. deformed logarithm) und nicht nur einzelne Wörter werden gefunden
- Typos verbessert, auf Konsistenz geachtet und Format-Konventionen umgesetzt in help-files  
- @importFrom für Cross-refs
- Funktionen umbenannt, da Name (bzw. der Anfang) reserviert war
  - exp.def -> def.exp
