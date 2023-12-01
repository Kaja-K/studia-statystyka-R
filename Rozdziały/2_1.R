# typy danych

  c(typeof(7L), typeof(7), mode(7), typeof(1.5), typeof("b. dobrze"))
  
  # Gdy chcemy zrobić int musimy dodać na koniec literę L
  
  TRUE+TRUE+FALSE # TRUE FALSE - zapisujemy dużymi literami!
  
  # Inf - wartość nieskończona
  # NaN - not a number (np. 0/0)
  # Na - not available, przy danych
  # NULL - pusty

  log(0) # oblicz logarytm naturalny z 0
  sqrt(-1) # pierwiastek kwadratowy z liczby ujemnej 
  c(3, 5, 9, NA) # ostatni element wektora traktowany jako brak danych
  c(5, 3, NULL, 8) # wektor ma 3 elementy (pusty z definicji zostaje pominięty)
  c("3", "7") # wektor typu znakowego

  
# zmiana typów danych i zapytanie o typ danych
  
  x = "7"
  is.logical(x) 
  as.logical(x)
  is.integer(x) 
  as.integer(x)
  is.double(x) 
  as.double(x)
  is.numeric(x) 
  as.numeric(x)
  is.character(x) 
  as.character(x)