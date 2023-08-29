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
