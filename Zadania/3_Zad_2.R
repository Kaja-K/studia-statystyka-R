oceny <- data.frame(ocenaNum = sample(c(2:5, 3.5, 4.5), 100, replace = TRUE))

status_oceny <- ifelse(oceny >= 3, "pozytywna", "negatywna")
oceny$status_oceny <- status_oceny

# dodanie nazw słownych ocen
nazwa_oceny <-ifelse(oceny == 5, "bardzo dobry",
                     ifelse(oceny == 4.5, "+dobry",
                            ifelse(oceny == 4, "dobry",
                                   ifelse(oceny == 3.5, "+dostateczny",
                                          ifelse(oceny == 3, "dostateczny",
                                                 ifelse(oceny == 2.5, "+dopuszczający", "dopuszczający"))))))
oceny$nazwa_oceny <- nazwa_oceny
oceny
