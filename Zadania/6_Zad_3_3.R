# Dodanie do zadania 5_3 wykresów

library(tidyverse)
library(ggplot2)

###############################################################################

#dane - wczytanie danych z nagłówkiem, z separatorem \t oraz z częściami dziesiętnymi po przecinku
  auto <- read.csv("Zadania/Dane/AutoSprzedam.dat", header=TRUE, sep = "\t", dec = ",")
  auto <- head(auto,100) 
  # zmniejszenie danych w celu poprawienia czytelności wykresów

#WYKRES
  ggplot(auto, aes(x=Marka, y=CenaPLN, fill = Marka)) +
    geom_col() + 
    labs(x = "Marka samochodu", y = "Cena", title = "Cena każdej marki")

###############################################################################

#Zmiana nazwy pierwszej kolumny NrOferty na IDOferty

  names(auto)[1] <- "IDOferty"

#WYKRES
  ggplot(auto, aes(x=PrzebiegKm, colour = Marka, fill = Marka)) + #fill musi być w funkcji gęstości
    geom_density(alpha = 0.1) + # alpha = ustawia przezroczystość
    labs(x = "Marka", colour = "Przebieg", fill = "Przebieg", title = "Stosunek marki do przebiegu")

###############################################################################

#Stworzenie ramki danych df_niePolska bez ofert z Polski jako kraju pochodzenia

df_niePolska <-  auto %>% filter(KrajPochodzenia != "Polska")

#WYKRES
  ggplot(auto, aes(x=KrajPochodzenia, y=IDOferty)) +
    geom_point() + 
    labs(x = "Kraj Pochodzenia", y = "ID oferty", title = "Stosunek Kraju do ID")

###############################################################################

#Stwórz ramkę danych o nazwie df_kraje3, w której oferty będą uwzględniały tylko 3 najczęściej 
# występujące kraje pochodzenia (pamiętaj o usunięciu nieużywanych poziomów czynnika). 
# Powstałą ramkę zapisz do pliku i otwórz, pobieżnie sprawdzając poprawność eksportu.

  # odczytanie top 3 krajów pod względem ilości ofert
  top3 <- auto %>%
    group_by(KrajPochodzenia) %>%
    summarise(ile_ofert = n()) %>%
    top_n(3) #inna opcja - arrange(desc(ile_ofert)) i odczytać 3 pierwsze

  # utworzenie ramki z tylko top 3 kraje i zapisanie jej do pliku csv
  dfkraje3 <- auto %>%
    filter(KrajPochodzenia %in% top3$KrajPochodzenia) %>%
    write.table("Zadania/Dane/df_kraje3.csv", sep = ",", row.names = FALSE)
  
  #odczytanie wyniku wyżej
  df_kraje3 <- read.csv("Zadania/Dane/df_kraje3.csv", header=TRUE, sep = ",")

#WYKRES
  ggplot(df_kraje3, aes(x = KrajPochodzenia, fill = KrajPochodzenia)) +
    geom_bar() +
    labs(x = "Kraj Pochodzenia", y = "Liczba ofert", title = "Liczba ofert dla top 3 krajów") 

###############################################################################

#Utwórz ramkę danych df_kolor, która zawiera tylko samochody w kolorze czarny-metallic. 
#Kolumnę odnoszącą się do koloru samochodu usuń.

df_kolor <- auto %>% filter(Kolor == "czarny-metallic")%>%
  select(-Kolor)

#WYKRES
  ggplot(df_kolor, aes(x = Marka, y = PrzebiegKm)) +
    geom_point() +
    labs(x = "Marka", y = "Przebieg", title = "Przebieg samochodów w kolorze czarny-metallic") 

###############################################################################

#Dodaj do ramki danych auto zmienną, która będzie ceną sprzedaży w EUR, 
# z dokładnością do jednego miejsca po przecinku. Kurs wymiany to 4.31 PLN/EUR.

  auto <- auto %>%
    mutate(CenaEUR = round(CenaPLN/4.31, digits = 1))

#WYKRES
  ggplot(auto, aes(x = PrzebiegKm, y = CenaEUR)) +
    geom_point() +
    labs(x = "Przebieg", y = "Cena w EUR", title = "Relacja między ceną a przebiegiem")

###############################################################################

#Utwórz ramkę danych df_akcyza, która będzie składała się z 4 zmiennych: PojemnoscSkokowa,
#CenaPLN, Akcyza oraz CenaAkcyza. Pierwsze 2 zmienne występują w oryginalnym zbiorze danych auto. 
#Z kolei akcyzę (Akcyza) wyliczamy według następującego schematu: samochody o pojemności 
#nie przekraczającej 2000 cm3 są opodatkowane stawką 3.1%, powyżej tej pojemności obowiązuje 
#stawka 18.6%. Ostatnia ze zmiennych CenaAkcyza jest sumą ceny i akcyzy. Uwzględnij następujący fakt:
#akcyza dotyczy tylko samochodów sprowadzanych z zagranicy. Dlatego musi być równa 0, jeśli 
#KrajPochodzenia to Polska.

df_akcyza <- auto %>%
  mutate(Akcyza = round(ifelse(KrajPochodzenia == "Polska", 0, 
                               ifelse(PojemnoscSkokowa <= 2000,0.031*CenaPLN,
                                      0.186*CenaPLN)),digits=0),
         
         CenaAkcyza = round(CenaPLN + Akcyza)) %>%
  select(KrajPochodzenia, PojemnoscSkokowa, CenaPLN, Akcyza, CenaAkcyza)

#WYKRES
  ggplot(df_akcyza, aes(x = PojemnoscSkokowa, y = CenaAkcyza, color = KrajPochodzenia)) +
    geom_point() +
    labs(x = "Pojemność Skokowa", y = "Cena z Akcyzą", title = "Relacja między pojemnością a ceną z akcyzą")

###############################################################################

#Ze zbioru danych auto usunąć te obserwacje, dla których RodzajPaliwa to: hybryda 
#lub napęd elektryczny. Następnie zrekodować tą zmienną na dwa poziomy: benzyna i olej napędowy.

  # usunięcie danych z rodzajem paliwa hybryda i napęd elektryczny
  auto_bez_h_ne <- auto %>% 
    filter(RodzajPaliwa != "hybryda" & RodzajPaliwa != "napęd elektryczny")
  
  # sprawdzenie nazw aby móc zrekodować zmienne na dwa poziomy
  unique(auto_bez_h_ne$RodzajPaliwa)
  
  # zmiana rozszerzeń typów paliwa na standardowe
  auto_bez_h_ne$RodzajPaliwa <- recode_factor(auto_bez_h_ne$RodzajPaliwa, 
                "olej napędowy (diesel)" = "olej napędowy",
                "benzyna" = "benzyna",
                "benzyna+LPG" = "benzyna",
                "benzyna+CNG" = "benzyna")

#WYKRES
  ggplot(auto_bez_h_ne, aes(x = RodzajPaliwa, fill = RodzajPaliwa)) +
    geom_bar() +
    labs(x = "Rodzaj Paliwa", y = "Liczba ofert", title = "Rozkład rodzaju paliwa po rekodowaniu")

###############################################################################
