library(tidyverse)
library(ggplot2)
library(stringr)

#Poniższe polecenia odnoszą sie do zbioru danych sopa.csv. Wczytując zbiór 
#użyj kodowania "UTF-8". Opis zmiennych znajduje się w pliku etykietySopa.csv,

  sopa <- read.csv("ścieżka/do/pliku/sopa.csv", encoding = "UTF-8", header = TRUE)
    # wczytanie danych do pliku z uwzględnieniem kodowanie UTF-8, nagłówków

#a) Zmienne od WAGA_GD_2000 do WAGA_GD_2009 przyjmują wartości tak, jeśli 
#   gospodarstwo domowe bylo badane w danym roku. Zbuduj ramkę (tabele), pokazującą 
#   liczbę badanych gospodarstw w każdym roku. Powstała ramka ma być tidy, a zmienna odnosząca 
#   się do roku badania ma przyjmować wartości numeryczne (np. 2000, a nie WAGA_GD_2060). 
#   Dlatego zmienną rok nalezy zrekodować (uzyj funkcji recodeO).
    
  ramka_badanych <- sopa %>%
    pivot_longer(cols = starts_with("WAGA_GD_20"), names_to = "rok", values_to = "liczba_badanych") %>%
    mutate(rok = as.numeric(str_replace(rok, "WAGA_GD_20", "")))
    # pivot_longer - przekształca ramkę danych z formatu szerokiego do długiego
    # str_replace("WAGA_GD_20", ""): Korzysta z funkcji str_replace z pakietu stringr 
    #                               do zastąpienia tekstu "WAGA_GD_20" pustym ciągiem znaków.
    # as.numeric(): Konwertuje otrzymane ciągi znaków na wartości numeryczne.

#   Zwizualizować informacje zawarte w ramce. Pamiętaj o podpisie osi (Rok badania, Liczba badanych) 
#   oraz tytule wykresu (Liczba badanych gospodarstw domowych w latach: 2000-2009).
    
  ggplot(ramka_badanych, aes(x = rok, y = liczba_badanych)) + geom_col() +
    labs(title = "Liczba badanych gospodarstw domowych w latach: 2000-2009", x = "Rok badania", y = "Liczba badanych")
    # kolumnowy wykres gdzie oś X to rok a oś Y to liczba badanych 

#b) Zapytano głowę rodziny, czy w gospodarstwie są pewne dobra (zmienne zaczynające się od ef9).
#   Litera na końcu nazwy zmiennej dotyczy: p-posiada, f-przyczyna finansowa, i-ile. 
#   Do dalszych analiz wybierz zmienne z końcow litera p, uruchamiając 
#   (zauwaz, że podmieniając w poniższym wyrażeniu p na inną literę (np. f), wybierzemy inna grupę zmiennych);

#   Pamiętaj o ucaytaniu pakietu: strings; ropa to nazus ranki wczytanego pliku
#   Uwzględniając fakt, że wartość zakodowana jako brak oznacza brak danych/odpowiedzi, 
#   zbuduj tabelę, w której pojawi się liczba oraz odsetek gospodarstw posiadających dobra.
  
  nazwy_ef9p <- str_extract(names(sopa), "ef9.*p") %>% na.omit()
    # wyciąga nam z ramki danych  zmienne zakończone literą p
  
  zmienne_ef9p <- sopa[, nazwy_ef9p]
    # wybiera te zmienne z ramki

  odsetki_ef9p <- apply(!is.na(zmienne_ef9p), 1, mean)
    # liczenie odsetek za pomocą funkcji aplly (1 - dla wierszy)
  
  wyniki_ef9p <- data.frame(dobra = names(odsetki_ef9p), odsetek = odsetki_ef9p)
    # ramka danych z wynikami, z nazwami dóbr i wartością odsetek za nie
