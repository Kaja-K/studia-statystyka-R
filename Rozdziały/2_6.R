# tworzenie ramek danych

  sok <- c("kubus", "pysio", "leon", "bobo frut")
  cena <- c(1.2, 1.35, 1.65, 1.99)
  cukier <- c(11.5, 12, 10, 9.6)
  
  # ramki danych na dwa sposoby
  
    dfSok <- data.frame(sok, cena, cukier)
    dfSok
    
    dfSok2 <- data.frame(sok = c("kubus", "pysio", "leon", "bobo frut"),
                         cena = c(1.2, 1.35, 1.65, 1.99),
                         cukier = c(11.5, 12, 10, 9.6))
    dfSok2


# odwółania do elementów ramki danych
    
    #moja_ramka$nazwa_kolumny !!!!!
    
    dfSok$cena # równoważnie: dfSok[, 2]
    dfSok["cena"] # zwraca ramkę danych, bo pojedyncze 
    cena
    dfSok[["cena"]] # zwraca wektor, bo podwójny 
    dfSok[c("sok", "cukier")] # zwraca ramkę danych. Równoważnie: dfSok[, c(1,3)]
    
    
# operacje na ramkach danych
    dfSok$witC <- c(24, 20, 18, 32)
    dfSok$cukier <- NULL
    dfSok
    
    # Generujemy wektory do ramki danych
      ileObser <- 20
      set.seed(12345) # użyj, jeśli chcesz mieć identyczne wartości
      plec <- sample(c("k", "m"), ileObser, replace=TRUE, prob=c(0.7,0.3))
      wiek <- sample(c(20:60), ileObser, replace=TRUE)
      mieszka <- sample(c("miasto", "wies"), ileObser, replace=TRUE, prob=c(0.7,0.3))
      papierosy <- sample(0:10, ileObser, replace=TRUE, prob=c(0.9, rep(0.2, times=10)))
      wwwGodziny <- sample(0:15, ileObser, replace=TRUE)
      
      # Tworzymy ramkę danych:
      x <- data.frame(plec, wiek, mieszka, papierosy, wwwGodziny)
      x
      
      # Wybierz tylko mężczyzn
        y1 <- x[x[, 1] == "m", ] # sposób 1 lub: x[x[1] == "m", ]
        y2 <- x[x$plec== "m", ] # sposób 2
        x[x[, "plec"] == "m", ] # sposób 3 lub: x[x["plec"] == "m", ]
        
      # Wybierz tych, którzy wypalają więcej niż 5 papierosów dziennie
        y1 <- x[x[, 4] > 5, ] # sposób 1
        y2 <- x[x$papierosy > 5, ] # sposób 2
        x[x[, "papierosy"] > 5, ] # sposób 3
      
      # Wyłącz z analizy tych, którzy wypalają 0 lub 1 papierosa dziennie
        y1 <- x[x[ ,4] != 0 & x[ ,4] != 1, ] # sposób 1
        y2 <- x[x$papierosy != 0 & x$papierosy != 1, ] # sposób 2
        x[x[, "papierosy"] != 0 & x[, "papierosy"] != 1, ] # sposób 3
        
      # Wybierz niepalących którzy sp˛ędzają przed internetem przynajmniej 8 godzin
        y1 <- x[x[, 4] == 0 & x[, 5] >= 8, ] # sposób 1
        y2 <- x[x$papierosy == 0 & x$wwwGodziny >= 8, ] # sposób 2
        x[x[, "papierosy"] == 0 & x[, "wwwGodziny"] >= 8, ] # sposób 3

      # Wybierz niepalące kobiety ze wsi
        y1 <- x[x[, 1] == "k" & x[, 3] == "wies" & x[, 4] == 0, ] # sposób 1
        y2 <- x[x$plec == "k" & x$mieszka == "wies" & x$papierosy == 0, ] # sposób 2
        x[x[, "plec"] == "k" & x[, "mieszka"] == "wies" & x[, "papierosy"] == 0, ] # sposób 3
        
      # Wyłącz osoby miedzy 30 a 50 rokiem życia
        y1 <- x[x[, 2] > 50 | x[, 2] < 30, ] # sposób 1
        y2 <- x[x$wiek > 50 | x$wiek < 30, ] # sposób 2
        x[x[, "wiek"] > 50 | x[, "wiek"] < 30, ] # sposób 3
        
      # Wybierz zmienne: wiek, papierosy, wwwGodziny
        y1 <- x[, c(2, 4, 5)] # sposób 1
        y2 <- x[, c("wiek", "papierosy", "wwwGodziny")] # sposób 2
        
        head(y2, 2) # wyświetl tylko 2 wiersze
      
      # Wybierz wszystkie zmienne: od wiek do papierosy
        y1 <- x[, -c(1, 5)]
        y2 <- x[, c("wiek", "mieszka", "papierosy")]
        
        head(y2, 2) # wyświetl tylko 2 wiersze
        
      # Wybierz pierwsz zmienn, oraz zmienne od mieszka do wwwGodziny
        y1 <- x[, -2]
        y2 <- x[, !names(x) %in% "wiek"] # ! - zaprzeczamy, że należy
        
        head(y2, 2) #wyświetl tylko 2 wiersze
        
      # Wybierz zmienne plec i papierosy oraz te respondentki, które wypalaja mniej niż 5 papierosów. Przedstaw rozwiązanie w 2 krokach
        krok1 <- x[, c("plec", "papierosy")] # wybierz zmienne (wyświetl krok1)
        krok2 <- krok1[krok1$plec == "k" & krok1$papierosy < 5, ] # wybierz przypadki z krok1
        krok2
      
        # Powyższe zadanie w pojedynczym kroku
          jedenKrok <- x[x$plec == "k" & x$papierosy < 5, c("plec", "papierosy")]
          jedenKrok
         
      
# wybrane funckje dla ramek danych
  
    # Tworzymy ramkę danych
      dfZwierz <- data.frame(c(1, 4, 0), c("tak", "tak", "nie"), c("kot", "pies", "tygrys"))
      names(dfZwierz) # tak wyglądają nazwy
      
      names(dfZwierz) <- c("ile", "ma", "zwierzak") # zmieniamy nazwy
      dfZwierz
    
      names(dfZwierz)[c(1, 3)] <- c("ile_zwierz", "zwierz_4nogi") # zmieniamy ponownie: tylko 1 i 3 nazwę
      dfZwierz
      
      
      (macSok <- as.matrix(dfSok)) # Uzgadanie typów: wszystko typu znakowego
      colnames(macSok)
      macSok[, "cena"]
      rownames(macSok) # brak nazw wierszy
      rownames(macSok) <- LETTERS[1:4] # dafiniujemy nazwy
      macSok
      macSok["B", ]
  