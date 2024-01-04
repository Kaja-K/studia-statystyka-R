# hipotezy statystyczne

library(nortest)
library(Hmisc)
  
# Dane pomniejszone i NA zostały usunięte
  data <- read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";")
    data <- head(data,300)
    data <- na.omit(data)

#Średnia wieku klientów:
  #Hipoteza zerowa (H0): Średni wiek klientów w banku wynosi 40 lat.
  #Hipoteza alternatywna (H1): Średni wiek klientów w banku jest różny od 40 lat

    t.test(data$age, mu=40)

    
#Równość średnich dla dwóch grup:
  #Hipoteza zerowa (H0): Średni wiek dla klientów z domyślnie ustawionym i nieustawionym jest równy.
  #Hipoteza alternatywna (H1): Średni wiek dla klientów z domyślnie ustawionym i nieustawionym jest różny
    
    t.test(age ~ default, data = data)

    
#Procent klientów, którzy zdecydowali się na produkt:
  #Hipoteza zerowa (H0): Procent klientów, którzy zdecydowali się na produkt, wynosi 50%.
  #Hipoteza alternatywna (H1): Procent klientów, którzy zdecydowali się na produkt, jest inny niż 50%.
    
    prop.test(table(data$y))


#Zależność między wiekiem a decyzją o zakupie:
  #Hipoteza zerowa (H0): Nie ma zależności między wiekiem a decyzją o zakupie.
  #Hipoteza alternatywna (H1): Istnieje zależność między wiekiem a decyzją o zakupie.

    chisq.test(table(data$age, data$y))
  
    
#Normalność rozkładu zmiennej "balance":
  #Hipoteza zerowa (H0): Zmienna "balance" ma rozkład normalny.
  #Hipoteza alternatywna (H1): Zmienna "balance" nie ma rozkładu normalnego.
  
    shapiro.test(przykladowe_dane$balance)
    
  
#Równość wariancji dla dwóch grup:
  #Hipoteza zerowa (H0): Wariancje wieku dla klientów z domyślnie ustawionym i nieustawionym są równe.
  #Hipoteza alternatywna (H1): Wariancje wieku dla klientów z domyślnie ustawionym i nieustawionym są różne.
    
    var.test(age ~ default, data = data)
    
    
#Różnica w medianie dla dwóch grup:
  #Hipoteza zerowa (H0): Mediana wieku dla klientów z domyślnie ustawionym i nieustawionym jest równa.
  #Hipoteza alternatywna (H1): Mediana wieku dla klientów z domyślnie ustawionym i nieustawionym jest różna.
    
    wilcox.test(age ~ default, data = data)
    

    