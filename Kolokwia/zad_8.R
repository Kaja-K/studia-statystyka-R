library(tidyverse)
library(ggplot2)

# masz zbiór danych sopaKobiety.csv. wykoprzystaj go i zbuduj wykres, który pokaże
# średnią i medianę doch9odu (dochod2009) w zależności od miejscowości (klasa_miejscowosci)
# wykonaj go zgodnie ze sztuką tworzenia wykresów

  data <- read.csv2("dane/sopaKobiety.csv", header = TRUE, sep = ";")
    # Wczytuje dane, określa separator, nagłówek
  
  data_stat <- data %>% group_by(klasa_miejscowosci) %>%
    summarise(mediana = median(dochod2009), srednia = mean(dochod2009))
    # Grupuje dane według klasy miejscowości (klasa_miejscowosci) i oblicza medianę
    # (median) oraz średnią (mean) dla dochodu (dochod2009). 
  
  data_pivot <- pivot_longer(data_stat, cols = c(srednia, mediana), names_to = "typ", values_to = "wartosci")
    # Przekształca ramkę danych data_stat z szerokiej do długiej postaci
  
  ggplot(data_pivot, aes(x = klasa_miejscowosci, y = wartosci, fill = typ)) + geom_col() +
    labs(title = "Średnia vs mediana dla klas miejscowości",x = "Klasa miejscowości", y = "Wartość", 
         fill = "Typ statystyki podsumowującej")
    # Tworzy wykres kolumnowy (geom_col) na podstawie danych w ramce data_pivot. Oś X to klasa miejscowości, 
    # oś Y to wartość (średnia lub mediana), a kolor kolumny oznacza typ statystyki (średnia lub mediana)