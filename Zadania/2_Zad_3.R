#Podany kod
  r <- 0.05 #oprocentowanie roczne
  rr <- 1+r/12
  K <- 300000 #kwota kredytu
  L <- 20 #ile lat
  N <- 12*L #liczba rat (ile miesięcy)
  n <- 1:N #wektor zawierający kolejne okresy
  rataKredytu <- K*rr^N*(rr-1)/(rr^N-1)
  zadluzenie <- K*(rr^N-rr^n)/(rr^N-1)
  odsetki <- K*(rr^N-rr^(n-1))/(rr^N-1)*(rr-1)
  rataKapitalu <- rataKredytu - odsetki


# tworzenie ramki danych
dfkredyt <- data.frame(rataKapitalu,odsetki,rataKredytu,zadluzenie)

#sprawdzenie czy to na pewno jest ramka danych
class(dfkredyt) 

# 10 pierwszych wierszy
head(dfkredyt,10) 

#struktura i wymiar ramki
str(dfkredyt)
dim(dfkredyt)

# wyświetl wiersze
dfkredyt[100:125, ] # wiersze 100-125
head(dfkredyt,20) # pierwsze 20 wierszy
tail(dfkredyt,30) # ostatnie 30 wierszy
dfkredyt[c(20:30, 50:60), ] # wiersze 20-30 i 50-60
dfkredyt[seq(10, nrow(dfkredyt), 10), ] #co dziesiąty wiersz

# oblicz sumaryczną wielkość zapłaconych odsetek, rat kredytu i rat kapitałowych
sum(dfkredyt$odsetki) 
sum(dfkredyt$rataKredytu)
sum(dfkredyt$rataKapitalu)

#od którego okresu wysokość raty kapitałowej zaczyna przewyższać odsetki
indeks <- which(dfkredyt$rataKapitalu > dfkredyt$odsetki)
indeks #odczytuje wiersze
dfkredyt[74:240,]

