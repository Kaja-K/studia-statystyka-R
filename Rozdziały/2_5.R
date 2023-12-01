# tworzenie czynników
    
  mieszka <- c("miasto", "miasto", "wieś", "miasto")
  mieszka
  typeof(mieszka) 
  
  str(mieszka) # struktura obiektu, Przekształcamy wektor na czynnik
  
  mieszka <- factor(mieszka)
  mieszka
  typeof(mieszka)
  str(mieszka)
  levels(mieszka) # jakie poziomy
  
  # konwersja czynnika na liczby
    wek <- factor(c(9, 10, 27, 30))
    wek
    as.numeric(wek) # liczby użyte w kodowaniu
    as.numeric(as.character(wek)) # przekształć na typ znakowy, później numeryczny
    
    # przykład: Losujemy 20 liczba ze zbioru: 1, 2, 3, 4
        set.seed(1234) # Ustawienie ziarna generatora liczb (można pominąć)
        (edu <- sample(1:4, 20, replace = TRUE))
    
    # Zmienną edu przekształcamy na czynnik
      eduord <- factor(edu, levels = 1:4,labels = c("podstawowe", "średnie", "licencjat", "magisterium"), ordered = TRUE)
      eduord


# operacje odwółania i wybrane funkcje dla czynnika
      
      (eduord2 <- eduord[eduord != "podstawowe"]) # usuń wartości: podstawowe
      table(eduord2) # tabela liczebności 
      
      (eduord2 <- droplevels(eduord2)) # usuń nieużywane poziomy
      table(eduord2) # tabela liczebności