#' Expenditures of the EU-25
#'
#' @description This is a data set on the shares of total EU-expenditures received by the individual member states of the EU-25 in 2005. Furthermore, the data describe some relevant characteristics (population share, gross domestic product, etc.) of these member states.
#'
#' @format A data frame with 25 observations on the following seven variables:
#' \tabular{ll}{
#' \code{member} \tab EU member state.\cr
#' \code{expend} \tab share of EU-expenditures received by the member state.\cr
#' \code{pop} \tab member state's population share of the total EU-25-population.\cr
#' \code{gdp} \tab index relating the member state's per capita income to the average EU-25 per capita income, adjusted for different national price levels.\cr
#' \code{farm} \tab ratio of the member state's gross value added in agriculture to the member state's gross domestic product.\cr
#' \code{votes} \tab the member state's voting share in the Council of Ministers.\cr
#' \code{mship} \tab logarithm of the number of months that the member state is part of the EU.\cr
#' }
#'
#' @source
#' Downloaded in 2007 from \url{https://commission.europa.eu/strategy-and-policy/eu-budget_en}, \url{https://ec.europa.eu/eurostat}.
#'
#' @references
#' Auer, L.v. (2008): Eine empirische Analyse der EU-Ausgabenpolitik, in H. Gischer, P. Reichling, T. Spengler, A. Wenig (eds.), Transformation in der Oekonomie - Festschrift fuer Gerhard Schwoediauer zum 65. Geburtstag, Gabler.
#'
#' Auer, L.v., S. Hoffmann (2017) Oekonometrie - Das R-Arbeitsbuch, Springer-Gabler (\bold{https://www.oekonometrie-lernen.de}).
#'
"data.eu"
