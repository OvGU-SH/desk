\docType{data}

\name{data.kmenta}

\alias{data.kmenta}

\title{Market data of the U.S. Economy 1922-1941}

\format{
A data frame of 20 observations with the following 5 variables:
\tabular{ll}{
\code{consump} \tab food consumption per capita.\cr
\code{price} \tab ratio of food prices to general consumer prices.\cr
\code{income} \tab disposable income in constant dollars.\cr
\code{farmPrice} \tab ratio of preceding year's prices received by farmers to general consumer prices.\cr
\code{trend} \tab time trend in years.\cr
}
}

\source{
Kmenta (1986), Table 13-1, page 687, also available in R package \pkg{systemfit}.
}

\usage{
data.kmenta
}

\description{
This dataset can be used to illustrate estimation supply and demand in a simple simultaneous-equation market model.
}

\details{
The dataset is used in the examples of the \link{ivr} function to show the basic usage of the function.
}

\references{
Kmenta, J. (1986): Elements of Econometrics, 2nd Edition, Macmillan, New York.
}

\keyword{datasets}
