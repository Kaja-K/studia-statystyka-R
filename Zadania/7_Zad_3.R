# hipotezy statystyczne

library(nortest)
library(Hmisc)
library(tidyverse)

############################################################################### 

#DANE
  data <- read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";",dec = ",")
  data <- head(data,300) # pomniejszenie danych
  mieszkania <- read.table("Zadania/Dane/mieszkania.txt", header = TRUE, sep = ";", dec = ",")
  bankFull <- read.csv2("Zadania/Dane/bankFull.csv")
  WholesaleCustomers <- read.table("Zadania/Dane/WholesaleCustomers.txt", header = TRUE, sep = ",")
  zatrudnienie <- read.table("Zadania/Dane/zatrudnienie.dat", header = TRUE, sep = "\t")

  
############################################################################### 
  
#T.TEST
    
  #Średnia wieku klientów:
    #Hipoteza zerowa (H0): Średni wiek klientów w banku wynosi 40 lat.
    #Hipoteza alternatywna (H1): Średni wiek klientów w banku jest różny od 40 lat
  
      t.test(data$age, mu=40)
      #Wniosek: Wartość p-value jest bardzo mała (mniej niż poziom istotności 0.05), co oznacza,
      # że mamy podstawy do odrzucenia hipotezy zerowej. Otrzymana statystyka 
      # t wynosi 8.0734, co jest dużą wartością, co dodatkowo potwierdza istotność statystyczną.
      
      
  #Średnia ceny mieszkań
    # Hipoteza zerowa (H0): Średnia cena mieszkania wynosi 0 (zero).
    # Hipoteza alternatywna (H1): Średnia cena mieszkania jest różna od 0.
      
      t.test(mieszkania$cena, conf.level = 0.95)
      #Wniosek: Wartość p-value jest mniejsza niż 0.05, co oznacza, że mamy podstawy do 
      # odrzucenia hipotezy zerowej. Otrzymana statystyka t wynosi 596.55, co 
      # potwierdza istotność statystyczną. Wnioskujemy, że istnieje statystycznie 
      # istotna różnica między średnią ceną mieszkań a wartością referencyjną 0.
      
      
  #Równość średnich dla dwóch grup:
    #Hipoteza zerowa (H0): Średni wiek dla klientów z domyślnie ustawionym i nieustawionym jest równy.
    #Hipoteza alternatywna (H1): Średni wiek dla klientów z domyślnie ustawionym i nieustawionym jest różny
      
      t.test(age ~ default, data = data)
      #Wniosek: Wartość p-value wynosi 0.6513, co jest znacznie większe niż poziom istotności 0.05. 
      # Nie mamy więc podstaw do odrzucenia hipotezy zerowej. Statystyka t wynosi -0.60739, 
      # co sugeruje, że różnica między średnimi wiekami nie jest istotna statystycznie.
  
      
  #Test dotyczące wieku pracowników dla jednej grupy
    #H0: Średnia wieku pracowników jest równa 45 lat. mi = 45
    #H1: Średnia wieku pracowników jest różna od 45 lat. mi =/= 45
      
      t.test(zatrudnienie$wiek, mu = 45, alternative = "two.sided")
      #Wniosek: Istnieje statystycznie istotna różnica między średnim wiekiem 
      # pracowników a wartością referencyjną 45 lat. Średnia wieku pracowników
      # wynosi około 43.58 lat, a przedział ufności dla średniej (42.50, 44.66) 
      # potwierdza tę różnicę
  
      
  #Test dotyczący wieku pracowników dla równości wariancji
    #H0: Średni wiek dla zatrudnionych kobiet jest taki sam jak średni wiek dla zatrudnionych mężczyzn. 
    #H1: Średni wiek dla zatrudnionych kobiet jest różny niż średni wiek dla zatrudnionych mężczyzn. 
      
      t.test(wiek ~ gender, data = zatrudnienie, var.equal = FALSE)
      #Wniosek: Ponieważ p-wartość > alfa, nie ma podstaw do odrzucenia hipotezy zerowej.
      # Nie ma statystycznie istotnej różnicy w średnim wieku między zatrudnionymi 
      # kobietami a mężczyznami.


############################################################################### 
      
