library(tidyverse)
library(ggplot2)

# 1
  # Wczytaj plik z danymi faktury.dat i zapisz go w obiekcie o nazwie fakt.
  # wykorzystaj identyfikator opiekuna (id_opiekuna) oraz przychód jaki generował 
  # jego klient(SUMA) i oblicz średnią, medianę, pierwszy i trzeci kwantyl przychodu dla
  # każdego opiekuna. ramkę nazwij handelStat
  
  fakt <- read.table("dane/faktury.dat")
    # wczytuje dane, można dodać nagłówek i separator
  
  handelStat <- fakt %>% group_by(id_opiekuna) %>%
    summarise(srednia = mean(SUMA),
              Q1 = quantile(SUMA, probs = 0.25),
              mediana = median(SUMA),
              Q3 = quantile(SUMA, probs = 0.75))
    # tworzy ramkę danych, grupując dane według identyfikatora opiekuna
    # używa funkcji summarise aby obliczyć dla każdego opiekuna:
        # srednia = mean(SUMA): Średnią wartość przychodu (SUMA).
        # Q1 = quantile(SUMA, probs = 0.25): Pierwszy kwantyl przychodu.
        # mediana = median(SUMA): Medianę przychodu.
        # Q3 = quantile(SUMA, probs = 0.75): Trzeci kwantyl przychodu


# 2
  # ramkę danych fakt przekształć tak aby zawierała 3 zmienne: sma_pakiet, okres i norma.
  # okres składa się z nazw zmiennych od sty2013 do gru2013, których wartości są w kolumnie norma,
  # nazwij tą ramkę df_pivot 
  
    fakt <- fakt %>% select(sms_pakiet, sty2013:gru2013)
      #  Wybiera tylko kolumne "sms_pakiet" oraz kolumny od stycznia do grudnia
    
    df_pivot <- pivot_longer(fakt, cols = sty2013:gru2013, names_to = "okres", values_to = "norma")
      # przekształca szeroką ramkę danych na formę długą
      # kolumny z wartościami od sty2013 do gryu2013 są przekształcone na kolumne okres 
      # wynikiem są 3 kolumny sma_pakiet, okres i norma
  

  