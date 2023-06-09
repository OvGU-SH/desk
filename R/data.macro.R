#' Macroeconomic Data from Germany
#'
#' @description This is a (time series) data set on macroeconomic data from Germany covering 129 consecutive quarters.
#'
#' @format A data frame with 129 observations on the following four variables:
#' \tabular{ll}{
#' \code{quarter} \tab identifies the time period in combination with \code{year}. \cr
#' \code{year} \tab identifies the time period in combination with \code{quarter}. \cr
#' \code{consump} \tab private consumption in the observed quarter. \cr
#' \code{gdp} \tab gross domestic product in the observed quarter. \cr
#' }
#' @details
#' These National Accounts data are measured in real quantities (billions of chained 2015 Euros)
#' and are calendar and seasonally-adjusted (method: X13 JDemetra+).
#'
#' @source
#' Downloaded in 2023 from \url{https://www-genesis.destatis.de/genesis/online} (Federal Statistical Office of Germany, data ID: 81000-0020).
#'
#' @references
#' Auer, L.v., Hoffmann, S. & Kranz, T. (2023): Ökonometrie - Das R-Arbeitsbuch, 2nd ed., Springer-Gabler (\bold{https://www.oekonometrie-lernen.de}).
#'
"data.macro"
