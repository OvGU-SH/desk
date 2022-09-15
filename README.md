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
  - log.def -> def.log
  - rep.sample -> sample.rep
  - t.coef.test -> par.t.test
  - f.coef.test -> par.F.test (aus Konsistenz)
- @examples: Console output gelöscht (da sonst teilweise 500 Zeilen) 

## Offene Fragen
- help-files ergänzen (z.B. data.tsls/theil; ref von data.burglary; Konsistenz ref/source?)
- Code ergänzen? z.B. IV in plot.desk
- www.oekonometrie-lernen.de -> https
- andronikoss/desk ist noch online
- onAttach.R -> message ok?
- datasets() -> Labor & Trinkgeld?
- online Murray 2006 data? (cochorc.R/ivr.R examples)
- Erklärende Kommentare in examples (z.B. gq.test)
- RESET test!
- return/value: "A list object" / "None"?
- rprofile.add("library(desk)") (Permission denied) -> Error

