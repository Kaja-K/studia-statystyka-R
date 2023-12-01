# funkcje
  y <- 2
  Dodaj <- function(x) {x + y}
  Dodaj(5)
  
  Dodaj <- function(x, y) {x + y}
  Dodaj(5, 2)
  
  Dodaj <- function(x, y) {
    z <- x + y
    return(z) # zwraca i zatrzymuje się
    x - y}
  Dodaj(5, 10)
  
  Dodaj <- function(x, y) {
    z <- x + y
    z
    x - y}
  
  Dodaj(5, 10)


      # Oblicz średnią i wariancję z wartości wektora
      # Zwróć wektor o2 elementach: srednia i wariancja
  
        SredWar <- function(x) {
          N <- length(x)
          mojaSrednia <- sum(x)/N
          mojaWariancja <- (x - mojaSrednia)^2
          mojaWariancja <- sum(mojaWariancja)/N
        return(c(mojaSrednia, mojaWariancja))} # zwraca wektor; zamiast c, użyj data.frame
        
        myVec <- c(2, 7, 3, 5, 4, 1, 9)
        SredWar(myVec)
        SredWar(rnorm(20)) #średnia z wygenerowanych liczb
        
    
  # funkcje anonimowe
        
        # Generujemy wartości dla każdej kolumny
        ramka <- data.frame(kol1 = rnorm(20), kol2 = rnorm(20), kol3 = rnorm(20))
        head(ramka, 2)
        
        apply(ramka, 2, function(x)sum(x^2)) # funkcja anonimowa z argumentem x
        apply(ramka, 2, \(x)sum(x^2)) # function(x) zastąpione \(x)
        
        library(tidyverse)
        map_df(ramka, ~sum(.x^2))
        