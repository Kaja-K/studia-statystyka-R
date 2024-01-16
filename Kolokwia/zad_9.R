library(tidyverse)
library(ggplot2)

# Wczytać plik z danymi seriale IMBD2. dat zapisując go w obiekcie o nazwie seriale. Następnie
  
    seriale <- read.table("dane/IMBD2.dat", header = TRUE, sep = ";")
      # Wczytuje dane, określa separator, nagłówek
  

#a) Stwórz ramkę danych pilot, którą będą tworzyć tylko te seriale, które mają tzw. 
#   odcinek pilotażowy (zmienna nazwa; zobacz pierwszy wiersz ramki seriale). 
#   Ramka powinna być posortowana malejąco względem liczby oddanych głosów (glosow). 
#   Ile jest takich seriali?
    
    pilot <- seriale %>% filter(nazwa == "Pilot") %>% arrange(desc(glosow))
      # wybranie seriali z odcinkiem polotażowym oraz posortowanie malejąco
    
    liczba_seriali_pilota <- nrow(pilot)
      # zliczenie wierszy ramki
    

#b) Wykorzystaj utworzoną ramkę pilot i zbuduj wykres punktowy pokazujący zależność
#   między oceną, a liczbą głosów. Dodatkowo nanieś krzywą wygładzoną - zinterpretują 
#   tę zależność. Ostatecznie oblicz i zinterpretuj współczynnik korelacji.
    
    ggplot(pilot, aes(x = ocena, y = glosow)) + geom_point() + geom_smooth(method = "lm", se = FALSE, color = "blue") +
      labs(title = "Zależność między oceną a liczbą głosów", x = "Ocena", y = "Liczba głosów")
        # wykres punktowy gdzie oś x przybiera wartość oceny a oś y - głosów. 
        # dodanie krzywej wygładzonej: method = "lm" - użycie regresji liniowej do wygładzania danych
        #                              se = FALSE  - wyłączenie przedziałów ufności wokół krzywej wygładzonej
    
    korelacja <- cor(pilot$ocena, pilot$glosow)
    interpretacja_korelacji <- ifelse(abs(korelacja) >= 0.7, "Silna", "Słaba")
      # obliczenie korelacji oceny z głosów oraz zainterpretowanie jej poprzez wskazanie czy jest silna czy słaba
    
      
#c) Wykorzystaj ramkę danych pilot, aby utworzyć wektor glos6 typu znakowego, z 
#   nazwami sześciu, najczęściej ocenianych seriali. Następnie użyj tego wektora,
#   aby na podstawie oryginalnej ramki danych seriale utworzyć ramkę danych o nazwie 
#   serGlos6, która będzie składała się tylko z tych sześciu seriali. Usuń z tej ramki 
#   wiersze odnoszące się do serialu Twin Peaks. Pamiętaj, aby usunąć nieużywane 
#   poziomy czynnika zmiennej serial.
    
    glos6 <- head(pilot$nazwa, 6)
      # wektor glos6 z nazwami sześciu najczęściej ocenianych seriali
    
    serGlos6 <- seriale %>% filter(nazwa %in% glos6)
      # ramka danych serGlos6 zawierającą tylko te sześć seriali (%in%- należy do)
    
    serGlos6 <- serGlos6 %>% filter(nazwa != "Twin Peaks")
      # usunięcie wierszy odnoszących się do twin peaks
    
    serGlos6$nazwa <- factor(serGlos6$nazwa)
      # usuwanie nieużywanych poziomów czynnika
      

#d) Zmodyfikuj ramkę danych serGlos6 tak, aby dane w niej zawarte ograniczały się
#   do pierwszych 3 sezonów. Następnie, w podziale na nazwę serialu i sezon, oblicz dla 
#   zmiennej ocena: średnią, medianę, pierwszy i trzeci kwartyl, współczynnik skośności
#   i kurtozę oraz dwie miary rozproszenia. Niech powstała ramka będzie podstawą wyzualizacji 
#   średniej oceny w podziale na serial i sezon-wykorzystaj punkty i linie. Wyniki zinterpretuj.
    
    serGlos6_3sezony <- serGlos6 %>% filter(sezon <= 3)
      # ograniczenie ramki do 3 pierwszych sezonów serialu
    
    statystyki <- serGlos6_3sezony %>% group_by(nazwa, sezon) %>%
      summarise(
        srednia = mean(ocena, na.rm = TRUE),
        mediana = median(ocena, na.rm = TRUE),
        kwartyl1 = quantile(ocena, 0.25, na.rm = TRUE),
        kwartyl3 = quantile(ocena, 0.75, na.rm = TRUE),
        skosnosc = skewness(ocena, na.rm = TRUE),
        kurtoza = kurtosis(ocena, na.rm = TRUE),
        rozstep = max(ocena, na.rm = TRUE) - min(ocena, na.rm = TRUE),
        odchylenie = sd(ocena, na.rm = TRUE))
        # na.rm = TRUE - usunięcie pustych wartości, po to aby wyszedł wynik
        # miary rozproszenia - rozstęp (różnica między największą i najmniejszą wartością)
        #                    - odchylenie standardowe (dokładna odległość wartości od średniej)
        #                    - współczynnik skośności (informacja o asymetrii rozkładu)
        #                    - współczynnik kurtozy (mierzy spiczastość rozkładu) 
      
    
    ggplot(statystyki, aes(x = sezon, y = srednia, color = nazwa, group = nazwa)) + geom_point() + geom_line() + 
      labs(title = "Średnia ocena w podziale na serial i sezon", x = "Sezon", y = "Średnia ocena")
        # Wykres średniej oceny w podziale na serial i sezon, sezon przyjmuje oś Y a serial oś X, osie i wykres są podpisane
        # dodanie group = nazwa - wskazuje, że dane powinny być grupowane według zmiennej "nazwa"
      
    
    