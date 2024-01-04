<<<<<<< HEAD
library(tidyverse)
library(stringi)

#load("Zadania/Dane/cenyAut2012.Rdata") 
auto <- cenyAutIII2012
head(cenyAutIII2012,10)
colnames(cenyAutIII2012)

# Ustalanie maksymalnej liczby elementów wyposażenia
max_elements <- max(stri_count_fixed(auto$wyposazenie.dodatkowe, ","), na.rm = TRUE)
head(max_elements,5)

# Tworzenie nazw kolumn
new_column_names <- paste0("wyposazenie_", 1:25)
new_column_names

# Przekształcenie kolumny "wyposazenie_dodatkowe" na osobne kolumny
auto <- auto %>%
  separate("wyposazenie.dodatkowe", into = column_names, sep = ",") %>%
  mutate_all(stri_trim)
head(auto,5)

# Usunięcie ewentualnych spacji przed lub po elementach w nowych kolumnach
auto <- auto %>% mutate_all(stri_trim)
head(auto,5)

# Sprawdzenie unikalnych elementów w nowych kolumnach
unique_elements <- auto %>% select(starts_with("wyposazenie")) %>% unique()
head(unique_elements,5)

# Wczytanie pliku z kodami pocztowymi i połączenie go z oryginalnym zbiorem danych
kody_pocztowe <- read.csv("Zadania/Dane/kodyPocztowe.csv", header = TRUE, sep = ";")
head(kody_pocztowe,5)

auto <- auto %>% mutate(kod = stri_trans_tolower(kod)) %>% left_join(kody_pocztowe, by = c("kod_pocztowy" = "kod"))
head(auto,5)
=======
library(tidyverse)
library(stringi)

#load("Zadania/Dane/cenyAut2012.Rdata") 
auto <- cenyAutIII2012
head(cenyAutIII2012,10)
colnames(cenyAutIII2012)

# Ustalanie maksymalnej liczby elementów wyposażenia
max_elements <- max(stri_count_fixed(auto$wyposazenie.dodatkowe, ","), na.rm = TRUE)
head(max_elements,5)

# Tworzenie nazw kolumn
new_column_names <- paste0("wyposazenie_", 1:25)
new_column_names

# Przekształcenie kolumny "wyposazenie_dodatkowe" na osobne kolumny
auto <- auto %>%
  separate("wyposazenie.dodatkowe", into = column_names, sep = ",") %>%
  mutate_all(stri_trim)
head(auto,5)

# Usunięcie ewentualnych spacji przed lub po elementach w nowych kolumnach
auto <- auto %>% mutate_all(stri_trim)
head(auto,5)

# Sprawdzenie unikalnych elementów w nowych kolumnach
unique_elements <- auto %>% select(starts_with("wyposazenie")) %>% unique()
head(unique_elements,5)

# Wczytanie pliku z kodami pocztowymi i połączenie go z oryginalnym zbiorem danych
kody_pocztowe <- read.csv("Zadania/Dane/kodyPocztowe.csv", header = TRUE, sep = ";")
head(kody_pocztowe,5)

auto <- auto %>% mutate(kod = stri_trans_tolower(kod)) %>% left_join(kody_pocztowe, by = c("kod_pocztowy" = "kod"))
head(auto,5)
>>>>>>> c3612330eee5d2aa64d4d89c0becfa171cc4b9f5
