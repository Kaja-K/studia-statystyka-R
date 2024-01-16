library(dplyr)
library(ggplot2)

# Wczytaj zbiór danych sopakobiety.csv wiedząc, że brak danych reprezentowane 
# są przez pojedynczą spację (szcze gółowe nazwy zmiennych są w pliku etykiety.xlsx). 
# Następnie zaproponuj i zweryfikuj odpowiednie hipotezy statystyczne na poziomie 
# istotności a=0.01. Wnioski wzmocnij odpowiednimi przedziałami ufności.

sopakobiety <- read.csv("dane/sopakobiety.csv", sep = " ", header = TRUE)

# a) uwzględniając niektóre ze zmiennych: ep4, ep13, eduk4 2009
  test_a <- t.test(ep4 ~ eduk4, data = sopakobiety)
    # Test t dla dwóch próbek (porównanie średnich)

  #Test t dla dwóch próbek:
    # Jeśli p-wartość jest mniejsza niż poziom istotności (np. 0.01), możemy odrzucić hipotezę zerową. 
    #Poniżej jest przykładowa interpretacja:
      # Jeśli p-value < 0.01, odrzucamy hipotezę zerową, co sugeruje, że średnie dwóch grup są różne.
      # Jeśli p-value >= 0.01, nie mamy podstaw do odrzucenia hipotezy zerowej.
  

# b) uwzględniając niektóre ze zmiennych: ep121, ep103, dochod2009.
  test_b <- t.test(ep121 - ep103, mu = 0, data = sopakobiety)
    # Test t dla jednej próbki (średnia różnica od teoretycznej wartości)
  
  #Test t dla jednej próbki - Podobnie jak w przypadku testu dla dwóch próbek, p-wartość jest kluczowa do interpretacji:
    # Jeśli p-value < 0.01, odrzucamy hipotezę zerową, co sugeruje, że średnia różnica między grupami nie jest równa zero.
    # Jeśli p-value >= 0.01, nie mamy podstaw do odrzucenia hipotezy zerowej.  