set.seed(1313)
cena <- rnorm(100, mean=50, sd=10)

#zdefiniować nowy wektor euro 4.28pln/euro, zaokrąglić go do liczb całkowitych
zaokr <- round(cena, 2)
euro <- round(cena/4.28, 0)
euro

#znaleźć jego wartość max i min
max(euro)
min(euro)
range(euro)

sum(!is.na(euro)) # sumowanie bez <na>   !is.na()

#podać liczbe unikalnych elementów, posortować i wyświetlić w konsoli
length(unique(euro)) 
sorted <- sort(unique(euro)) 
sorted

#oblicz sumę elementów, średnią arytmetyczną, średnią geometryczną
sum(euro) 
mean(euro)
mean(euro,na.rm = TRUE) 

x = (1/length(euro)) 
prod(euro)^x

#podaj liczbę wartości większych od 13 Euro
length(euro[euro>13]) 

#liczba wartości pomiędzy 10-15
length(euro[euro<15&euro>10]) 

#utwórz ramkę danych składającą się z ceny w pln i euro, zmień nazwy 
names(dfcena) <- c("cenaPLN","cenaEUR")
dfcena




