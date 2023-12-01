# zapisywanie danych do pliku
  write.table(rd, file = "", quote = TRUE, sep = " ", na = "NA", dec = ".",
              row.names = TRUE, col.names = TRUE)
  
    set.seed(123) # ustawienie ziarna generatora liczb pseudolosowych
    opinia <- sample(c("Zdecydowanie nie", "Raczej nie", "Ani tak, ani nie", "Raczej tak",
                       "Zdecydowanie tak"), 100, replace=TRUE)
    wykszt <- sample(c("zawodowe lub niższe", "średnie", "wyższe"), 100, TRUE)
    wynagro <- round(rnorm(100, 3000, 1000), 2)
    dfbad <- data.frame(opinia, wykszt, wynagro)
    head(dfbad, 5)
    
    # 6 różnych sposobów
    write.table(dfbad, "Zadania/Dane/badanie1.txt")
    write.table(dfbad, "Zadania/Dane/badanie2.txt", sep = "\t", quote = FALSE, row.names = FALSE)
    write.table(dfbad, "Zadania/Dane/badanie3.txt", dec = ",", sep="\t", quote=FALSE, row.names = FALSE)
    write.csv2(dfbad, "Zadania/Dane/badanie4.csv", row.names = FALSE)
    write.csv2(dfbad, "Zadania/Dane/badanie5.csv", row.names = FALSE, quote = FALSE)
    write.csv(dfbad, "Zadania/Dane/badanie6.csv", row.names = FALSE)