#VAR.TEST   
      
  #Równość wariancji dla dwóch grup:
    #Hipoteza zerowa (H0): Wariancje wieku dla klientów z domyślnie ustawionym i nieustawionym są równe.
    #Hipoteza alternatywna (H1): Wariancje wieku dla klientów z domyślnie ustawionym i nieustawionym są różne.
      
      var.test(age ~ default, data = data)
      #Wniosek: Wartość p-value wynosi 0.6983, co jest znacznie większe niż poziom istotności 0.05. 
      # Nie mamy podstaw do odrzucenia hipotezy zerowej. Test F nie dostarcza 
      # statystycznie istotnych dowodów na różnice w wariancjach wieku między 
      # klientami z domyślnie ustawionym a nieustawionym.
    
      
  #Test dotyczący wieku pracowników dla równości wariancji
    #H0: Średni wiek dla zatrudnionych kobiet jest taki sam jak średni wiek dla zatrudnionych mężczyzn. 
    #H1: Średni wiek dla zatrudnionych kobiet jest różny niż średni wiek dla zatrudnionych mężczyzn. 

      var.test(wiek ~ gender,data = zatrudnienie)
      #Wniosek: Ponieważ p-wartość < alfa, więc odrzucamy hipotezę zerową na 
      # rzecz hipotezy alternatywnej.Istnieje statystycznie istotna różnica 
      # w wariancjach wieku między zatrudnionymi kobietami a mężczyznami.
  
      
############################################################################### 
      
#BINCOF
      
  #Podział ufności dla proporcji
    # Hipoteza zerowa (H0): Proporcja sukcesów w próbie wynosi 0.5 (50%).
    # Hipoteza alternatywna (H1): Proporcja sukcesów w próbie jest różna od 0.5.
      
      binconf(298, 298+142, alpha = 0.05, method = "exact")
      #Wniosek: Przedział ufności dla proporcji sugeruje, że proporcja sukcesów w 
      # próbie (prawdopodobieństwo pewnego zdarzenia) mieści się między 
      # 0.631 a 0.721. Wartość p-value jest mniejsza niż 0.05, co oznacza, 
      # że mamy podstawy do odrzucenia hipotezy zerowej. Otrzymane wyniki 
      # sugerują, że proporcja sukcesów w próbie jest statystycznie różna od 0.5
 

############################################################################### 
      
# PROP.TEST     
      
  #Procent klientów, którzy zdecydowali się na produkt:
    #Hipoteza zerowa (H0): Procent klientów, którzy zdecydowali się na produkt, wynosi 50%.
    #Hipoteza alternatywna (H1): Procent klientów, którzy zdecydowali się na produkt, jest inny niż 50%.
      
      prop.test(table(data$y))
      #Wniosek: Wartość p-value jest bardzo mała (bardzo bliska zeru), co oznacza, że mamy 
      # podstawy do odrzucenia hipotezy zerowej. Statystyka chi-kwadrat wynosi 274.56, 
      # co dodatkowo potwierdza istotność statystyczną.
  
  #Procent kobiet zatrudnionych
    #H0: Frakcja kobiet zatrudnionych jest taka sama jak frakcja zatrudnionych mężczyzn.
    #H1: Frakcja kobiet zatrudnionych jest różna od frakcji zatrudnionych mężczyzn.
      
      prop.test(216, 216+258, p = 0.5)
      #Wniosek: Ponieważ wartość p-value wynosi 0.05967, co jest większe niż poziom 
      # stotności alfa (0.05), nie ma podstaw do odrzucenia hipotezy zerowej. 
      # Nie ma statystycznie istotnej różnicy w frakcji kobiet zatrudnionych 
      # w porównaniu do mężczyzn.
      
      
############################################################################### 
      
#CHISQ.TEST
      
  #Zależność między wiekiem a decyzją o zakupie:
    #Hipoteza zerowa (H0): Nie ma zależności między wiekiem a decyzją o zakupie.
    #Hipoteza alternatywna (H1): Istnieje zależność między wiekiem a decyzją o zakupie.
  
      chisq.test(table(data$age, data$y))
      #Wniosek: Wartość p-value wynosi 0.9589, co jest znacznie większe niż poziom istotności 0.05. 
      # Nie mamy więc podstaw do odrzucenia hipotezy zerowej. Statystyka chi-kwadrat 
      # wynosi 25.079, co sugeruje brak statystycznie istotnej zależności między 
      # wiekiem a decyzją o zakupie.
    
      
  #Zależność między posiadaniem pracy a poziomem edukacji
    #H0: Posiadana praca i poziom edukacji są niezależne.
    #H1: Posiadana praca i poziom edukacji są zależne.
      
      chisq.test(table(bankFull$job, bankFull$education))
      #Wniosek: Wartość p-value jest bardzo mała, co oznacza, że mamy podstawy 
      # do odrzucenia hipotezy zerowej. Istnieje statystycznie istotna zależność
      # między posiadaniem pracy a poziomem edukacji w badanej próbie
      

