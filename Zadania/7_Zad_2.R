# przedział ufności dla zmiennej mówiącej o nieregulowaniu należności

library(Hmisc)
  
bankFull <-read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";", dec = ",")
table(bankFull$default)
binconf(x = 815, n = 44396 + 815, alpha = 0.05, method = "asymptotic")
#ponieważ metoda jest duża zakładamy rozkłąd normalny