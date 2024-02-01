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
#   się do roku badania ma przyjmować wartości numeryczne (np. 2000, a nie WAGA_GD_2000). 
#   Dlatego zmienną rok nalezy zrekodować (uzyj funkcji recodeO).
    
  ramka <- pivot_longer(sopa, cols = WAGA_GD_2000:WAGA_GD_2009, names_to = "rok", values_to = "badane")
  
  ramka$rok <- recode(ramka$rok, "WAGA_GD_2000" = '2000', "WAGA_GD_2005" = '2005',
                      "WAGA_GD_2005" = '2005', "WAGA_GD_2007" = '2007',"WAGA_GD_2009" = '2009')
  
  ramka %>%
    group_by(rok, badane) %>%
    summarise(IleBadannych = n())

#   Zwizualizować informacje zawarte w ramce. Pamiętaj o podpisie osi (Rok badania, Liczba badanych) 
#   oraz tytule wykresu (Liczba badanych gospodarstw domowych w latach: 2000-2009).
    
  ggplot(ramka, aes(x = rok, y = liczba_badanych)) + geom_col() +
    labs(title = "Liczba badanych gospodarstw domowych w latach: 2000-2009", x = "Rok badania", y = "Liczba badanych")

#b) Zapytano głowę rodziny, czy w gospodarstwie są pewne dobra (zmienne zaczynające się od ef9).
#   Litera na końcu nazwy zmiennej dotyczy: p-posiada, f-przyczyna finansowa, i-ile. 
#   Do dalszych analiz wybierz zmienne z końcow litera p, uruchamiając 
#   (zauwaz, że podmieniając w poniższym wyrażeniu p na inną literę (np. f), wybierzemy inna grupę zmiennych);
  
#   zbuduj tabelę, w której pojawi się liczba oraz odsetek gospodarstw posiadających dobra.
  
  # Wybierz zmienne z końcową literą "p"
  zmienne_p <- sopa %>%
    select(matches("ef9p")) %>%
    pivot_longer(everything(), names_to = "zmienna", values_to = "posiada") %>%
    group_by(zmienna, posiada) %>%
    summarise(IleBadanych = n())
  
  # Zwizualizuj informacje zawarte w ramce
  ggplot(zmienne_p, aes(x = zmienna, y = IleBadanych, fill = posiada)) +
    geom_col(position = "dodge") +
    labs(title = "Liczba badanych gospodarstw domowych z pewnymi dobrami", x = "Zmienna", y = "Liczba badanych", fill = "Posiada")