############################################################################### 
      
# TESTY SHAPIRO/AD/CVM/LILLIE/PEARSON/SF
      
  #Normalność rozkładu zmiennej "balance":
    #Hipoteza zerowa (H0): Zmienna "balance" ma rozkład normalny.
    #Hipoteza alternatywna (H1): Zmienna "balance" nie ma rozkładu normalnego.
        
        shapiro.test(przykladowe_dane$balance)
        #Wniosek: Odrzucamy hipotezę zerową, co sugeruje brak rozkładu normalnego dla zmiennej "balance"
        
        ad.test(przykladowe_dane$balance)
        #Wniosek: Odrzucamy hipotezę zerową, co sugeruje brak rozkładu normalnego dla zmiennej "balance"
        
        cvm.test(przykladowe_dane$balance)
        #Wniosek: Odrzucamy hipotezę zerową, co sugeruje brak rozkładu normalnego dla zmiennej "balance"
        
        lillie.test(przykladowe_dane$balance)
        #Wniosek: Odrzucamy hipotezę zerową, co sugeruje brak rozkładu normalnego dla zmiennej "balance"
        
        pearson.test(przykladowe_dane$balance)
        #Wniosek: Odrzucamy hipotezę zerową, co sugeruje brak rozkładu normalnego dla zmiennej "balance"
        
        
        sf.test(przykladowe_dane$balance)
        #Wniosek: Odrzucamy hipotezę zerową, co sugeruje brak rozkładu normalnego dla zmiennej "balance"
      
          
    #Testy normalności wieku pracowników
      #H0: Zmienna wieku pracownika ma rozkład normalny.
      #H1: Zmienna wieku pracownika nie ma rozkładu normalnego.
        
        shapiro.test(zatrudnienie$wiek)
        #Wniosek: Zmienna wieku pracowników nie ma rozkładu normalnego
        
        ad.test(zatrudnienie$wiek)
        #Wniosek: Zmienna wieku pracowników nie ma rozkładu normalnego
        
        cvm.test(zatrudnienie$wiek)
        #Wniosek: Zmienna wieku pracowników nie ma rozkładu normalnego
        
        lillie.test(zatrudnienie$wiek)
        #Wniosek: Zmienna wieku pracowników nie ma rozkładu normalnego
        
        pearson.test(zatrudnienie$wiek)
        #Wniosek: Zmienna wieku pracowników nie ma rozkładu normalnego
        
        sf.test(zatrudnienie$wiek)
        #Wniosek: Zmienna wieku pracowników nie ma rozkładu normalnego
      
    
############################################################################### 
        
# WILCOX.TEST
      
  #Różnica w medianie dla dwóch grup:
    #Hipoteza zerowa (H0): Mediana wieku dla klientów z domyślnie ustawionym i nieustawionym jest równa.
    #Hipoteza alternatywna (H1): Mediana wieku dla klientów z domyślnie ustawionym i nieustawionym jest różna.
      
      wilcox.test(age ~ default, data = data)
      #Wniosek: Wartość p-value wynosi 0.5585, co jest znacznie większe niż poziom 
      # istotności 0.05. Nie mamy podstaw do odrzucenia hipotezy zerowej. 
      # Test Wilcoxona nie dostarcza statystycznie istotnych dowodów na różnice w 
      # medianie wieku między klientami z domyślnie ustawionym a nieustawionym.
      
        
  #Test dotyczący średniek wieku pracowników
      #H0: Średnia wieku pracowników jest równa 45 lat. mi = 45
      #H1: Średnia wieku pracowników jest różna od 45 lat. mi =/= 45
      
        wilcox.test(zatrudnienie$wiek, mu = 45, alternative = "two.sided")
        #Istnieje statystycznie istotna różnica między średnim wiekiem pracowników 
        # a wartością referencyjną 45 lat

############################################################################### 
        