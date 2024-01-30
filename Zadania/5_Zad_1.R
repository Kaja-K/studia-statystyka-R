library(tidyverse)
library(e1071)


#dane - dane są wypisane po przecinku, występuje nagłówek

  WholesaleCustomers <- read.table("Zadania/Dane/WholesaleCustomers.txt",header = TRUE,sep ="," )

  
###############################################################################

#przekształcanie na tidy - oryginalnie są wartości jako wydatki dla każdego produktu osobno
  # w tidy są wydatki jako jedna kolumna a typy produktów są w rzędach
  
  WholesaleCustomers_tidy <-  pivot_longer(WholesaleCustomers,
                                           cols = c(Fresh, Milk, Grocery, Frozen, Detergents_Paper, Delicassen), 
                                           names_to = "Type", values_to = "Expenses")
  head(WholesaleCustomers)
  head(WholesaleCustomers_tidy)
  
###############################################################################
  
#mediana rocznych wydatków dla wszytskich produktów ze względu na kanał i region
  # 2 opcje jedna z każdym produktem osobno druga dla wszytskich łącznie
  
  WholesaleCustomers %>%
    group_by(Channel, Region) %>% #ze względu na kanał i region
    summarise(median_Fresh = median(Fresh),
              median_Milk = median(Milk),
              median_Grocery = median(Grocery),
              median_Frozen = median(Frozen),
              median_Detergents_Paper = median(Detergents_Paper),
              median_Delicassen = median(Delicassen))
  
# z danymi tidy
  
    #mediana ze względu na kanał
    WholesaleCustomers_tidy %>% group_by(Channel) %>% summarise(mediana = median(Expenses))
    
    # mediana ze względu na kabnał i region 
    WholesaleCustomers_tidy %>% group_by(Channel,Region) %>% summarise(mediana = median(Expenses))
    
    # mediana ze względu na kanał i region dla produktów - z polecenia 
    WholesaleCustomers_tidy %>% group_by(Channel,Region, Type) %>% summarise(mediana = median(Expenses))
  
  
###############################################################################

#wartości statystyk opisowych, pozwalające powiedzieć cos o rozkładzie wydatków 
# na mleczne i spożywcze. wykonaj obliczenia dla regionu
  
  WholesaleCustomers %>% group_by(Region) %>%
      summarise(
        Srednia_Milk = mean(Milk),
        Srednia_Grocery = mean(Grocery),
        Mediana_Milk = median(Milk),
        Mediana_Grocery = median(Grocery),
        Wariancja_Milk = var(Milk),
        Wariancja_Grocery = var(Grocery),
        Odchylenie_Milk = sd(Milk),
        Odchylenie_Grocery = sd(Grocery),
        Rozstep_Milk = IQR(Milk),
        Rozstep_Grocery = IQR(Grocery),
        Skosnosc_Milk = skewness(Milk, type = 2),
        Skosnosc_Grocery = skewness(Grocery, type = 2),
        Kurtoza_Milk = kurtosis(Milk, type = 2),
        Kurtoza_Grocery = kurtosis(Grocery, type = 2))

# z danymi tidy - 2 metoda robienia  
        
    WholesaleCustomers_tidy %>% filter(Type == "Milk" | Type == "Grocery") %>% 
      group_by(Type, Region) %>% summarise(srednia = mean(Expenses), 
                                           mediana = median(Expenses),
                                           variancja = var(Expenses),
                                           odchylenie = sd(Expenses),
                                           rozstep = IQR(Expenses),
                                           skosnosc = skewness(Expenses, type = 2),
                                           kurtoza = kurtosis(Expenses, type = 2))
      
        # typy kurtozy - 1 - estymator trzeciego momentu,
                        # 2 - estymator trzeciego moemntu znormalizowanego
                        # 3 - estymator piątego moemntu znormalizowanego
    
    # wyniki obu przypadków mają te same wartości, różnią się ułożeniem danych w tabeli
    # tabela z tidy jest bardziej czytelna
    
###############################################################################
  
#Co dwudziesty percentyl wydatków na wszytskie produkty z uwzględnieniem kanały 
  #dystrybucji, posortuj aby porównać regoiony

  WholesaleCustomers_tidy %>% group_by(Channel, Type) %>%
  summarise(percentyl_20 = quantile(Expenses, probs=0.2),
            percentyl_40 = quantile(Expenses, probs=0.4),
            percentyl_60 = quantile(Expenses, probs=0.6),
            percentyl_80 = quantile(Expenses, probs=0.8)) %>% 
    arrange(Channel)
  
    
  # dla tidy bo bez Expenses by trzeba było sumować każdy typ osobno 
    # i dopiero potem dla sum osobno obliczyć percentyl 
    
###############################################################################
  
#Zbuduj tabelę przedstawiającą kanały dystrybucji i region. częstości występowania par w zbiorze
  WholesaleCustomers_tidy %>% group_by(Channel, Region) %>% 
    summarise(ile = n()) %>% mutate(proc = ile/sum(ile))
    
    # n() - podaje dla każdej grupy liczbę obserwacji
    # częstośc to ilość obserwacji w zbiorze dla każdego kanału i regionu 
    # podzielona przez ilość obserwacji ogólnie
  
############################################################################### 

#sprawdzić zależnośc pomiędzy wydatkami na różne produkty - korelacje
    
  cor(WholesaleCustomers[, c("Fresh", "Milk", "Grocery", "Frozen", "Detergents_Paper", "Delicassen")])

# ciężko było by zrobić na tidy - musiało by być pivot_wider aby wyszło
    
############################################################################### 
    