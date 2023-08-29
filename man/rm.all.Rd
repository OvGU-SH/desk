\name{rm.all}
\alias{rm.all}
\title{Remove All Objects}
\usage{
rm.all(keep = NULL)
}
\arguments{
\item{keep}{a vector of strings specifying object names to be kept in environment, optional, if omitted then all objects in global environment are removed.}
}
\value{
None.
}
\description{
Removes all objects from global environment, except specified ones.
}
\examples{
x = c(1,2)
y = c(4,1)
z = c(3,1)

## Delete all but x and z
rm.all(c("x","z"))

## Delete everything
rm.all()

}
\concept{.GlobalEnv}
\concept{delete}
\concept{environment}
\concept{objects}
\concept{remove}
