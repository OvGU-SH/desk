#' Non-Stationary Time Series Data
#'
#' @description The variables in this data set are non-stationary and help to understand spurious regression in the context of time series analysis.
#'
#' @format A data frame with yearly observations from 1880 to 2022 on the following five variables:
#' \tabular{ll}{
#' \code{year} \tab year of the observation.\cr
#' \code{temp} \tab deviation of the pre-industrial average global temperature.\cr
#' \code{elements} \tab number of discovered elements in chemistry (periodic table).\cr
#' \code{gold} \tab price for 1 ounce of fine gold in US-Dollar (not inflation-adjusted) starting in 1968.\cr
#' \code{cpi} \tab consumer price index: total all items for the United States (index 2015 = 100) starting in 1968.\cr
#' }
#' @details
#' In Auer, L von (2016, Chap. 22) and Auer, L. von, S. Hoffmann (2017, Chap. 22) these hypothetical data are used to illustrate the estimation of dynamic regression models.
#'
#' @source
#' Downloaded in 2023 from \url{https://data.giss.nasa.gov/gistemp/}, \url{https://iupac.org/what-we-do/periodic-table-of-elements/}, Deutsche Bundesbank Zeitreihen-Datenbanken (BBEX3.A.XAU.USD.EA.AC.C08), and \url{https://fred.stlouisfed.org/series/CPALTT01USA661S}.
#'
#' @references
#' Auer, L. von, S. Hoffmann (2017) Oekonometrie - Das R-Arbeitsbuch, Springer-Gabler (\bold{https://www.oekonometrie-lernen.de}).
#'
"data.spurious"
