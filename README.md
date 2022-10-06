# desk


### Änderungen: 1.0.3 >> 1.1.0 (CRAN)

-   help-file mit roxygen2-Code in .R-file als Präamble (z.B. \\description >> @description)
    -   Vorteil: alles in einer Datei (help-Teil mit ##### zuklappbar)
    -   auch data-Infos nun in .R-file mit roxygen2-Code und "dataset.abc"
-   @keywords >> @concept: Phrasen (z.B. deformed logarithm) und nicht nur einzelne Wörter werden gefunden
    - keine Sonderzeichen, z.B. AR(1) >> AR1
-   Typos verbessert, auf Konsistenz geachtet und Format-Konventionen umgesetzt in help-files\
-   @importFrom für Cross-refs (mandatory)
-   Funktionen umbenannt, da Name (bzw. der Anfang) reserviert war
    -   exp.def >> def.exp
    -   log.def >> def.log
    -   rep.sample >> sample.rep
    -   t.coef.test >> par.t.test
    -   f.coef.test >> par.f.test (Konsistenz)
-   @examples: Console output gelöscht (da sonst teilweise über 500 Zeilen)
-   CRAN erlaubt nur ASCII: stringi::stri_escape_unicode("Ö") etc. für ASCII Äquivalent


### Literatur und Zitierung (mit ASCII Äquivalent für Umlaute)

-   Auer, L.v. (2023) Ökonometrie - Eine Einführung, 8th ed., Springer-Gabler.
    -   Auer, L.v. (2023) \u00d6konometrie - Eine Einf\u00fchrung, 8th ed., Springer-Gabler.
    -   Auer (2023)
-   Auer, L.v., S. Hoffmann & T. Kranz (2023) Ökonometrie - Das R-Arbeitsbuch, 2nd ed., Springer-Gabler.
    -   Auer, L.v., S. Hoffmann & T. Kranz (2023) \u00d6konometrie - Das R-Arbeitsbuch, 2nd ed., Springer-Gabler.
    -   Auer et al. (2023)
-   (von Auer >> Konsistenz! sonst egal)    


### Offene Fragen

-   Formatierung Buch und Artikel-Quellen (@ref/@source) festlegen


### ToDo

-   für CRAN-release nochmals durchgehen: 
    -   https://r-pkgs.org/check.html
    -   https://cran.r-project.org/web/packages/policies.html
-   devtools::build_site()
-   weitere Keywords? (.R-files durchgehen) >> Zoom
-   www.oekonometrie-lernen.de >> https >> Mail an ZIMK
-   Ludwig: andronikoss/desk ist noch online (https://rdrr.io/github/andronikoss/desk/)
-   Sönke: IV/ivplot ergänzen
-   Tobi: dyn. Modelle für DESK (Kap.22) + Hausmann-Test; Refs in .R-files
