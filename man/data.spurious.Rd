\docType{data}
\name{data.spurious}
\alias{data.spurious}
\title{Non-Stationary Time Series Data}
\format{
A data frame with yearly observations from 1880 to 2022 on the following five variables:
\tabular{ll}{
\code{year} \tab year of the observation.\cr
\code{temp} \tab deviation of the pre-industrial average global temperature.\cr
\code{elements} \tab number of discovered elements in chemistry (periodic table).\cr
\code{gold} \tab price for 1 ounce of fine gold in US-Dollar (not inflation-adjusted) starting in 1968.\cr
\code{cpi} \tab consumer price index: total all items for the United States (index 2015 = 100) starting in 1968.\cr
}
}
\source{
Downloaded in 2023 from NASA (\url{https://data.giss.nasa.gov/gistemp/}), IUPAC (\url{https://iupac.org/what-we-do/periodic-table-of-elements/}), Deutsche Bundesbank Zeitreihen-Datenbanken (BBEX3.A.XAU.USD.EA.AC.C08), and OECD (retrieved from FRED, \url{https://fred.stlouisfed.org/series/CPALTT01USA661S}).
}
\usage{
data.spurious
}
\description{
The variables in this data set are non-stationary and help to understand spurious regression in the context of time series analysis.
}
\details{
In Auer et al. (2023, Chap. 22) these data are used to illustrate the estimation of dynamic regression models.
}
\references{
Auer, L.v., Hoffmann, S. & Kranz, T. (2023): Ökonometrie - Das R-Arbeitsbuch, 2nd ed., Springer-Gabler (\bold{https://www.oekonometrie-lernen.de}).
}
\keyword{datasets}
