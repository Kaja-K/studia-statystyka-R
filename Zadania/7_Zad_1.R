# zbudować przedział ufności dla średniej

data <- read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";", dec = ",")

  #H0: Średnia wartość zmiennej "balance" w populacji wynosi 0.
  #H1: Średnia wartość zmiennej "balance" w populacji jest różna od 0.
  
    t.test(data$balance, conf.level = 0.95)
    #Decyzja: Odrzucamy hipotezę zerową na rzecz hipotezy alternatywnej, ponieważ p-wartość < 0.05
  
# nie możemy wybrać testu binconf bo z tabeli nie da się odczytać proporcji z dwóch przedziałów