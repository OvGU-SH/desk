#' Gravity Model Applied to Germany
#'
#' @description This is a data set on German trade with its 27 EU-partners in 2014.
#'
#' @format A data frame with 27 observations on the following five variables:
#' \tabular{ll}{
#' \code{country} \tab name of member state.\cr
#' \code{imports} \tab German imports from member state (in million euro).\cr
#' \code{exports} \tab German exports to member state (in million euro).\cr
#' \code{gdp} \tab gross domestic product of member state (in million euro).\cr
#' \code{dist} \tab distance between member state and Germany (in km).\cr
#' }
#'
#' @details
#' In Auer et al. (2023, Chaps. 9 & 14) these data are used to illustrate the estimation and functional specification of a multivariate linear regression model.
#'
#' @source
#' Downloaded in 2015 from online platform of Eurostat (\url{https://ec.europa.eu/eurostat/home}).
#'
#' Distances computed by FreeMapTools (\url{https://www.freemaptools.com}).
#'
#' @references
#' Auer, L.v., Hoffmann, S. & Kranz, T. (2023): Ökonometrie - Das R-Arbeitsbuch, 2nd ed., Springer-Gabler (\bold{https://www.oekonometrie-lernen.de}).
#'
"data.trade"
