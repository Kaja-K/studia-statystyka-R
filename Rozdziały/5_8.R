#łączenie zbiorów za pomocą left/inner_join()

  #przykładowe dane
  album = c("_02", "_03", "_06", "_08", "_4", "_09", "_7")
  album2 = c("_02", "_03", "_05", "_08", "_4", "_09", "_7")
  imie = c("Marzena", "Paulina", "Ewelina", "Natalia", "Monika", "Marzena","Aleksandra")
  ocena = c(5, 2, 3, 4, 5, 4, 3)
  protokol <- data.frame(album=album2, imie)[-c(1,4),]
  oceny <- data.frame(album, ocena)
  
    protokol
    oceny
    
    left_join(protokol, oceny, by = "album")
    inner_join(protokol, oceny, by = "album")