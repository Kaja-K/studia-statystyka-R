#Testowanie hipotez
  
  #prop.test(x, n, p = NULL, alternative = c("two.sided", "less", "greater"), conf.level = 0.95, correct = TRUE)
    #x – liczba sukcesów (gdy jest jedna populacja) lub wektor liczby sukcesów 
    #n – liczba prób (rozmiar próby)
    #p – weryfikowane prawdopodobieństwo/frakcja sukcesów
    #correct – czy poprawka Yatesa na ciągłośc ma być uwzględniona

  
    saty <- read.table("Zadania/Dane/satysfakcja.dat", header=TRUE, sep="\t")
    table(saty$wiaraZyciePo)
    
    prop.test(974, 236+974, p=0.75)
    (tab <- table(saty$edukacja, saty$wiaraZyciePo))
    
    prop.table(tab, margin = 1)
    
    prop.test(tab) #weryfikacja drugiej hipotezy
    
  #testy niezależności
    (tab <- table(saty$edukacja, saty$szczescie))
    chisq.test(tab)
    
    chisq.test(tab, simulate.p.value = TRUE, B = 2000) # B -ile powtórzeń w Monte Carlo
    
  #testy zgodności z rozkładem normalnym
    library(nortest)
      shapiro.test(saty$ileGodzPracuje)
      
      ad.test(saty$ileGodzPracuje)
      
  #testy dla wartości średniej lub mediany
      #t.test(x, y = NULL, alternative = c("two.sided", "less", "greater"), mu = 0, paired = FALSE, var.equal = FALSE, conf.level = 0.95)
        #x,y – wartości numeryczne zmiennej lub zmiennych
        #alternative – test dwustronny (two.sided), jednostronny dla alternatywnej hipotezy
        #mu – założenie dotyczące wartości średniej
        #paired – czy obserwacje są zestawione w pary;
        #var.equal – czy załżono równość wariancji
      
      t.test(saty$ileGodzPracuje, mu=8, alternative = "two.sided")
      t.test(ileGodzPracuje ~ plec, data=saty) # data= nazwaZbioruDanych
      
      var.test(ileGodzPracuje ~ plec, data=saty)
      t.test(ileGodzPracuje ~ plec, data=saty, var.equal=TRUE)
      
      wilcox.test(saty$ileGodzPracuje, mu=8, alternative = "two.sided")
      wilcox.test(ileGodzPracuje ~ plec, data=saty)