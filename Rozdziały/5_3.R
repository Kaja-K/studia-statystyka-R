#dodawanie zmiennych
  
  #dodanie ramki danych
  pracownik <- c("kierownik", "wykonawczy", "wykonawczy", "kierownik")
  rokUrodz <- c(1987, 1975, 1997, 1970)
  wynUSD <- c(57000, 40200, 21450, 21900)
  wynPoczUSD <- c(27000, 18750, 12000, 13200)
  badanie <- data.frame(pracownik, rokUrodz, wynUSD, wynPoczUSD)
  
  #dodanie kolumn
  badanieNew <- mutate(badanie, wiek = 2019 - rokUrodz, wynDiffUSD = wynUSD - wynPoczUSD, wynDiffPLN = 3.6 * wynDiffUSD)
  badanieNew