#rekordowanie zmiennych

  recode(zmienna, "obecny_1" = "nowy_1", "obecny_2" = "nowy_2",.default = NULL)
  recode_factor(zmienna, "obecny_1" = "nowy_1", "obecny_2" = "nowy_2",.ordered = TRUE, .default = NULL)
  
  #przykład 1
    set.seed(777)
    owoc <- factor(sample(letters[1:3], 10, replace = TRUE))
    owoc
      
    # Rekodujemy, wykorzystując pakiet dplyr
    library(dplyr)
    recode(owoc, a = "arbuz", b = "banan", c = "czereśnia")
    
    # łączymy kategorie: a i b - owoc południowy, c - owoc krajowy
    recode(owoc, a = "owoc południowy", b = "owoc południowy", c = "owoc krajowy")
    
    # II sposób: przypisuję, aby nie wyświetlać wyniku
    temp <- recode(owoc, c = "owoc krajowy", .default = "owoc południowy")
    
  #przykład 2 - dodanie stopni naukowych
    (wykszt <- factor(sample(1:3, 10, replace = TRUE)))
    recode_factor(wykszt, `1` = "podstawowe", `2` = "średnie", `3` = "wyższe", .ordered = TRUE)
  
  #przykład 3 - dodanie kwartałów miesiąca
    set.seed(123)
    (miesiac <- sample(1:12, 30, replace=TRUE))
    (miesiacKat <- cut(miesiac, breaks = c(0,3,6,9,12))) # breaks - punkty podziału
    recode_factor(miesiacKat, "(0,3]" = "I_kw", "(3,6]" = "II_kw", "(6,9]" = "III_kw", "(9,12]" = "IV_kw", .ordered = TRUE)

      #lepsze rozwiązanie
        factor(miesiac, levels = 1:12, labels = rep(c("I_kw", "II_kw", "III_kw", "IV_kw"), each = 3), ordered = TRUE)