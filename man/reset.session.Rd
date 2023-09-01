\name{reset.session}
\alias{reset.session}
\title{R Session Reset}
\usage{
reset(cd = TRUE)
}
\arguments{
\item{cd}{if cd = FALSE, the working directory is not be changend. The default, cd = TRUE, sets the working directory to source file loction.}
}
\value{
None.
}
\description{
Removes all objects from global environment. Removes all plots. Resets the scientific notation (e.g., 1e-04). Clears the console. As default, sets the working directory to source file loction in case the function is used from an R script.
}
\examples{
## R Session reset without changing the current working directory
reset.session(FALSE) # reset.session(F)

}
\concept{.GlobalEnv}
\concept{delete}
\concept{environment}
\concept{objects}
\concept{remove}
