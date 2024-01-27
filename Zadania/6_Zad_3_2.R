# Dodanie do zadania 5_2 wykresów

  library(tidyverse)
  library(ggplot2)
    dane_mieszkania <- read.csv("Zadania/Dane/mieszkania.txt", sep = ";", header = TRUE, dec = ",")
    dane_mieszkania <- dane_mieszkania %>% mutate(cena_m2 = cena / powierzchnia)
  
    
###############################################################################
  
  #Ile ofert jest w każdym mieście? Policz odsetki.
    liczba_ofert_miasto <- dane_mieszkania %>%group_by(miasto) %>% 
      summarise(liczba_ofert = sum(cena_m2)) %>% 
      mutate(odsetki = liczba_ofert / sum(liczba_ofert))

    
  ggplot(liczba_ofert_miasto, aes(x = miasto, y = odsetki)) + geom_col() + 
    labs(title = "Odsetki liczby ofert w poszczególnych miastach", y = "Odsetki", x = "Miasto")

  
############################################################################### 
  
  #Zbuduj tabelę z rozkładem liczby ofert ze względu na rok i miasto
  tabela_rok_miasto <- dane_mieszkania %>% group_by(rok, miasto) %>%
    summarise(liczba_ofert = sum(cena_m2)) %>%
    mutate(odsetki = liczba_ofert / sum(liczba_ofert))
  
  ggplot(tabela_rok_miasto, aes(x = miasto, y = odsetki, fill = as.character(rok))) +
    geom_col(position = "dodge") + labs(title = "Odsetki liczby ofert ze względu na rok i miasto", y = "Odsetki")
  
  
############################################################################### 
  
  #Stworzenie tabeli z rozkładem liczby ofert ze względu na rok (każde miasto z tym samym zakresem lat)
  tabela_rok <- dane_mieszkania %>% group_by(rok) %>% summarize(liczba_ofert = sum(cena_m2)/1000)
  
  ggplot(zad2d, aes(x = miasto, y = odsetek_ofert)) + 
    geom_col() + facet_wrap(~ rok, nrow = 1)+
    labs(title = "Rozkład liczby ofert ze względu na rok ", y = "Liczba ofert w tysiącach", x = "Rok")
  
  
############################################################################### 
  
  #Które miasto ma najdroższe mieszkania?
  dane_mieszkania %>% group_by(miasto) %>%  summarise(srednia_cena_m2 = mean(cena_m2)) %>%
    filter(srednia_cena_m2 == max(srednia_cena_m2)) %>% select(miasto)
  
  ggplot(dane_mieszkania %>% group_by(miasto) %>% summarise(srednia_cena_m2 = mean(cena_m2)),aes(x = miasto, y = srednia_cena_m2)) +
    geom_col() + labs(title = "Średnie ceny za metr kwadratowy w poszczególnych miastach", y = "Średnia cena za m2", x = "Miasto")

    
###############################################################################