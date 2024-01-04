# Wybrane wykresy
  library(ggplot2)
  library(tidyverse)
  
  
  #wykresy punktowe
  
    # ramka danych  
    dayCzas <- bank %>% group_by(day) %>% summarise(czas = mean(duration)) 
    head(dayCzas)
    
    p1 <- ggplot(dayCzas, aes(x = day, y = czas)) + geom_point(size = 3) + labs(x = "Dzien tygodnia", y = "Sredni czas rozmowy")
    
    p1 # wykres 1
    p1 + geom_line() # wykres 2
    p1 + geom_smooth() # wykres 3
    
    dayCzas2 <- bank %>% group_by(day, y) %>% summarise(czas = mean(duration))
    head(dayCzas2, 4)
    
    p2 <- ggplot(dayCzas2, aes(x = day, y = czas, colour = y)) + geom_point() + geom_line() + labs(x = "Poziom edukacji", y = "Średni czas rozmowy", colour = "Depozyt")
    
    p2 # wykres 1
    p2 + geom_smooth(method = "lm") # wykres 2
    
    eduCzas <- bank %>% group_by(education, y) %>% summarise(czas = mean(duration))
    eduCzas
    
    ggplot(eduCzas, aes(x = education,y = czas, colour = y, group = y)) + geom_line() + geom_point(size = 4)
  
    
  #wykresy słupkowe
    
    tabEdu <- bank %>% count(education) %>% mutate(odsetek = n/sum(n))
    tabEdu 
    p4 <- ggplot(tabEdu, aes(x = education, y = odsetek)) + geom_col()
    p4
    p5 <- ggplot(tabEdu, aes(x = education, y = odsetek)) + geom_col() + coord_flip()
    p5
  
    balJob <- bank %>% group_by(job) %>% summarise(MedianaSaldo = balance)
    head(balJob,3)
    p6 <- ggplot(balJob, aes(x = MedianaSaldo, y = reorder(job, MedianaSaldo)))
    p6 <- p5 + geom_point(size=3)
    p6 + labs(x = "Mediana salda", y = "Kategoria zatrudnienia") 
    p6

    eduMarit <- bank %>% group_by(education, marital) %>% summarise(Liczebnosc = n()) %>%  mutate(Procent = 100*Liczebnosc/sum(Liczebnosc))
    head(eduMarit, 3)
    p7 <- ggplot(eduMarit, aes(x = education, y = Procent, fill = marital))
    p7 + geom_col() 
    p8 <- p7 + geom_col(position = "dodge") 
    p8
  
    
  #Wykresy funkcji

    Wielom6 <- function(x) 0.2*x^6 - 0.6*x^5 - x^4 + 3*x^3 + 0.8*x^2 - 2.4*x
    wyk0 <- ggplot(data.frame(x = c(-2.1, 3.1)), aes(x = x))
    wyk <- wyk0 + stat_function(fun = Wielom6)
    wyk # odcinek [0,1] na osi X jest dłuższy od identycznego na osi Y
    wyk + coord_fixed(ratio = 1) #gwarancja, że długości będą identyczne
    
    dfX <- data.frame(osX = c(-4, 10)) #przedział zmienności x
    mdf <- ggplot(dfX, aes(x = osX)) + xlab("x") + ylab("f(x)")
    mdf + stat_function(fun = dt, colour = "#5DA5DA", args = list(df = 3)) +
      stat_function(fun = dnorm, colour = "#FAA43A") + # normalny N(0,1)
      stat_function(fun = dnorm, colour = "#60BD68", args = list(mean = 3, sd = 2)) +
      stat_function(fun = dnorm, colour = "#F17CB0", args = list(mean = 5, sd = 0.7))
  
    
  #histogram
    
    str(bank)
    bank$balance <- as.numeric(bank$balance)
    quantBalance <- quantile(bank$balance, probs = c(0.05, 0.95), na.rm = TRUE)
    bankCut <- bank %>% filter(balance > quantBalance[1], balance < quantBalance[2])
    p9 <- ggplot(bankCut, aes(x = balance)) + geom_histogram(bins = 20)
    p9
    
  
  #estymator gęstości jądrowej
    
    p10 <- ggplot(bankCut,aes(x=balance)) +geom_density()
    p10
    p11 <- ggplot(bankCut, aes(x = balance, fill = poutcome, colour = poutcome)) + geom_density(alpha = 0.3)
    p11

    #używając paneli    
    p12 <- ggplot(bankCut, aes(x = balance)) + facet_wrap(~ poutcome, nrow = 1) + geom_density()
    p12
  
    
  #dystrybuanta empiryczna
    
    p13 <- ggplot(bankCut, aes(x = balance)) + stat_ecdf()
    p13
    p14 <- ggplot(bankCut, aes(x = balance, colour = poutcome)) + stat_ecdf()
    p14
    
    
  #wykres pudełko-wąsy
    p15 <- ggplot(bankCut, aes(x = poutcome, y = balance)) + geom_boxplot()
    p15
    p16 <- ggplot(bankCut, aes(x = poutcome, y = balance, fill = education)) + geom_boxplot()
    p16
  
  
  #wykres kwantyl-kwantyl
    p17 <- ggplot(bankCut, aes(sample = balance)) + geom_qq() + geom_qq_line()
    p17
    p18 <- ggplot(bankCut, aes(sample = balance, colour = poutcome)) + geom_qq() + geom_qq_line()
    p18
    