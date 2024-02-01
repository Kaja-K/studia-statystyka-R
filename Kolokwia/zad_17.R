library(tidyverse)
library(ggplot2)

# Wczytaj dane z fakturyTel.dat, zmień nazwe 1 kolumny na id_klienta
  
fakt <- read.table("dane/fakturyTel.dat")

# Stwórz ramkę w której będą użytkownicy telefonu samsung, generujący przychód 
# w 3 kwartale, nieprzekraczający mediany tego przychodu. Wykorzystaj zbiór i 
# utwórz dfWoj, który będzie pokazywał procent liczby klientów z danego wojewódctwa (woj_klient)
# procenty zaokrąglij do 1 miejsca po przecinku 
  
  dfSamsung <- fakt %>%
    filter(marka_telefonu == "Samsung", kwartal == 3)%>%
    summarise(mediana_przychodu = median(przychod))%>%
    filter(przychod <= mediana_przychodu)

  dfWoj <- fakt %>%
    group_by(woj_klient) %>%
    summarise(ile = n(),
              procent_klientow = ile/sum(ile)) %>%
    mutate(procent_klientow = round(procent_klientow, 1))

# Dodaj ramki danych fakt zmienną SUMA_spr która będzie sumą przychodu ze 
# wszystkich miesięcy. nie dodawaj 12 kolumn do siebie - inne podejście. następnie 
# sprawdź czy wartości odpowiadają wartością zmiennej SUMA. 
# Jeśli odpowiadają to ile jest wartości różnych?
  
  # Dodaj zmienną SUMA_spr jako sumę przychodu ze wszystkich miesięcy
  fakt <- fakt %>%
    mutate(SUMA_spr = rowSums(across(starts_with("przychod"))))
  
  # Sprawdź, czy wartości odpowiadają wartościom zmiennej SUMA
  ile_roznych <- sum(fakt$SUMA_spr != fakt$SUMA)

# Czy różnice w przychodzie (SUMA) generowanym przez klientów zamieszkujących 
# wojewódctwa (woj_klient) podkarpackie i lubuskie ? przeprowadź krótką analizę 
# z uwzględnieniem estymatora gęstości jądorwej oraz wykresu pudełko-wąsy. 
  
  # Wybierz dane dla województw podkarpackiego i lubuskiego
  woj_podkarpackie <- fakt[fakt$woj_klient == "podkarpackie", ]
  woj_lubuskie <- fakt[fakt$woj_klient == "lubuskie", ]
  
  # Przeprowadź test statystyczny, np. t-test
  #H0: Nie ma istotnych różnic w przychodzie między klientami zamieszkującymi województwo podkarpackie i lubuskie.
  #H1: Istnieją istotne różnice w przychodzie między klientami zamieszkującymi województwo podkarpackie i lubuskie.
  t.test(woj_podkarpackie$SUMA, woj_lubuskie$SUMA)
  # Decyzja: odrzyucamy hipotezę zerową na korzyść hipotezy alternatywnej, ponieważ p-wartość < 0.05
  
  # Wygeneruj wykres pudełkowy
  boxplot(SUMA ~ woj_klient, data = fakt, main = "Przychód województwo: Podkarpackie vs. Lubuskie")
  
  
# Skup się na dowolnych 4 telefonach aby rozstrzygnąć w jakich kategoriach wiekowych są one
# najbardziej popularne, popularność to wielość przychodu. zrób wykres
  
  # Stwórz nową kolumnę kategoryzującą telefony
  fakt <- fakt %>% 
    group_by(kategoria_telefonu) %>% 
    top_n(4)
  
  fakt <- fakt %>% 
    group_by(kategoria_telefonu,SUMA,wiek) %>% 
    mutate(popularne = sum(SUMA)) %>% 
    arrange(kategoria_telefonu, popularne)
  
  # Wygeneruj wykres
  ggplot(fakt, aes(x = kategoria_telefonu)) +
    geom_bar(stat = "count") +
    labs(title = "Popularność telefonów w kategoriach wiekowych", x = "Kategoria wiekowa", y = "Liczba klientów")
  
# Czy niektórzy opiekunowie (id_opiekuna) są bardziej skuteczni w zachęcaniu
# klientów do pakietu SMS (sms_pakiet)? posłuż się miaramy statystycznymi wykresem oraz testem statystycznym
  
  # Stwórz nową kolumnę kategoryzującą opiekunów
  fakt <- fakt %>% group_by(kategoria_opiekuna,sms_pakiet) %>% 
    summarise(ile_sms=n()) %>% 
    mutate(liczba_pakietow = ile_sms/sum(ile_sms)) %>% 
    arrange(liczba_pakietow)
  
  # Przeprowadź test statystyczny, np. t-test
  #H0: Nie ma istotnej różnicy w skuteczności opiekunów w zachęcaniu klientów do pakietu SMS.
  #H1: Istnieje istotna różnica w skuteczności opiekunów w zachęcaniu klientów do pakietu SMS
  t.test(fakt$sms_pakiet ~ fakt$kategoria_opiekuna)
  
  # Wygeneruj wykres
  ggplot(fakt, aes(x = kategoria_opiekuna)) +
    geom_bar(stat = "count") +
    labs(title = "Liczba klientów w kategoriach opiekunów", x = "Kategoria opiekuna", y = "Liczba klientów") +
    annotate("text", x = 1.5, y = max(table(fakt$kategoria_opiekuna)) - 5,
             label = paste("p-value =", format.pval(t_test_result$p.value, digits = 3)))  
  