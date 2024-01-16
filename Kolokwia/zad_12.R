library(tidyverse)
library(ggplot2)

# Wczytaj plik z danymi Auto.dat zapisując go w obiekcie o nazwie auto. 
# Jeśli nazwa pierwszej kolumny jest zniekształcona, to należy zmienić ją na: "Nroferty"
  
  auto <- read.table("Auto.dat", header = TRUE)
    # wczytanie danych, nagłówków
  
  if (colnames(auto)[1] != "Nroferty") {colnames(auto)[1] <- "Nroferty"}
    # jeżeli nazwa 1 kolumny nie jest oczekiwana to zmień na oczekiwaną


#a) Stwórz ramkę danych df niePolska, w której oferty nie będą uwzględniały 
#   Polski jako kraju pochodzenia samochodu.
  
  df_niePolska <- auto %>% filter(kraj != "Polska")
    # wyfiltrowanie z ramki aut nie z polski 


#b) Wybierz te oferty, w których wskazuje się dwa kraje pochodzenia: Norwegie i Rumunię.
#   Powstalą ramkę zapisz do pliku tekstowego o nazwie krajeNorwRum w katalogu mojedane.
    
  df_krajeNorwRum <- auto %>% filter(kraj %in% c("Norwegia", "Rumunia"))
    # oferty które pochodzą z norwegii i ruminii
  
  write.table(df_krajeNorwRum, file = "mojedane/krajeNorwRum.txt", sep = "\t")
    # zapis do pliku teskstowego, zaznaczenie separatora

  
#c) Stwórz ramkę danych o nazwie df_kraje3, w której oferty będą uwzględniały
#   tylko 3 najczęściej występujące kraje pochodzenia.
  
  df_kraje3 <- auto %>% group_by(kraj) %>% summarise(liczba_ofert = n()) %>%
    arrange(desc(liczba_ofert)) %>% head(3) %>% select(kraj)
    # grupujemy względem kraju (operacje będą dotyczyły każdego kraju osobno)
    # sumujemy do nowej zmiennej liczbę ofert dla danego kraju
    # sortujemy dane malejąco (aby łatwo nam było wyciągnąć top 3)
    # wyciągamy 3 pierwsze rekordy i wyświetlamy tylko nazwy szukanych krajów


#d) Dodaj do ramki danych auto zmienne, które będą ceną sprzedaży w EUR USD, z 
#   dokładnością do jednego miejsca po przecinku. Kursy wymiany: 4.19 PLN/EUR oraz 3.9 PLN/USD.
      
  auto$CenaEUR <- round(auto$CenaPLN / 4.19, 1)
  auto$CenaUSD <- round(auto$CenaPLN / 3.9, 1)
    # dodanie kolumn do ramki
  

#e) Utwórz ramkę danych df akcyza, która będzie składała się z 4 zmiennych: 
#   PojemnoscSkokowa, CenaPLN, Akcyza oraz CenaAkcyza, Ramka ta powinna zawierać 
#   tylko te oferty, dla których krajem pochodzenia nie jest Polska, a pojemność skokowa 
#   jest mniejsza od 2000. Pierwsze 2 zmienne występują w oryginalnym zbiorze danych auto.
#   Z kolei akcyze (Akcyza) wyliczysz uwzględniając stawkę opodatkowania 3.1%. 
#   Ostatnia ze zmiennych CenaAkcyza jest sumą ceny i akcyzy. Pierwsze 6 wierszy wyświetlam poniżej.
  
  df_akcyza <- auto %>% filter(kraj != "Polska" & PojemnoscSkokowa < 2000) %>%
    mutate(Akcyza = round(0.031 * CenaPLN, 2), CenaAkcyza = CenaPLN + Akcyza) %>%
    select(PojemnoscSkokowa, CenaPLN, Akcyza, CenaAkcyza)
    # filtrujemy dane dla nie polski oraz pojemności skokowej mniejszej niż 2000
    # Dodaje dwie nowe kolumny do ramki danych. Kolumny z akcyzą oraz z ceną akcyzy