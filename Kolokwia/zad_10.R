library(tidyverse)
library(ggplot2)

# zbiór danych sopa2zm.csv ma dwie zmienne af1_13 - stać go na używki, 
# ae10 - jak się zmieniła sytuacja dochodowa. przeprowadzić krótką analizę 
# z uwzględnieniem statystyk podsumowujących, wykresu oraz odpowiendiego testu 
# statystycznego. dokonać interpretacji

sopa2zm <- read.csv("sopa2zm.csv", header = TRUE)
  # wczytanie danych, nagłówka
  
  summary(sopa2zm)
  summary(sopa2zm$af1_13)
  summary(sopa2zm$ae10)
  
  table(sopa2zm)
  table(sopa2zm$af1_13)
  table(sopa2zm$ae10)
  
  # Podstawowe informacje o danych i statystyki podsumowujące

  
ggplot(sopa2zm, aes(x = af1_13, y = ae10)) + geom_point() +
  labs(title = "Wykres punktowy między af1_13 a ae10", x = "af1_13", y = "ae10")
  # Wykres punktowy dla obu zmiennych


  #H0: nie ma różnicy w sytuacji dochodowej a faktem stania go na używki
  #H1: jest różnica w  w sytuacji dochodowej a faktem stania go na używki
  t.test(ae10 ~ af1_13, data = data)
    # Decyzja: odrzucamy hipotezę zerową na korzyśc hipotezy alternatywnej ponieważ p-wartość < 0.05
    # Decyzja: nie mamy podstaw do odrzucenia hipotezy zerowej na korzyść alternatywnej ponieważ p,wartość > od 0.05