\name{new.session}
\alias{new.session}
\title{R Session Reset}
\usage{
new.session(cd = TRUE, sci = FALSE)
}
\arguments{
\item{cd}{if cd = FALSE, the working directory is not be changend. The default, cd = TRUE, sets the working directory to source file loction.}
\item{sci}{if sci = TRUE, the scientific notation is reset to the R standard option.}
}
\value{
None.
}
\description{
Removes all objects from global environment. Removes all plots. Clears the console. As default, sets the working directory to source file loction in case the function is used from an R script. As an option, resets the scientific notation (e.g., 1e-04).
}
\examples{
## R Session reset without changing the current working directory
new.session(FALSE) # new.session(F)

}
\concept{.GlobalEnv}
\concept{delete}
\concept{environment}
\concept{objects}
\concept{remove}
