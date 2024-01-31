# Dodanie do zadania 5_2 wykresów

library(tidyverse)
library(ggplot2)

###############################################################################

#dane - dane są wypisane po przecinku, występuje nagłówek

mieszkania <- read.csv("Zadania/Dane/mieszkania.txt", sep = ";", header = TRUE, dec = ",")
mieszkania_mniej <- head(mieszkania, 100)

#WYKRES
  ggplot(mieszkania_mniej, aes(x = powierzchnia, y = cena/1000)) +
    geom_point() +
    labs(x = "Powierzchnia [m2]", y = "Cena w tysiącach [PLN]", title = "Zależność między ceną a powierzchnią mieszkania")

###############################################################################

#Dodaj kolumnę cena_m2 - iloraz ceny do powierzchni

mieszkania <- mieszkania %>% 
  mutate(cena_m2 = round(cena/powierzchnia,2))

mieszkania_mniej2 <- head(mieszkania,50)

#WYKRES
  ggplot(mieszkania_mniej2, aes(x = powierzchnia, y = cena_m2)) +
    geom_point() +
    labs(x = "Powierzchnia [m2]", y = "Cena za m2 [PLN]", title = "Zależność między ceną za metr kwadratowy a powierzchnią mieszkania")

###############################################################################

#Ile ofert jest w każdym mieście? Policz odsetki. 

liczba_ofert <- mieszkania %>% group_by(miasto) %>% 
  summarise(liczba_ofert = n()) %>% 
  mutate(odsetki = liczba_ofert/sum(liczba_ofert))

#WYKRES
  ggplot(liczba_ofert, aes(x = miasto, y = odsetki)) + 
    geom_col()

###############################################################################

#Zbuduj tabelę, w której znajdzie się rozkład liczby ofert ze względu na rok i miasto. 
#Dodaj kolumnę odsetek ofert. W obrębie której kategorii odsetki powinny sumować się do 1

rozklad_ofert <- mieszkania %>% group_by(rok, miasto) %>% 
  summarise(liczba_ofert = n()) %>% 
  mutate(odsetki=liczba_ofert/sum(liczba_ofert)) %>% 
  select(-liczba_ofert)

# odsetki sumują się do 1 w odrębie każdego roku i miasta

#WYKRES
  #1
  ggplot(rozklad_ofert, aes(x = rok, y = odsetki)) +
    geom_col() +
    facet_wrap(~ miasto, nrow = 2)
  #2
  ggplot(rozklad_ofert, aes(x = rok, y = odsetki, colour = miasto, fill = miasto)) +
    geom_col()
  #3
  ggplot(rozklad_ofert, aes(x = rok, y = odsetki, colour = miasto, fill = miasto)) +
    geom_col(position = "dodge")

###############################################################################

# Stwórz taką samą tabelę jak wyżej z tą różnicą, że każde miasto ma ten sam zakres lat. 
# Następnie przekształć powstałą ramkę tak, aby w kolumnach znalazły się nazwy miast, 
# a wartościami były odsetki zaokrąglone do 2 miejsc po przecinku.

dane <- mieszkania %>%
  select(rok, miasto) %>%
  filter(rok >= 2009) %>% # zakres lat
  group_by(miasto, rok) %>% 
  summarise(ile_ofert = n()) %>%
  mutate(odsetek_ofert = ile_ofert/sum(ile_ofert),
         odsetek_ofert = round(odsetek_ofert, 2)) %>% # zaokrąglenie
  select(-ile_ofert) 

# przekształcenie danych do postaci szerokiej
pivot_wider(dane,names_from = miasto, values_from = odsetek_ofert)

#WYKRES
  ggplot(dane, aes(x = rok, y = odsetek_ofert)) + 
    geom_col() + 
    facet_wrap(~ miasto, nrow = 1)

###############################################################################

#Które miasto ma najdroższe mieszkania?

mieszkania %>%
  group_by(miasto) %>% 
  summarise(srednia = mean(cena_m2)) %>%
  filter(srednia == max(srednia)) %>% #2 opcja - top_n(1,srednia)
  select(miasto)

#WYKRES
  kor <- mieszkania %>%
    group_by(miasto) %>%
    summarise(korelacja = cor(x = rok, y = cena_m2))
  
  ggplot(kor, aes(x = miasto, y = korelacja)) + 
    geom_col() + coord_flip()

###############################################################################