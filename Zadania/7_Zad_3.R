# hipotezy statystyczne

library(nortest)
library(Hmisc)
library(tidyverse)

############################################################################### 

#DANE
  data <- read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";",dec = ",")
  mieszkania <- read.table("Zadania/Dane/mieszkania.txt", header = TRUE, sep = ";", dec = ",")
  bankFull <- read.csv2("Zadania/Dane/bankFull.csv")
  WholesaleCustomers <- read.table("Zadania/Dane/WholesaleCustomers.txt", header = TRUE, sep = ",")
  zatrudnienie <- read.table("Zadania/Dane/zatrudnienie.dat", header = TRUE, sep = "\t")

  
############################################################################### 
  
#T.TEST
    
  #Średnia wieku klientów:
    #H0: Średni wiek klientów w banku wynosi 40 lat.
    #H1: Średni wiek klientów w banku jest różny od 40 lat
  
      t.test(data$age, mu=40)
      #Decyzja: Odrzucamy hipotezę zerową na korzyść hipotezy alternatywnej, ponieważ p-wartość < 0.05. 
      
      
  #Średnia ceny mieszkań
    # H0: Średnia cena mieszkania wynosi 0 (zero).
    # H1: Średnia cena mieszkania jest różna od 0.
      
      t.test(mieszkania$cena, mu = 0)
      #Decyzja: Odrzucamy hipotezę zerową na korzyść hipotezy alternatywnej, ponieważ p-wartość < 0.05. 
      
      
  #Równość średnich dla dwóch grup:
    #H0: Średni wiek dla klientów z domyślnie ustawionym i nieustawionym jest równy.
    #H1: Średni wiek dla klientów z domyślnie ustawionym i nieustawionym jest różny
      
      t.test(age ~ default, data = data)
      #Decyzja: Nie ma podstaw do odrzucenia hipotezy zerowej, ponieważ p-wartość > 0.05. 
  
      
  #Test dotyczące wieku pracowników dla jednej grupy
    #H0: Średnia wieku pracowników jest równa 45 lat. mi = 45
    #H1: Średnia wieku pracowników jest różna od 45 lat. mi =/= 45
      
      t.test(wiek, mu = 45, alternative = "two.sided")
      #Decyzja: Odrzucamy hipotezę zerową na korzyśc hipotezy alternatywnej ponieważ p-wartość < 0.05.
  
      
  #Test dotyczący wieku pracowników dla równości wariancji
    #H0: Średni wiek dla zatrudnionych kobiet jest taki sam jak średni wiek dla zatrudnionych mężczyzn. 
    #H1: Średni wiek dla zatrudnionych kobiet jest różny niż średni wiek dla zatrudnionych mężczyzn. 
      
      t.test(wiek ~ gender, data = zatrudnienie, var.equal = FALSE)
      #Decyzja: Nie ma podstaw do odrzucenia hipotezy zerowej ponieważ p-wartość > 0.05.


############################################################################### 
      
#VAR.TEST   
      
  #Równość wariancji dla dwóch grup:
    #H0: Wariancje wieku dla klientów z domyślnie ustawionym i nieustawionym są równe.
    #H1: Wariancje wieku dla klientów z domyślnie ustawionym i nieustawionym są różne.
      
      var.test(age ~ default, data = data)
      #Decyzja: Nie ma podstaw do odrzucenia hipotezy zerowej ponieważ p-wartość > 0.05
      
  #Test dotyczący wieku pracowników dla równości wariancji
    #H0: Średni wiek dla zatrudnionych kobiet jest taki sam jak średni wiek dla zatrudnionych mężczyzn. 
    #H1: Średni wiek dla zatrudnionych kobiet jest różny niż średni wiek dla zatrudnionych mężczyzn. 

      var.test(wiek ~ gender,data = zatrudnienie)
      #Decyzja: Odzrucamy hipotezę zerową na korzyść alternatywnej. ponieważ p-wartość < 0.05.
      
############################################################################### 
      
#BINCOF
      
  #Podział ufności dla proporcji
    # H0: Proporcja sukcesów w próbie wynosi 0.5 (50%).
    # H1: Proporcja sukcesów w próbie jest różna od 0.5.

      table(bankFull$poutcome) # sprawdzam proporcje, wybieram tylko sukces i porażke
      
      binconf(1511, 4901+1511, alpha = 0.05, method = "all")
      #Wniosek: #Decyzja: Odrzucamy hipotezę zerową na rzecz hipotezy alternatywnej, ponieważ 
      # przedział ufności dla proporcji zawiera wartości różne od 0.5
 

