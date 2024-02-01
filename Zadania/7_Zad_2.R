# przedział ufności dla zmiennej mówiącej o nieregulowaniu należności

library(Hmisc)
  
bankFull <-read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";", dec = ",")

#H0: Proporcja klientów, którzy mają zaznaczoną opcję "default" (tak), wynosi 0.5 (50%).
#H1: Proporcja klientów, którzy mają zaznaczoną opcję "default" (tak), jest różna od 0.5.

  #musimy sprawdzić ile wartości wpisać w test
  table(bankFull$default)
  
  binconf(815,44396 + 815, alpha = 0.05, method = "all") # 3 metodami statystycznymi
  #Decyzja: Odrzucamy hipotezę zerową na rzecz hipotezy alternatywnej, ponieważ 
  # przedział ufności dla proporcji zawiera wartości różne od 0.5