# Dodanie do zadania 5_3 wykresów - tabela aut została zmniejszona aby uzyskać czytelnośc wykresów

library(tidyverse)
library(ggplot2)
  auto <- read.csv("Zadania/Dane/AutoSprzedam.dat", header=TRUE, sep = "\t")
  names(auto)[1] <- "NrOferty"
  auto <- head(auto,50)
  colnames(auto)

#Stworzenie ramki danych df_niePolska bez ofert z Polski
  df_niePolska <- auto %>% filter(KrajPochodzenia != "Polska")

  ggplot(df_niePolska, aes(x = PojemnoscSkokowa, y = CenaPLN)) + geom_point() +
  labs(title = "Wykres punktowy dla ofert spoza Polski", x = "Pojemność skokowa", y = "Cena (PLN)")

#Stworzenie ramki danych df_kraje3 z trzema najczęściej występującymi krajami
  df_kraje3 <- auto %>%
    count(KrajPochodzenia) %>%
    top_n(3) %>% #trzy najczęściej występujące kraje
    select(KrajPochodzenia) %>%
    inner_join(auto, by = "KrajPochodzenia") %>%
    write.table("Zadania/Dane/df_kraje3.csv", sep = ",", row.names = FALSE)
  
    #odczytanie wyniku wyżej
    df_kraje3 <- read.csv("Zadania/Dane/df_kraje3.csv", header=TRUE, sep = ",")
    head(df_kraje3,10)
    
    ggplot(df_kraje3, aes(x = PojemnoscSkokowa, y = CenaPLN, color = KrajPochodzenia)) + geom_point() +
      labs(title = "Wykres punktowy dla trzech najczęściej występujących krajów", x = "Pojemność skokowa", y = "Cena (PLN)", color = "Kraj pochodzenia")



#Utworzenie ramki danych df_kolor zawierającej samochody w kolorze czarny-metallic
  df_kolor <- auto %>% filter(Kolor == "czarny-metallic")
  
  ggplot(df_kolor, aes(x = KM, y = CenaPLN)) + geom_point() +
    labs(title = "Samochody koloru czarnego",x = "KM", y = "CenaPLN")

    #Dodanie zmiennej cena_eur do ramki danych auto
      auto <- auto %>%
        mutate(CenaPLN = as.numeric(CenaPLN)) %>%  # zmiana typu na numeryczny
        mutate(cena_eur = round(CenaPLN / 4.31, 1))

#Utworzenie ramki danych df_akcyza zgodnie z opisem
  auto <- auto %>% mutate(CenaPLN = as.numeric(CenaPLN))
  df_akcyza <- auto %>%
    mutate(Akcyza = ifelse(PojemnoscSkokowa <= 2000, CenaPLN * 0.031, CenaPLN * 0.186),
           CenaAkcyza = round(CenaPLN + Akcyza)) %>%
    select(KrajPochodzenia, PojemnoscSkokowa, CenaPLN, Akcyza, CenaAkcyza)
    
  ggplot(df_akcyza, aes(x = PojemnoscSkokowa, y = CenaAkcyza)) + geom_point() +
      labs(title = "PojemnoscSkokowa vs CenaAkcyza", x = "PojemnoscSkokowa", y = "CenaAkcyza")


#Usunięcie obserwacji dla których RodzajPaliwa to hybryda lub napęd elektryczny oraz zrekodowanie zmiennej RodzajPaliwa na benzyna i olej napędowy
  auto <- auto %>% filter(!(RodzajPaliwa %in% c("hybryda", "napęd elektryczny"))) %>%
    mutate(RodzajPaliwa = ifelse(RodzajPaliwa %in% c("benzyna", "olej napędowy"), RodzajPaliwa, NA))
  
  ggplot(auto, aes(x = RokProdukcji, y = CenaPLN, color = RodzajPaliwa)) + geom_point() +
    labs(title = "Rodzaje paliwa a cena i rok produkcji",  x = "RokProdukcji", y = "CenaPLN")