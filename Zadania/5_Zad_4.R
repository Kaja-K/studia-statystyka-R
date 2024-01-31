library(tidyverse)
library(stringi)

###############################################################################

#dane - wczytanie danych za pomocą .Rdata(klikamy na plik i dane się wczytują)

  auto <- load("Zadania/Dane/cenyAut2012.Rdata") #nie umiem wczytać

###############################################################################
  
# Ustalanie maksymalnej liczby elementów wyposażenia
  
  # Przekształcenie kolumny Wyposazenie.dodatkowe na typ character
  auto$Wyposazenie.dodatkowe <- as.character(auto$Wyposazenie.dodatkowe)
  
  # Ustalanie maksymalnej liczby elementów wyposażenia
  max(str_count(auto$Wyposazenie.dodatkowe, ",")) + 1
  #str_count liczy liczbę przecinków, więc dodajemy 1, aby uzyskać liczbę elementów

###############################################################################

# Tworzenie nazw kolumn
  
 names(auto) <- paste0("wyposazenie_", 1:25)
 
###############################################################################

# Przekształcenie kolumny "wyposazenie_dodatkowe" na osobne kolumny
  auto <- auto %>%
    separate("wyposazenie.dodatkowe", into = column_names, sep = ".") %>%
    mutate_all(stri_trim)

###############################################################################

# Usunięcie ewentualnych spacji przed lub po elementach w nowych kolumnach
  auto <- auto %>% 
    mutate_all(stri_trim)

###############################################################################

# Sprawdzenie unikalnych elementów w nowych kolumnach
    
  auto %>% select(starts_with("wyposazenie")) %>% 
    unique()

###############################################################################

# Wczytanie pliku z kodami pocztowymi i połączenie go z oryginalnym zbiorem danych
  
  kody_pocztowe <- read.csv("Zadania/Dane/kodyPocztowe.csv", header = TRUE, sep = ";")
  
  auto <- auto %>% 
    mutate(kod = stri_trans_tolower(Adres)) %>% 
    left_join(kody_pocztowe, by = c("kod_pocztowy" = "kod"))

###############################################################################
  