library(tidyverse)

###############################################################################

#dane - dane są wypisane po cudzysłowie, występuje nagłówek, części dziesiętne są po przecinku

  mieszkania <- read.csv("Zadania/Dane/mieszkania.txt", sep = ";", header = TRUE, dec = ",")
  colnames(mieszkania)

###############################################################################

#Dodaj kolumnę cena_m2 - iloraz ceny do powierzchni

  mieszkania <- mieszkania %>% 
    mutate(cena_m2 = round(cena/powierzchnia,2))

###############################################################################

#Ile ofert jest w każdym mieście? Policz odsetki. 

  mieszkania %>% group_by(miasto) %>% 
    summarise(liczba_ofert = n()) %>% 
    mutate(odsetki = liczba_ofert/sum(liczba_ofert))

###############################################################################

#Zbuduj tabelę, w której znajdzie się rozkład liczby ofert ze względu na rok i miasto. 
#Dodaj kolumnę odsetek ofert. W obrębie której kategorii odsetki powinny sumować się do 1
  
  mieszkania %>% group_by(rok, miasto) %>% 
    summarise(liczba_ofert = n()) %>% 
    mutate(odsetki=liczba_ofert/sum(liczba_ofert)) %>% 
    select(-liczba_ofert)
  
  # odsetki sumują się do 1 w odrębie każdego roku i miasta

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
  
###############################################################################

#Które miasto ma najdroższe mieszkania?

  mieszkania %>%
    group_by(miasto) %>% 
    summarise(srednia = mean(cena_m2)) %>%
    filter(srednia == max(srednia)) %>% #2 opcja - top_n(1,srednia)
    select(miasto)

###############################################################################

