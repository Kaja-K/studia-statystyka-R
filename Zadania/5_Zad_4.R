library(dplyr)
library(tidyr)
library(stringi)

load("Zadania/Dane/cenyAut2012.Rdata") # to mi nie działa i całe zadanie nie jest sprawdzone przez to :c

# Przekształcenie kolumny "wyposazenie_dodatkowe" na osobne kolumny
auto <- auto %>%
  separate("Wyposazenie dodatkowe", into = column_names, sep = ",", extra = "merge") %>%
  mutate_all(stri_trim)
head(auto,5)

# Ustalanie maksymalnej liczby elementów wyposażenia
max_elements <- max(stri_count_fixed(auto$wyposazenie_dodatkowe, ",") + 1, na.rm = TRUE)
head(max_elements,5)

# Tworzenie nazw kolumn
column_names <- paste0("wyposazenie_", 1:max_elements)
column_names

# Rozdzielanie kolumny
auto <- auto %>% separate(wyposazenie_dodatkowe, into = column_names, sep = ",", extra = "merge")
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
