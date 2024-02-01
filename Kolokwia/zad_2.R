library(tidyverse)
library(ggplot2)

# 1
  # wczytaj plik z danymi rowery_pol.csv. Utwórz ramkę o nazwie rower która będzie miała
  # wartości dla zmiennej dzien:niedziela, wtorek. od tej pory pracuj z tą ramką.
  # W odpowiedzi podaj średnią wartośc wilgotności z dokładnością do 1 miejsca po przecinku.

    rower <- read.csv2("dane/rowery_pol.csv", header = TRUE, sep = ";")
      # wczytuje dane z nagłówkiem i separatorem
      # zmienne w ramce - rower, dzień, pogoda, wilgotność, kwartal
    
    rower <- rower %>% filter(dzien == "wtorek" | dzien == "niedziela")
      # filtruje dane i zachowuje tylko te wiersze z niedzielą i wtorkiem
    
    round(mean(rower$wilgotnosc, na.rm = TRUE), 1)
      # oblicza średnią wartość z kolumny "wilgotnosc" oraz zaokrągla wynik
  

# 2
  # dla zmiennej wilgotnosc policz średnią, wariancje, medianę i rozstęp 
  # międzykwartylowy w podziale na godziny wypożyczenia (godzina). Ramkę nazwij rowerStat

    rowerStat <- rower %>% group_by(godzina) %>%
      summarise(srednia = mean(wilgotnosc),
                wariancja = var(wilgotnosc),
                mediana = median(wilgotnosc),
                iqr = IQR(wilgotnosc))
    
      # Tworzy nową ramkę danych rowerStat, grupując dane ze względu na kolumnę "godzina". 
      # Wszystkie następne operacje dotyczące obliczeń statystycznych będą 
      # przeprowadzane dla każdej unikalnej godziny.
      
        # Tworzy podsumowanie dla każdej grupy godzinowej. Dla każdej grupy oblicza:
          # srednia = mean(wilgotnosc): Średnią wartość kolumny "wilgotnosc".
          # wariancja = var(wilgotnosc): Wariancję kolumny "wilgotnosc".
          # mediana = median(wilgotnosc): Medianę kolumny "wilgotnosc".
          # iqr = IQR(wilgotnosc): Rozstęp międzykwartylowy kolumny "wilgotnosc".
    

# 3
  # zbuduj tabelę krzyżową o nazwie rowerProc dla zmiennych pogoda i dzien 
  # oprócz liczebności niech pokazuje odsetki. policz te odsetki w taki sposób 
  # aby dla zadanej wartości zmiennej dzień odsetki drugiej zmiennej sumowały się do 1
  
    rowerProc <- rower %>%
      select(dzien, pogoda) %>%
      group_by(dzien, pogoda) %>%
      summarise(ile = n()) %>%
      mutate(odsetek = ile/sum(ile))
        # select(dzien, pogoda): wybiera kolumny dzień i pogoda
        # group_by(dzien, pogoda): grupuje dane według tych kolumn
        # summarise(ile = n()): oblicza obserwacje w każdej grupie
        # mutate(odsetek = ile/sum(ile)): dodaje kolumnę odsetek 
      
        # odsetki - obliczane jako iczba obserwacji dla danej kombinacji 
        # podzielona przez sumę obserwacji dla wszystkich kombinacji w danym dniu.
    
      pivot_wider(rowerProc, id_cols = pogoda, names_from = dzien, values_from = c(ile, odsetek))
    
        # Przekształca dane, aby uzyskać szerszą tabelę, gdzie kolumny odpowiadają 
        # unikalnym wartościom "dzien", a wiersze odpowiadają unikalnym wartościom "pogoda". 
        # Kolumny "ile" i "odsetek" są przedstawione dla każdego połączenia "dzien" i "pogoda".
    
          # tabela rowerProc będzie miała kolumny "pogoda", "wtorek_ile", 
          # "wtorek_odsetek", "niedziela_ile", "niedziela_odsetek", gdzie wartości "ile" 
          # to liczba obserwacji, a "odsetek" to odsetek dla danej kombinacji.
      
  
# 4 
  # Wykorzystaj ramkę rower i stwórz hierarchię najczęściej występujących godzin 
  # pod względem sumarycznej liczby wypożyczeń (wypożyczenia)
  # dla godziny na miejscu 3 wyznacz maksymalną liczbę wypożyczeń 
    
      hierarchia_godzin <- rower %>%
        group_by(godzina) %>%
        summarise(wypozyczenia = n()) %>%
        arrange(desc(wypozyczenia)) %>%
        select(godzina)
          # Grupuje dane według godziny i oblicza liczbe wypożyczeń dla każdej godziny
          # arrange(desc()): sortuje dane malejąco według liczby wypozyczen
          # zachwouje tylko kolumne godzina 
    
      rower %>% filter(godzina %in% hierarchia_godzin[3,]) 
          # Załóżmy, że trzecia najczęściej występująca godzina to "17", i 
          # istnieje 50 wypożyczeń o godzinie "17". Wówczas, jeśli wszystkie 50 
          # wierszy dotyczących godziny "17" zostaną zachowane, to tyle właśnie 
          # wartości zostanie wybranych.
      
        # R indeksuje wartości od 1 (nie od 0)
