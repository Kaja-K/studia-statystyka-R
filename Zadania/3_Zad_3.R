WspolRozklad <- function(x) {
    N <- length(x)
    
    skosnosc <- (N / ((N - 2) * (N - 1))) * sum((x - mean(x)) ^ 3)
    s3 <- sqrt(var(x)) ^ 3
    kurtoza <- (N * (N + 1)) / ((N - 1) * (N - 2) * (N - 3)) * sum((x - mean(x)) ^ 4) / (s3 ^ 2) - 3 * (N - 1) ^ 2 / ((N - 2) * (N - 3))
  
  return(c(skosnosc, kurtoza))}

# Przykład użycia
WspolRozklad(c(20:30))
