# tworzenie wektórów

  #funkcja c()
    c(1, 5, 6, -2.34) # typ numeryczny
    c("zdecydowanie", "raczej nie", "trudno sie zdecydowac") # typ znakowy
    c(TRUE, FALSE, FALSE) # typ logiczny
    c(1, 7, "zarobki") # niedozwolone mieszanie typów: R uzgodni typ (będzie to znakowy)
  
  #operator :
    3:10 # utwórz wektor od 3 do 10
    c(3:10) # to samo co wyżej - użycie c() nie ma uzasadnienia
    7:2
    c(3:10, 4:2, -3) # tutaj jest sens, bo łączymy 3 wektory; tak, liczba jest wektorem
  
  #seq
    seq(from = 1, to = 5, by = 0.4) # liczby od 1 do 5 z przyrostem 0.4 
    seq(1, 5, 0.4) # to samo co wyżej; argumenty można pominąć, gdy wpisujemy w kolejności 
    seq(1, 10, length.out = 20) # R ustala przyrost, aby długość = 20
    
  #funkcja rep()
    rep(c(1, 5, 3), times = 5) # powtórz 5 razy wektor c(1, 3, 5)
    rep(c(1, 5, 3), each = 5) # powtórz 5 razy każdy element wektora c(1, 5, 3)
    rep(c(1, 5, 3), times = c(2, 3, 4)) # powtórz: 1-dwa razy, 5-trzy razy, 3-cztery razy
    rep(c("nie", "powtarzaj", "sie"), times = 4)
  
  vector(mode = "logical", length = 0)
  
  
# operacje na wektorach

  c(2,3)+c(3,4) #trzeba uważać na długośc wektorów, jeżeli będą nierówne R nie powiadomi o błędzie
  
  x <- c(5, 7, 3) # długość 3
  y <- c(1, 3, 7, 4, 9, 2) # długość 6
  x + y # zawijanie bez komunikatu, bo 6/3 jest całkowite
  y <- c(1, 3, 7, 4, 9, 2, 100) # długość 7
  x + y # zawijanie z ostrzeżeniem
  
  x + 1000 #każdy element x zwiększony o 1000
  
  x <- c(8, 2, 4, 12, 10, 6)
  y <- c(1, 5, 9, 0, 3, -5)
  z <- c(8, 9, 0)
  x - y # odejmowanie
  x * y # mnożenie
  z / x # reguła zawijania
  y^2 # podnieś elementy wektora y do 2 potęgi
  z^2 + y # podnieś elementy z do 2 potęgi i dodaj y


  # Rozważmy krótki przykład: dzienny utarg z wizyt w kolejnych dniach tygodnia. Pracuś?
    stawka <- c(100, 70, 90, 150, 120, 110, 130) # koszt wizyty u specjalisty
    ilePacjent <- c(3, 5, 4, 4, 1, 7, 3) # liczba przyjętych pacjentów
    utarg <- stawka * ilePacjent
    utarg
    
    utarg != 150 # który utarg jest różny od 150
    utarg == 150 # który utarg jest równy 150
    utarg >= 300 # który utarg przynajmniej 300
    utarg > 350 | utarg < 200 # który utarg większy od 350 lub mniejszy od 200
    utarg < 350 & utarg > 250 # który utarg między 250 a 350
    150 %in% stawka # czy 150 należy do zbioru wartości stawka
    c(70, 300) %in% stawka # która wartość wektora należy do stawka
  
  
# odwołania do elementów wektora

  utarg[3] # wybierz 3 elment, wektor indeksów
  utarg[3:5] # wybierz elementy od 3 do 5, bo 3:5 = c(3, 4, 5)
  utarg[c(1, 3, 4, 5)] # wybiera elementy o wskazanych indeksach, wektor logiczny
  utarg[-2] # wybierz wszystkie oprócz elementu na pozycji 2
  utarg[-c(1, 4)] # wybierz wszystkie bez elementu na pozycji: 1 i 4
  
  doktor <- c(1, 3, 4, 7)
  utarg[doktor] # wybierz elementy o indeksach zapisanych w wektorze: doktor
  utarg[c(TRUE, FALSE, TRUE, TRUE, TRUE, FALSE, FALSE)] # wybierz element tam gdzie TRUE
  
  utarg[utarg > 300] #większe od 300
  utarg[utarg > 350 | utarg < 200] #w danym przedziale z operatorem lub
  utarg[utarg < 350 & utarg > 250] #w podanym przedziale z operatorem i
  
  
  ## Aby nie nadpisywać naszego wektora utarg tworzymy kopię
    utarg2 <- utarg
    utarg2[utarg2 > 400] <- 1000 # krok 1
    utarg2[c(1, 3)] <- c(0, 1) # krok 2
    utarg2
    
  
  x <- rnorm(10) # generuje 10 liczb losowych z rozkładu normalnego N(0,1)
  x

  
# wybrane funckje dla wekltorów
  round(x, 1) # zaokrągl do 1 miejsca po przecinku
  exp(x) # oblicz wartości funkcji e w punktach x
  abs(x) # oblicz wartości bezwzględne
  log(abs(x)) # najpier oblicz wartość bezwzględną, później log. naturalny
  
  
  ## Przykład: z wektora wartości od 1 do 100 wylosuj 10 liczb
    set.seed(76) # ustaw ziarno generatora (gwarantuje identyczność losowania)
    los <- sample(1:100, 10, replace = FALSE)
    los
    max(los)
    sum(los)
    sort(los) # argument decreasing pominięty, dlatego użyty domyślny FALSE
    zestawienie <- c(range(los), sum(los), length(los))
    zestawienie
    sum(los)/length(los) # oblicz średnią arytmetyczną
    
    los
    which(los > 65) # które elementy są większe od 65, pokaż ich indeksy
    which.max(los) # pokaż indeks elementu największego (pierwszego napotkanego)
    los[which(los > 65)] #indeksy
  
  paste0("klient_", 1:3) #tworzenie listy
  
  x <- c("biały", "żółty", "niebieski")
  y <- "kolor"
  paste(y, x, sep = " CO ", collapse = " || ") #sklejanie tekstu

