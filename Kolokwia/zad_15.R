library(tidyverse)
library(ggplot2)

# Wczytaj zbiór danych sopakobiety.csv wiedząc, że brak danych reprezentowane 
# są przez pojedynczą spację (szcze gółowe nazwy zmiennych są w pliku etykiety.xlsx). 
# Następnie zaproponuj i zweryfikuj odpowiednie hipotezy statystyczne na poziomie 
# istotności a=0.01. Wnioski wzmocnij odpowiednimi przedziałami ufności.

sopakobiety <- read.csv("dane/sopakobiety.csv", sep = " ", header = TRUE)

# a) uwzględniając niektóre ze zmiennych: ep4, ep13, eduk4 2009

  # H0: brak różnic między wartościami zmiennych w roku 2009
  # H1: różnice między wartościami zmiennych w roku 2009
  chisq.test(table(sopakobiety$ep4, sopakobiety$ep13, sopakobiety$eduk4))
  # Decyzja: nie ammy podstaw do odrzucenia hipotez ponieważ p-wartość > 0.01

# b) uwzględniając niektóre ze zmiennych: ep121, ep103, dochod2009.
  
  # H0: Brak istotnych różnic między wartościami zmiennych ep121, ep103, dochod2009.
  # H1: Istnieją istotne różnice między wartościami zmiennych ep121, ep103, dochod2009
  t.test(sopakobiety$ep121, sopakobiety$ep103, conf.level = 0.99)
  t.test(sopakobiety$ep121, sopakobiety$dochod2009, conf.level = 0.99)
  t.test(sopakobiety$dochod2009, sopakobiety$ep103, conf.level = 0.99)
  #Decyzja: odrzucamy huipoteze zerowa na korzysc alternatywnej bo p-wartosc < 0.01
  
  