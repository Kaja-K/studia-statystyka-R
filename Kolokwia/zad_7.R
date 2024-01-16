library(tidyverse)
library(ggplot2)

# napisz funkcje która dla wektora numerycznego x zwróci wektor o 3 wartościach:
# średnia z x, wariancja z x, odchylenie standardowe z x. nazwij ją Statystyki

  Statystyki <- function(x){
    srednia = mean(x, na.rm = TRUE)
    wariancja = var(x, na.rm = TRUE)
    odch_st = sd(x, na.rm = TRUE)
    return(c(srednia, wariancja, odch_st))
  }
  
  Statystyki(1:10)
    
    # na.rm = TRUE - usunięcie brakujących danych (przez co wynik wychodzi numeryczny a nie np. inf/NA)
      # srednia = mean(x, na.rm = TRUE): średnia
      # wariancja = var(x, na.rm = TRUE): wariancja
      # odch_st = sd(x, na.rm = TRUE): odchylenie standardowe 
      # return(c(srednia, wariancja, odch_st): zwraca wektor który zawiera trzy wartości