library(tidyverse)
library(ggplot2)

# Wczytaj plik z danymi faktury.dat i zapisz go w obiekcie o nazwie fakt. 
# Następnie wykorzystaj identyfikator opiekuna (id_opiekuna) oraz przychód,
# jaki generował jego klient (SUMA) i oblicz: średnią, medianę, pierwszy i 
# trzeci kwartyl przychodu dla każdego opiekuna. Powstałą ramkę danych nazwij:
# handelStat. Poniżej wyświetlam kilka wierszy. Jako rozwiązanie wpisz wynik,
# jaki zobaczysz po uruchomieniu:
  
  fakt <- read.table("mojeDane/faktury.dat", header = TRUE, dec = ",")
  
  handelStat <- fakt %>%
    group_by(id_opiekuna, SUMA) %>%
    summarise( srednia = mean(SUMA),
               mediana = median(SUMA),
               Q1 = quantile(SUMA, probs = 0.25),
               Q3 = quantile(SUMA, probs = 0.75))

# Ramkę danych fakt przekształć tak, aby zawierała 3 zmienne: sma_pakiet,
# okres i norma. Okres skłąda się z nazw zmiennych od sty2013 do gru2013, 
# których wartości są w kolumnie norma. Nazwij tą przekształconą ramkę df_pivot.
# Poniżej wyświetlam kilka wierszy.
  
  ramka <- fakt %>%
    select(sma_pakiet, sty2013:gru2013)
  
  df_pivot <- pivot_longer(ramka, cols = sty2013:gru2013, names_to = "okres", values_to = "norma")
  
