library(tidyverse)

#dane
  WholesaleCustomers <- read.table("Zadania/Dane/WholesaleCustomers.txt",header = TRUE,sep ="," )

  
###############################################################################

  #przekształcanie na tidy
  WholesaleCustomers_tidy <-  pivot_longer(WholesaleCustomers,
                                           cols = c(Fresh, Milk, Grocery, Frozen, Detergents_Paper, Delicassen), 
                                           names_to = "Type", values_to = "Expenses")
  
  
###############################################################################
  
#mediana rocznych wydatków dla wszytskich produktów
  WholesaleCustomers %>%
    group_by(Channel, Region) %>%
    summarise(median_Fresh = median(Fresh),
              median_Milk = median(Milk),
              median_Grocery = median(Grocery),
              median_Frozen = median(Frozen),
              median_Detergents_Paper = median(Detergents_Paper),
              median_Delicassen = median(Delicassen))
  
  
###############################################################################

#wartości statystyk opisowych, pozwalające powiedzieć cos o rozkładzie wydatków na mleczne i spożywcze
  WholesaleCustomers_tidy %>%
    filter(Type == "Milk" | Type == "Grocery") %>%
    group_by(Region, Type) %>%
    summarise(srednia = mean(Expenses), mediana = median(Expenses))

  
###############################################################################
  
#co dwudziesty percentyl wydatków na wszytskie produkty z uwzględnieniem kanały 
  #dystrybucji, posortuj aby porównać regoiony
  
  WholesaleCustomers_tidy %>% group_by(Channel, Type) %>%
  summarise(percentyl_20 = quantile(Expenses, probs=0.2),
            percentyl_40 = quantile(Expenses, probs=0.4),
            percentyl_60 = quantile(Expenses, probs=0.6),
            percentyl_80 = quantile(Expenses, probs=0.8)) %>% arrange(Channel)
  
  
###############################################################################
  
#Zbuduj tabelę przedstawiającą kanały dystrybucji i region. 
  WholesaleCustomers_tidy %>% group_by(Channel, Region) %>% summarise(ile = n())
  WholesaleCustomers_tidy %>% group_by(Channel, Region) %>% summarise(ile = n()) %>% mutate(proc = ile/sum(ile))
 
  
############################################################################### 

  #sprawdzić zależnośc pomiędzy wydatkami na różne produkty - korelacje
  cor(customers[,c("Fresh","Milk","Grocery","Frozen","Detergents_Paper","Delicassen")])
