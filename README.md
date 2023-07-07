# desk


### Änderungen: 1.0.3 >> 1.1.0 (CRAN)

-   help-file mit roxygen2-Code in .R-file als Präamble (z.B. \\description >> @description)
    -   Vorteil: alles in einer Datei (help-Teil mit ##### zuklappbar)
    -   auch data-Infos nun in .R-file mit roxygen2-Code und "dataset.abc"
-   @keywords >> @concept: Phrasen (z.B. deformed logarithm) und nicht nur einzelne Wörter werden gefunden
    - keine Sonderzeichen, z.B. AR(1) >> AR1
-   Typos verbessert, auf Konsistenz geachtet und Format-Konventionen umgesetzt in help-files
-   Refs ergänzt und aktualisiert
-   @importFrom für Cross-refs (mandatory)
-   Funktionen umbenannt, da Name (bzw. der Anfang) reserviert war
    -   exp.def >> def.exp
    -   log.def >> def.log
    -   rep.sample >> r.sample
    -   t.coef.test >> par.t.test
    -   f.coef.test >> par.f.test (Konsistenz)
-   @examples: Console output gelöscht (da sonst teilweise über 500 Zeilen)
-   CRAN erlaubt nur ASCII: stringi::stri_escape_unicode("Ö") etc. für ASCII Äquivalent


### Literatur und Zitierung (mit ASCII Äquivalent für Umlaute)

-   Auer, L.v. (2023): Ökonometrie - Eine Einführung, 8th ed., Springer-Gabler
-   Auer (2023) [im Text]
-   L.v.Auer (2023) \u00d6konometrie - Eine Einf\u00fchrung, 8th ed. [StartupMessage]

-   Auer, L.v., Hoffmann, S. & Kranz, T. (2023): Ökonometrie - Das R-Arbeitsbuch, 2nd ed., Springer-Gabler
-   Auer et al. (2023) [im Text]
-   L.v.Auer, S.Hoffmann & T.Kranz (2023) \u00d6konometrie - Das R-Arbeitsbuch, 2nd ed. [StartupMessage]


### Offene Fragen

-   Formatierung Buch und Artikel-Quellen (@ref/@source) festlegen
    - LvA: auf Konsistenz achten


### Befehle

- usethis::use_data(as.data.frame(data.example), overwrite = T)
- devtools::document()
- devtools::check()
- devtools::install("C:/Users/Administrator/Seafile/OekoBuch_Kranz/desk")
- devtools::build(); cd ..; R CMD check desk_1.1.0.tar.gz


### ToDo

-   für CRAN-release nochmals durchgehen: 
    -   ~~https://r-pkgs.org/check.html~~
    -   https://cran.r-project.org/web/packages/policies.html
        -   The ownership of copyright >> SH
        -   Packages should not modify the global environment >> SH (rm.all)
        -   Binary packages are not accepted from maintainers >> SH
        -   https://cran.r-project.org/web/packages/submission_checklist.html 
        -   https://cran.r-project.org/submit.html
-   ~~devtools::build_site() >> Non-standard directory (NOTE)~~
-   weitere Keywords? (.R-files durchgehen)
-   Refs in .R-files >> LB/UB ggf. angleichen
-   ~~andronikoss/desk ist noch online (https://rdrr.io/github/andronikoss/desk/)~~
-   ~~https://oekonometrie-lernen.de~~

