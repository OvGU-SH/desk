Sxy = function(x, y = x, na.rm = FALSE){
  if(na.rm){
    x = na.omit(x)
    y = na.omit(y)
  }
  if(length(x) == length(y)){
  return(sum( (x - mean(x)) * (y - mean(y))))
  } else {
  cat("Variables must have same length!")
  }
}
