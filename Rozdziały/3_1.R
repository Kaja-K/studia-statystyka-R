# Wyrażenia warunkowe if ... else
  
  if (2==3) # Jeżeli 2 jest równe 3 to
  a <- 10 # za a podstaw 10
  exists("a") 
  
  # Wariant a: x jest typu numerycznego
      x <- 1:10
      if (is.numeric(x)) {
        suma <- sum(x)
        ileElem <- length(x)
        srednia <- suma/ileElem
        }
    srednia 
  
  # Wariant b: x jest typu znakowego
      x <- c("a", "b", "abc")
      if (is.numeric(x)) {
        suma <- sum(x)
        ileElem <- length(x)
        srednia <- suma/ileElem
        } else {
          srednia <- "x musi być numeryczny"
          }
      srednia
      
      x <- c(1,5,4,3,2,7,8,9,2,4)
      x > 7
      ifelse(x > 7, "wieksza", "mniejsza")
      
      # Oblicz pierwiastek z x lub pierwiastek z wartości bezwzględnej z x
        x <- c(9, 4, -3)
        ifelse(x >= 0, sqrt(x), sqrt(abs(x)))
