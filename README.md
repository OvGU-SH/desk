# desk

### Änderungen: 1.0.3 >> 1.1.0 (CRAN)

-   help-file mit roxygen2-Code in .R-file als Präamble (z.B. \\description >> @description)
    -   Vorteil: alles in einer Datei
    -   auch data-Infos nun in .R-file mit roxygen2-Code und "dataset.abc"
-   @keywords >> @concept: Phrasen (z.B. deformed logarithm) und nicht nur einzelne Wörter werden gefunden
  - keine Sonderzeichen, z.B. AR(1) >> AR1
-   Typos verbessert, auf Konsistenz geachtet und Format-Konventionen umgesetzt in help-files\
-   @importFrom für Cross-refs
-   Funktionen umbenannt, da Name (bzw. der Anfang) reserviert war
    -   exp.def >> def.exp
    -   log.def >> def.log
    -   rep.sample >> sample.rep
    -   t.coef.test >> par.t.test
    -   f.coef.test >> par.f.test (Konsistenz)
-   @examples: Console output gelöscht (da sonst teilweise über 500 Zeilen)

### Literatur und Zitierung

- Auer, L.v. (2023) Ökonometrie - Eine Einführung, 8th ed., Springer-Gabler.
  - Auer (2023)
- Auer, L.v., S. Hoffmann & T. Kranz (2023) Ökonometrie - Das R-Arbeitsbuch, 2nd ed., Springer-Gabler.
  - Auer et al. (2023)


### Offene Fragen

-   Formatierung Buch und Artikel-Quellen festlegen >> CRAN?
<<<<<<< HEAD
-   Konsistenz ref/source?
=======
  - Konsistenz ref/source?
>>>>>>> 7890ebd45cc39727639d5de505fbaad44959eb43
-   www.oekonometrie-lernen.de >> https >> Mail an Zimk
-   datasets() >> Labor? -> Labor aus + Murray rein
-   online Murray 2006 data? (cochorc.R/ivr.R examples) >> siehe ToDo

<<<<<<< HEAD
=======
-   return/value: "A list object" / "None."!
-   onAttach.R (zzz.R) >> message ok? >> U+L-Buch

>>>>>>> 7890ebd45cc39727639d5de505fbaad44959eb43
### ToDo

- für CRAN release: https://r-pkgs.org/check.html nochmals durchgehen
- devtools::build_site()
- mit Ludwig
  - Raus? arguments(), showfile()&Labor.txt
- weitere Keywords? (.R-files durchgehen) >> Zoom
<<<<<<< HEAD
-   onAttach.R (zzz.R) >> message ok? >> U+L-Buch
=======
>>>>>>> 7890ebd45cc39727639d5de505fbaad44959eb43
- Sönke: IV/ivplot ergänzen
- Kap.22: dyn. Modelle für DESK >> Tobi
- Murray data >> Ordner von Sönke
- v.Auer -> Konsistenz! sonst egal
- Ludwig: andronikoss/desk ist noch online
