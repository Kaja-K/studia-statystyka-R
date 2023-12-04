library(dplyr)
library(tidyr)

#dane
auto <- read.csv("Zadania/Dane/AutoSprzedam.dat", header=TRUE, sep = "\t")

#Zmiana nazwy pierwszej kolumny na NrOferty
colnames(auto)[1] <- "NrOferty"
colnames(auto)

#Stworzenie ramki danych df_niePolska bez ofert z Polski
df_niePolska <- auto %>% filter(KrajPochodzenia != "Polska")

head(df_niePolska,5)

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


#Utworzenie ramki danych df_kolor zawierającej samochody w kolorze czarny-metallic
df_kolor <- auto %>% filter(Kolor == "czarny-metallic")
df_kolor

#Dodanie zmiennej cena_eur do ramki danych auto
auto <- auto %>%
  mutate(CenaPLN = as.numeric(CenaPLN)) %>%  # zmiana typu na numeryczny
  mutate(cena_eur = round(CenaPLN / 4.31, 1))

head(auto,5)

#Utworzenie ramki danych df_akcyza zgodnie z opisem
df_akcyza <- auto %>%
  mutate(Akcyza = ifelse(PojemnoscSkokowa <= 2000, CenaPLN * 0.031, CenaPLN * 0.186),
  CenaAkcyza = round(CenaPLN + Akcyza)) %>%
  select(KrajPochodzenia, PojemnoscSkokowa, CenaPLN, Akcyza, CenaAkcyza)

head(df_akcyza,6)

#Usunięcie obserwacji dla których RodzajPaliwa to hybryda lub napęd elektryczny oraz zrekodowanie zmiennej RodzajPaliwa na benzyna i olej napędowy
auto <- auto %>% filter(!(RodzajPaliwa %in% c("hybryda", "napęd elektryczny"))) %>%
  mutate(RodzajPaliwa = ifelse(RodzajPaliwa %in% c("benzyna", "olej napędowy"), RodzajPaliwa, NA))

head(auto,5)
