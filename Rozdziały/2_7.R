# Tworzenie listy

  # Przykład - tworzenie listy
    mojaLista <- list("To moja pierwsza lista", c(20, 10, 15, 16),c("Ewa", "Nella", "Tammy"), matrix(1:10, nrow=2))
    mojaLista

    
# odwołania do elementów listy
    
  mojaLista[2] # weź drugi obiekt listy
  mojaLista[[2]] # weź drugi obiekt listy
  mojaLista[c(2,3)] # weź drugi i trzeci obiekt listy
  
  # weź drugi obiekt listy a następnie 3 element tego obiektu; równoważne z mojaLista[[2]][[3]]
  mojaLista[[c(2, 3)]]
  
  # dodawanie nazw do listy
    names(mojaLista) <- c("tytul", "cena", "imie", "mojamac")
    mojaLista
    
    mojaLista$imie # wybór jednego obiektu
    mojaLista[c("imie", "cena")] # wybór dwóch obiektów listy

    
# Operacje na listach
    
    mojaLista[["ostatni"]] <- c("dodany" , "elemen", "listy")
    mojaLista
    
    # Równoważnie do powyższego
      mojaLista["ostatni"] <- list(c("dodany" , "elemen", "listy"))
      mojaLista["ostatni"] <- NULL # A teraz usuwamy ten obiekt

      
# działania na listach 
      length(mojaLista[[2]])
      lapply(mojaLista, length)
      sapply(mojaLista, length) # oblicz dlugość (length) każdago elementu listy
      sapply(mojaLista, class) # jakiej klasy są elementy listy