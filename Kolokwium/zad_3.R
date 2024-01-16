library(tidyverse)
library(ggplot2)

# %>% - operator potoku - przekazuje dane do dalszej części kodu
# %in% - sprawdza czy elementy znajdują się w danym zbiorze/wektorze

# 1
  # wczytaj plik z danymi rowery_pol.csv. Utwórz ramkę o nazwie rower która będzie miała 
  # wartości dla zmiennej kwartal: I kw, IV kw, II kw. od tej pory pracuj z tą ramką.
  # W odpowiedzi podaj średnią wartośc wilgotności z dokładnością do 1 miejsca po przecinku
  
    rower <- read.csv2("dane/rowery_pol.csv", header = TRUE, sep = ";")
      # wczytuje dane z nagłówkiem i separatorem
      # zmienne - rower, dzień, pogoda, wilgotność, kwartal, liczba_wypozycz_rejestr ...
    
    rower <- rower %>% filter(kwartal %in% c("I kw", "IV kw", "II kw"))
      # filtruje dane i zachowuje tylko te wiersze z oczekiwanymi kwartałami
    
    round(mean(rower$wilgotnosc, na.rm = TRUE), 1)
      # oblicza średnią wartość z kolumny "wilgotnosc" oraz zaokrągla wynik

    
# 2
  # dla zmiennej liczba_wypozycz_rejestr policz średnią, wariancje, medianę i rozstęp 
  # międzykwartylowy w podziale na godziny wypożyczenia (godzina). Ramkę nazwij rowerStat
    
    rowerStat <- rower %>% group_by(godzina) %>%
      summarise(srednia = mean(liczba_wypozycz_rejestr),
                wariancja = var(liczba_wypozycz_rejestr),
                mediana = median(liczba_wypozycz_rejestr),
                iqr = IQR(liczba_wypozycz_rejestr))
      # Tworzy nową ramkę danych rowerStat, grupując dane ze względu na kolumnę "godzina". 
      # Wszystkie następne operacje dotyczące obliczeń statystycznych będą 
      # przeprowadzane dla każdej unikalnej godziny.
      
        # Tworzy podsumowanie dla każdej grupy godzinowej. Dla każdej grupy oblicza:
          # srednia = mean(liczba_wypozycz_rejestr): Średnią wartość kolumny "liczba_wypozycz_rejestr".
          # wariancja = var(liczba_wypozycz_rejestr): Wariancję kolumny "liczba_wypozycz_rejestr".
          # mediana = median(liczba_wypozycz_rejestr): Medianę kolumny "liczba_wypozycz_rejestr".
          # iqr = IQR(liczba_wypozycz_rejestr): Rozstęp międzykwartylowy kolumny "liczba_wypozycz_rejestr".

    
# 3
  # zbuduj tabelę krzyżową o nazwie rowerProc dla zmiennych pogoda i kwartal. 
  # oprócz liczebności niech pokazuje odsetki. policz te odsetki w taki sposób 
  # aby dla zadanej wartości zmiennej kwartal odsetki drugiej zmiennej sumowały się do 1
    
    rowerProc <- rower %>%
      select(kwartal, pogoda) %>%
      group_by(kwartal, pogoda) %>%
      summarise(ile = n()) %>%
      mutate(odsetek = ile/sum(ile))
      # select(kwartal, pogoda): wybiera kolumny kwartał i pogoda
      # group_by(kwartal, pogoda): grupuje dane według tych kolumn
      # summarise(ile = n()): oblicza obserwacje w każdej grupie
      # mutate(odsetek = ile/sum(ile)): dodaje kolumnę odsetek 
      
        # odsetki - obliczane jako iczba obserwacji dla danej kombinacji 
        # podzielona przez sumę obserwacji dla wszystkich kombinacji w danym dniu.
    
    pivot_wider(rowerProc, id_cols = pogoda, names_from = kwartal, values_from = c(ile, odsetek))
      # Przekształca dane, aby uzyskać szerszą tabelę, gdzie kolumny odpowiadają 
      # unikalnym wartościom "dzien", a wiersze odpowiadają unikalnym wartościom "pogoda". 
      # Kolumny "ile" i "odsetek" są przedstawione dla każdego połączenia "dzien" i "pogoda".
      
        # tabela rowerProc będzie miała kolumny "pogoda", "I kw_ile", 
        # "I kw_odsetek", "II kw_ile", "II kw_odsetek", ..., gdzie wartości "ile" 
        # to liczba obserwacji, a "odsetek" to odsetek dla danej kombinacji.

    
# 4 
  # Wykorzystaj ramkę rower i stwórz hierarchię najczęściej występujących godzin 
  # pod względem sumarycznej liczby wypożyczeń (liczba_wypozycz_rejestr)
  # dla godziny na miejscu 2 wyznacz maksymalną liczbę wypożyczeń 
    
    hierarchia_godzin <- rower %>%
      group_by(godzina) %>%
      summarise(liczba_wypozycz_rejestr = n()) %>%
      arrange(desc(liczba_wypozycz_rejestr)) %>%
      select(godzina)
      # Grupuje dane według godziny i oblicza liczba_wypozycz_rejestr dla każdej godziny
      # arrange(desc()): sortuje dane malejąco według liczby wypozyczen
      # zachwouje tylko kolumne godzina 
    
    rower %>% filter(godzina %in% hierarchia_godzin[2,]) 
      # Filtruje dane tak, aby obejmowały tylko te wiersze, gdzie godzina jest 
      # drugą najczęściej występującą godziną w hierarchii.
      
      # R indeksuje wartości od 1 (nie od 0)