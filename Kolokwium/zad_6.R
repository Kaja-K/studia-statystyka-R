library(tidyverse)
library(ggplot2)

# będziemy pracować ze zbiorem danych serialeIMBD2.dat
    dane <- read.table("serialeIMBD2.dat", sep = " ", header = TRUE)
      # Wczytuje dane, określa separator, nagłówek

    
# zbuduj wykres punktowy pokazujący zależnośc między oceną a liczbą głosów,
# ale tylko dla tych seriali, które mają odcinek pilotażowy
    
  seriale <- dane %>% filter(nazwa == "Pilot")
    #Tworzy nową ramkę danych, która zawiera tylko wiersze, gdzie wartość w kolumnie "nazwa" to "Pilot".
  
  wyk1 <- ggplot(seriale, aes(x = ocena, y = glosow)) + geom_point() +
    labs(x = "Ocena", y = "Liczba głosów")
      # tworzy wykres punktowy, gdzie oś x to ocena a oś y to głosy, podpisuje osie 

  
# wykorzystaj ten zbiór danych i zbuduj dowolny wykres słupkowy 
  
  wyk2 <- ggplot(dane, aes(x = ocena, y = glosow, colour = nazwa)) + geom_col(position = "dodge") +
    labs(x = "Ocena", y = "Liczba głosów", colour = "Nazwa")
      # tworzy wykres słupkowy odwrócony, gdzie oś x to ocena a oś y to głosy
      # używa zmiennej nazwa do kolorowania elementów na wykresie, podpisuje osie
        # dla każdej różnej nazwy w kolumnie nazwa ggplot automatycznie przypisuje inny kolor
  