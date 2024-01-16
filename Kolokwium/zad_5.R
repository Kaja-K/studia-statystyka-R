library(tidyverse)
library(ggplot2)

# w katalogu daneQuiz masz plik o nazwie Kmq0p8l45wf. wczytaj go i przyjmij
# nazwę ramki danych: ramka. wykorzystaj odpowiednie funkcje i podaj liczbę 
# kolumn oraz wierszy. podaj też liczbę zmiennych typu numerycznego

  ramka <- read.table("daneQuiz/Kmq0p8l45wf.txt")
  
  nrows(ramka)
    # liczba wierszy w ramce
  
  ncols(ramka)
    # liczba kolumn w ramce

  length(which(sapply(ramka, is.numeric)))
    # liczba zmiennych numerycznych