#restrukturyzacja danych z pakietem tidyr
  
  library("tidyr")
  
  pivot_longer(rd, cols, names_to = "nazwaKol", values_to = "nazwaKolWart")
  pivot_wider(rd, id_cols = NULL, names_from = nazwaKol, values_from = nazwaKolWart)
  
  ramkaPrawa <- pivot_longer(ramkaLewa,cols = c(sty, lut, mar),  names_to = "miesiac", values_to = "sztuki")
  
  separate(rd, nazwaKol, nazwyKolNowe, sep = ..., convert = FALSE, remove = TRUE)# rozdziela kolumne na kilka kolumn