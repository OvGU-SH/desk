#' Gravity Model Applied to Germany
#'
#' @description This is a data set on German trade with its 27 EU-partners in 2014.
#'
#' @format A data frame with 27 observations on the following five variables:
#' \tabular{ll}{
#' \code{country} \tab name of member state.\cr
#' \code{imports} \tab German imports from member state (in million euro).\cr
#' \code{exports} \tab German exports to member state (in million euro).\cr
#' \code{bip} \tab gross domestic product of member state (in million euro).\cr
#' \code{dist} \tab distance between member state and Germany (in km).\cr
#' }
#'
#' @details
#' In Auer, L. von, S. Hoffmann (2017, Chaps. 9 and 14) these data are used to illustrate the estimation and functional specification of a multivariate linear regression model.
#'
#' @source
#' Downloaded in 2015 from online platform of Eurostat (\url{https://ec.europa.eu/eurostat/home}).
#'
#' Distances computed by FreeMapTools (\url{https://www.freemaptools.com}).
#'
#' @references
#' Auer, L. von, S. Hoffmann (2017) Oekonometrie - Das R-Arbeitsbuch, Springer-Gabler (\url{https://www.oekonometrie-lernen.de}).
#'
"data.trade"
