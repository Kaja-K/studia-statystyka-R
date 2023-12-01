Transform <- function(y, lambda) {
  if (lambda == 0) {
    return(log(y))}
  return(sign(y) * (abs(y) ^ lambda - 1) / lambda)}

wektor <- c(1, 2, 3, 4, 5)
lambda <- 2
transformed <- Transform(wektor, lambda)
transformed


Transform <- function(y, lambda) {
  if (lambda == 0) {
    return(log(y))}
  
  if (any(y < 0) && lambda < 0) {
    return(NA)}
  
  return(sign(y) * (abs(y) ^ lambda - 1) / lambda)}

wektor <- c(-1, -2, -3, -4, -5)
lambda <- -2
transformed <- Transform(wektor, lambda)
transformed


Transform <- function(y, lambda) {
  if (lambda == 0) {
    return(log(y))}
  
  if (any(y < 0) && lambda < 0) {
    return(NA)}
  
  return(sign(y) * (abs(y) ^ lambda - 1) / lambda)}

wektor <- c(1, 2, 3, 4, 5)
lambda <- 0
Transform(wektor, lambda)