############################################################################### 
      
# PROP.TEST     
      
  #Procent klientów, którzy zdecydowali się na produkt:
    #H0: Procent klientów, którzy zdecydowali się na produkt, wynosi 50%.
    #H1: Procent klientów, którzy zdecydowali się na produkt, jest inny niż 50%.
      
      table(data$y)
      prop.test(39922, 5289+39922 ,p = 0.5) # obie opcje są poprawne
      prop.test(table(data$y) ,p = 0.5)
      #Decyzja: Odrzucamy hipotezę zerową na korzysć hipotezy alternatywnej ponieważ p-wartość < 0.05
  
  #Procent kobiet zatrudnionych
    #H0: Frakcja kobiet zatrudnionych jest taka sama jak frakcja zatrudnionych mężczyzn.
    #H1: Frakcja kobiet zatrudnionych jest różna od frakcji zatrudnionych mężczyzn.
      
      table(zatrudnienie$gender)
      prop.test(216, 216+258, p = 0.5)
      #Decyzja: Nie ma podstaw do odrzucenia hipotezy zerpwek ponieważ p-wartość > 0.05
      
      
############################################################################### 
      
#CHISQ.TEST
      
  #Zależność między wiekiem a decyzją o zakupie:
    #H0: Nie ma zależności między wiekiem a decyzją o zakupie.
    #H1: Istnieje zależność między wiekiem a decyzją o zakupie.

      (tab <- table(data$age, data$y))
      chisq.test(tab)
      #Decyzja: Odrzucamy decyzję zerową na korzyść hipotezy alternatywnej ponieważ p-wartość < 0.05
      
      
  #Zależność między posiadaniem pracy a poziomem edukacji
    #H0: Posiadana praca i poziom edukacji są niezależne.
    #H1: Posiadana praca i poziom edukacji są zależne.
      
      (tab <- table(bankFull$job, bankFull$education))
      chisq.test(tab)
      #Decyzja: Odrzucamy decyzję zerową na korzyść hipotezy alternatywnej ponieważ p-wartość < 0.05
      
      

############################################################################### 
      
# TESTY SHAPIRO/AD/CVM/LILLIE/PEARSON/SF
      
  #Normalność rozkładu zmiennej "balance":
    #H0: Zmienna "balance" ma rozkład normalny.
    #H1: Zmienna "balance" nie ma rozkładu normalnego.
        
        shapiro.test(przykladowe_dane$balance)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        ad.test(przykladowe_dane$balance)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        cvm.test(przykladowe_dane$balance)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        lillie.test(przykladowe_dane$balance)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        pearson.test(przykladowe_dane$balance)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        sf.test(przykladowe_dane$balance)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
          
    #Testy normalności wieku pracowników
      #H0: Zmienna wieku pracownika ma rozkład normalny.
      #H1: Zmienna wieku pracownika nie ma rozkładu normalnego.
        
        shapiro.test(zatrudnienie$wiek)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        ad.test(zatrudnienie$wiek)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        cvm.test(zatrudnienie$wiek)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        lillie.test(zatrudnienie$wiek)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        pearson.test(zatrudnienie$wiek)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
        sf.test(zatrudnienie$wiek)
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
        
    
############################################################################### 
        
# WILCOX.TEST
      
  #Różnica w medianie dla dwóch grup:
    #H0: Mediana wieku dla klientów z domyślnie ustawionym i nieustawionym jest równa.
    #H1: Mediana wieku dla klientów z domyślnie ustawionym i nieustawionym jest różna.
      
      wilcox.test(age ~ default, data = data)
      #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05
      
        
  #Test dotyczący średniek wieku pracowników
      #H0: Średnia wieku pracowników jest równa 45 lat. mi = 45
      #H1: Średnia wieku pracowników jest różna od 45 lat. mi =/= 45
      
        wilcox.test(zatrudnienie$wiek, mu = 45, alternative = "two.sided")
        #Decyzja: Odrzucamy hipotezę zerową na korzyść alternatywnej, ponieważ p-wartość < 0.05


############################################################################### 
        