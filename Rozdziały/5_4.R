#obliczanie statystyk opisowych

  bank <- read.csv("Rozdziały/Dane/bankFull.csv", sep = ";", header = TRUE)
  bank
  
  mean(x, trim = 0, na.rm = FALSE) # średnia (trim  - ucięta)
  median(x, na.rm = FALSE) #mediana
  var(x, na.rm = FALSE) #wariancja
  sd(x, na.rm = FALSE) #odchylenie standardowe
  quantile(x, probs=seq(0, 1, 0.25), na.rm= FALSE) # kwantyle rzędów 0,1,0.25
  IQR(x, na.rm = FALSE) #rozstęp międzykwantylowy czyli rózcnia kwantyli
  skewness(x, na.rm = FALSE, type = 3) # współczynnik asymetrii z pakietu e1071
  kurtosis(x, na.rm = FALSE, type = 3) #współczynnik kurtozy z pakietu
  cor(x, y) #współczynnik korelacji pearsona między x i y
  summary(x) #podaje najmniejszą, największą, średnią itd

    x <- c(1, 5, 3, NA, 4, NA, 7)
    mean(x, na.rm=TRUE)
    
    library("e1071") # kurtoza i asymetria
    skewness(bank$balance, type = 2)
    kurtosis(bank$balance, type = 2)
    quantile(bank$balance, probs = c(0.25, 0.3, 0.45, 0.95))
    
    #średnia mediana. asymetria i kurtoza dla salda rachunku
    bank %>% summarise(srednia = mean(balance), mediana = median(balance), wspAsymetrii = skewness(balance), wspSplaszcz = kurtosis(balance))
    summarise(srednia = mean(balance), mediana = median(balance), wspAsymetrii = skewness(balance), wspSplaszcz = kurtosis(balance))
    
    #styatystyki salda rachunku
    bank %>% group_by(education) %>% summarise(srednia = mean(balance), mediana = median(balance), wspAsymetrii = skewness(balance))
    group_by(education) %>% summarise(srednia = mean(balance), mediana = median(balance), wspAsymetrii = skewness(balance))
    
    # tabela edukacja
    bank %>% group_by(education) %>% summarise(ile = n())
    
    #tabela edukacjka i y
    bank %>% group_by(education, y) %>% summarise(ile = n())
    
    #sumowanie do 1 dla y
    bank %>% group_by(education, y) %>% summarise(ile = n()) %>% mutate(odset = ile/sum(ile))
    
    #sumowanie do 1 dla edukacji
    bank %>% group_by(y,education) %>% summarise(ile = n()) %>% mutate(odset = ile/sum(ile))
    
  count(rd, zm1) #zlicza wartości
  add_count(rd, zm1) #dodaje kolumne z count do ramki
  
    bank %>% count(education, y)
    
    bank %>% filter(poutcome=="failure" | poutcome == "success") %>% # wybierz: sukces lub porażka
      group_by(education, poutcome, y) %>%
      summarise(sredniaSaldo = mean(balance),
      medianaSaldo = median(balance),
      Liczebnosc = n()) %>%
      mutate(Procent = 100*Liczebnosc/sum(Liczebnosc)) %>%
      filter(y == "yes") %>% # weź tylko yes
      select(-y) %>% # skoro y=yes, to wyrzuć zmienną y
      arrange(desc(Procent)) %>% # posortuj malejąco
      filter(Procent > 50)
  