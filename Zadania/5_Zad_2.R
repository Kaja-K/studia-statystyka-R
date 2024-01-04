library(tidyverse)

#dane
dane_mieszkania <- read.csv("Zadania/Dane/mieszkania.txt", sep = ";", header = TRUE, dec = ",")
colnames(dane_mieszkania)

#Dodaj kolumnę cena_m2
dane_mieszkania <- dane_mieszkania %>% mutate(cena_m2 = cena / powierzchnia)
dane_mieszkania

#Ile ofert jest w każdym mieście? Policz odsetki.
liczba_ofert_miasto <- dane_mieszkania %>%group_by(miasto) %>% summarise(liczba_ofert = sum(cena_m2)) %>% mutate(odsetki = liczba_ofert / sum(liczba_ofert))
liczba_ofert_miasto

#Zbuduj tabelę z rozkładem liczby ofert ze względu na rok i miasto
tabela_rok_miasto <- dane_mieszkania %>% group_by(rok, miasto) %>% summarise(liczba_ofert = sum(cena_m2)) %>% mutate(odsetki = liczba_ofert / sum(liczba_ofert))
tabela_rok_miasto

#Stworzenie tabeli z rozkładem liczby ofert ze względu na rok (każde miasto z tym samym zakresem lat)
tabela_rok <- dane_mieszkania %>% group_by(rok) %>% summarize(liczba_ofert = sum(cena_m2))
tabela_rok

#Które miasto ma najdroższe mieszkania?
dane_mieszkania %>%
  group_by(miasto) %>% 
  summarise(srednia_cena_m2 = mean(cena_m2)) %>%
  filter(srednia_cena_m2 == max(srednia_cena_m2)) %>%
  select(miasto)

