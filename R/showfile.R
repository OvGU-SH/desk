#' Print ASCII File to Console
#'
#' @description Print an ASCII encoded text file to the console. Useful for quickly viewing .txt or .csv data sets.
#'
#' @param file name of the file to be printed to the console.
#' @param head numeric value. Numbers of lines to be printed out. Default value is set to print everything.
#'
#' @return None.
#' @export
#'
#' @examples
#' MyPath <- file.path(.libPaths()[1], "desk", "extdata", "Labor.txt")
#' showfile(MyPath) # show everything
#' showfile(MyPath, head = 4) # show only first 4 lines
#'
#' @concept arguments, function, default value
#'
showfile = function(file, head = "all"){
  pos = regexpr("\\.([[:alnum:]]+)$", file)
  ext = ifelse(pos > -1L, substring(file, pos + 1L), "")
  if(any(c("txt", "csv") == ext)){
    out = readLines(file)
    if (head == "all") out = out[1:length(out)] else out = out[1:head]
    writeLines(out)
  } else {
    stop("Sorry, works only for .txt or .csv files.", call. = F)
  }
}
