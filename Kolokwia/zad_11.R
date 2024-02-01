library(tidyverse)
library(ggplot2)

# wykorzystując zbiór danych sopa_zm50.csv oraz etykiety etykietySopa_zm50.txt 
# zbudować wykres na którym pojawi się odsetek gospodarstw domowych które stać 
# na pewne dobra (zmienne od af1_1 do af1_13). odpowiedzi dla zmiennych af1 
# oprócz tak nie są inne i należy traktować je jako braki danych

sopa_zm50 <- read.csv("sopa_zm50.csv", header = TRUE)
etykiety <- read.table("etykietySopa_zm50.txt", header = TRUE)
  # wczytanie danych

zmienne_af1 <- sopa_zm50$af1_1:af1_13
  # Wybranie zmiennych od af1_1 do af1_13

zmienne_af1[zmienne_af1 != "tak" | zmienne_af1!="nie"] <- NA

  # 1 opcja
    zmienne_af1 <- apply(zmienne_af1, 2, as.numeric)
    odsetki <- apply(!is.na(zmienne_af1), 2, mean)
    # oblicza odsetki 
  
  # 2 opcja
    wyniki <- sopa_zm50 %>%
      summarise(across(everything(), ~mean(!is.na(.))))

wyniki <- data.frame(dobra = colnames(zmienne_af1), odsetek = odsetki)
  # utworzenie ramki danych z wynikami

ggplot(wyniki, aes(x = dobra, y = odsetek)) + geom_col() +  
  labs(title = "Odsetek gospodarstw domowych stać na dobra",x = "Dobra", y = "Odsetek (%)")
  # utworzenie wykresu słupkowego gdzie oś X to dobra (af1_1:af1_13) a oś Y to odsetek