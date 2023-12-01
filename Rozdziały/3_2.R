# pętla for

  # Każdy element wektora podnieś do kwadratu i wyświetl wartość
  liczby <- c(5,3,4,-7)
  for (k in liczby) {print(k^2)}
  
  # Oblicz sumę w każdej kolumnie macierzy x
    x <- matrix(rnorm(50), nc=10) # Generujemy liczby i tworzymy macierz
    suma_x <- 0 # tutaj zapiszemy sumy
    for (j in 1:ncol(x)) {suma_x[j] <- sum(x[, j])}
    suma_x
    
    apply(x, 2, sum) # zamiast pętli