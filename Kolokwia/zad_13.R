library(tidyverse)
library(ggplot2)

# Wczytaj zbiór danych credit_card, Pierwsza zmienna powinna mieć nazwę custid, 
# Jezeli jest ona inna to ją zmień

  credit_card <- read.csv("ścieżka/do/credit_card.csv", header = TRUE)
    # wczytanie danych z pliku, uwzględnienie nagłówka  
  
    colnames(credit_card)[1] <- "custid"
    # jeżeli nazwa pierwszej zmiennej nie jest oczekiwana zmień na nią


# a) Zbudować tabelę, w której znajdą się średnie wydatki (spent) w każdym 
#     miesiącu (month). Wyniki przedstawić na wykresie.
  
  spent_month <- credit_card %>% 
    group_by(month) %>%
    summarise(srednie_wydatki = mean(spent, na.rm = TRUE))

  ggplot(table_spent_month, aes(x = month, y = srednie_wydatki)) + geom_col() +
    labs(title = "Średnie wydatki w każdym miesiącu", x = "Miesiąc", y = "Średnie wydatki")

  
#b) Stworzyć wykres pudelko-wąsy, uwzględniając zmienne: wydatki (spent), 
#   rodzaj karty (card), rok (year). Dodatkowo użyć następujących statystyk: 
#   współczynnik asymetrii, kurtozę, pierwszy i trzeci kwartyl oraz medianę do
#   zbudowania tabeli z udziałem tych zmiennych. Wykorzystując tabelę i wykres dokonać interpretacji.
  
  ggplot(credit_card, aes(x = card, y = spent, fill = as.factor(year))) + geom_boxplot() +
    labs(title = "Wykres pudełkowo-wąsy", x = "Rodzaj karty", y = "Wydatki", fill = "Rok") 
  
    # utworzenie wykresu pudełko-wąsy 
    # fill = as.factor(year) - przekształca zmienną year na kategoryczną (czynnikową),
    #                          oznacza to że chcemy kolorować wykresy zależnie od roku.
  
  tabela <- credit_card %>% 
    group_by(card, year) %>% 
    summarise( srednia = mean(spent, na.rm = TRUE),
              odchylenie = sd(spent, na.rm = TRUE),
              asymetria = skewness(spent, na.rm = TRUE),
              kurtoza = kurtosis(spent, na.rm = TRUE),
              Q1 = quantile(spent, probs = 0.25, na.rm = TRUE),
              mediana = median(spent, na.rm = TRUE),
              Q3 = quantile(spent, probs = 0.75, na.rm = TRUE))


#c) Zbuduj wykres punktowo-liniowy, na którym uwzględnisz następujące zmienne 
#   wydatki (spent), typ transakcji (type trans), pleć (gender), rok urodzenia (birth_year).
  
  ggplot(credit_card, aes(x = spent, y = birth_year, color = type_trans, shape = gender)) + geom_point() + geom_line() +
    labs(title = "Punktowo-liniowy wykres", x = "Wydatki", y = "Rok urodzenia", color = "Typ transakcji", shape = "Płeć")
