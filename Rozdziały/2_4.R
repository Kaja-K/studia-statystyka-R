# definiowanie macierzy

  (x <- 1:15)
  matrix(x, nrow = 3, ncol = 5)
  # w tym przypadku wystarczy podać samą liczbę wierszy lub kolumn
    matrix(x, nrow = 3) 
    matrix(x, ncol = 5) 

  matrix(1:15, ncol = 5)# można utworzyć macierz bez zmiennej 

  
# operacje na macierzach
  
  mac1 <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2)
  mac2 <- matrix(c(10, 25, 35, 40, 15, 60), nrow = 2) 
  mac1
  mac2
  mac1+mac2
  mac1-mac2
  mac2 / mac1 # nie jest to działanie znane z algebry macierzy
  mac1 * mac2 # to też nie jest mnożenie znane z algebry macierzy
  
  # działania na macierzach
    (X <- matrix(round(rnorm(16), 1), nrow=4))
    X %*% X # mnożenie
    t(X) # transpozycja: zamiana wierszy z kolumnami
    diag(X) # elementy na przekątnej
    solve(X) # macierz odwrotnaX 
    %*% solve(X) # powinniśmy otrzymać macierz jednostkową (ale numeryczna dokładność)

# odwołania do elementów macierzy
    set.seed(777) # ziarno generatora
    los <- sample(1:10, size = 70, replace=TRUE) # generujemy wektor
    x <- matrix(los, nrow = 7, ncol = 10) # tworzymy macierz
    x 
    
    # wybieranie wartości
      x[] # wektor indeksów
      x[2, 5] # wybierz wartości: z drugiego wiersza i piątej kolumny
      x[, 5] # wybierz wartości: ze wszystkich wierszy i piątej kolumny
      x[1, ] # wybierz wartości: z pierwszego wiersza i wszystkich kolumn
      x[, 5:7] # wybierz wartości: ze wszystkich wierszy i kolumn od 5 do 7
      x[, c(5, 7)] # wybierz wartości: ze wszystkich wierszy i kolumn 5 i 7
      x[, -5] # wybierz wszystkie wartości, pomijając kolumnę 5
      x[c(2, 6), -c(5, 7)] # wybierz wartości: z wiersza 2 i 6 oraz ze wszystkich kolumny oprócz 5 i 7

      
# wybrane funkcje dla macierzy
      
    (X <- matrix(1:20, nrow=4, ncol=5))
    (Y <- matrix(-c(1:12), nrow=4)) # Utwórz macierz
      
    dim(X) # wartość: pierwsza - liczba wierszy, druga - liczba kolumnn
    col(X) # liczba kolumnn
    row(X) # liczba wierszy
    cbind(X, c(-1, -3, -4, -6)) # połącz kolumnowo macierz X i wektor
    
    cbind(X, Y) # Połącz macierze X i Y kolumnowo
    
    # Chcemy zsumować kolumny w macierzy, Następnie wyniki sumy przypisać do sumaKolumn
      (x <- matrix(1:8, ncol=2)) # przykładowa macierz
      kol1 <- sum(x[, 1]) # wybieramy pierwszą kolumnę i sumujemy jej wartości
      kol2 <- sum(x[, 2]) # to samo robimy dla kolumny 2
      sumaKolumn <- c(kol1, kol2) # łączymy dwie sumy, a wynik przypisujemy do nazwy: sumaKolumn
      sumaKolumn
      
      # Dla wcześniejszego przykładu
        sumaKolumn <- apply(x, 2, sum) # operacje na kolumnach, bo 2; funkcja to suma
        sumaKolumn
      
      apply(x, 1, sum) # operacje na wierszach bo jest 1