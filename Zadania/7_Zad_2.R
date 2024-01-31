# przedział ufności dla zmiennej mówiącej o nieregulowaniu należności

library(Hmisc)
  
bankFull <-read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";", dec = ",")
table(bankFull$default)
binconf(x = 815, n = 44396 + 815, alpha = 0.05, method = "all") # 3 metodami 

#środek przedziału ufności wynosi około 0.018. Oznacza to, że estymowana 
#proporcja regulowania należności w całym zbiorze danych wynosi około 1,8%

#na podstawie przedziału ufności na poziomie ufności 95% można stwierdzić, 
#że prawdziwa proporcja regulowania należności w populacji mieszczącej się 
#w tym przedziale wynosi od około 1.68% do 1.93%. Estymator punktowy wskazuje 
#wartość środkową tego przedziału.