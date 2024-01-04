<<<<<<< HEAD
library(tidyverse)

#dane
customers <- read.table("Zadania/Dane/WholesaleCustomers.txt",header = TRUE,sep ="," )
head(customers,10)

#przekształcanie na tidy
customers_tidy <-  pivot_longer(customers,cols = c(Fresh, Milk, Grocery, Frozen, Detergents_Paper, Delicassen), names_to = "Type", values_to = "Expenses")
customers_tidy


#mediana rocznych wydatków dla wszytskich produktów
customers_tidy %>%  group_by(Channel, Region, Type) %>%  summarise(Expenses_median = median(Expenses))

#wartości statystyk opisowych, pozwalające powiedzieć cos o rozkładzie wydatków na mleczne i spożywcze
customers_tidy %>%
  filter(Type == "Milk" | Type == "Grocery") %>%
  group_by(Region, Type) %>%
  summarise(srednia = mean(Expenses), mediana = median(Expenses))


#co dwudziesty percentyl wydatków na wszytskie produkty z uwzględnieniem kanały dystrybucji, posortuj aby porównać regoiony
customers_tidy %>% group_by(Channel, Type) %>%
  summarise(percentyl_20 = quantile(Expenses, probs=0.2),
            percentyl_40 = quantile(Expenses, probs=0.4),
            percentyl_60 = quantile(Expenses, probs=0.6),
            percentyl_80 = quantile(Expenses, probs=0.8)) %>% arrange(Channel)

#Zbuduj tabelę przedstawiającą kanały dystrybucji i region. 
  customers_tidy %>% group_by(Channel, Region) %>% summarise(ile = n())
  customers_tidy %>% group_by(Channel, Region) %>% summarise(ile = n()) %>% mutate(proc = ile/sum(ile))
  
#sprawdzić zależnośc pomiędzy wydatkami na różne produkty - korelacje
  cor(customers[,c("Fresh","Milk","Grocery","Frozen","Detergents_Paper","Delicassen")])
=======
library(tidyverse)

#dane
customers <- read.table("Zadania/Dane/WholesaleCustomers.txt",header = TRUE,sep ="," )
head(customers,10)

#przekształcanie na tidy
pivot_longer(customers, cols = c(Channel,Region,Fresh,Milk,Grocery,Frozen), names_to = "chanel", values_to = "dane")

#mediana rocznych wydatków dla wszytskich produktów
customers %>% group_by(Channel) %>% summarise(mediana = median(Region))

#wartości statystyk opisowych, pozwalające powiedzieć cos o rozkładzie wydatków na mleczne i spożywcze
customers %>% group_by(Region) %>% 
  summarise(Milk_mean = mean(Milk), Milk_sd = sd(Milk), Grocery_mean = mean(Grocery), Grocery_sd = sd(Grocery))

#co dwudziesty percentyl wydatków na wszytskie produkty z uwzględnieniem kanały dystrybucji, posortuj aby porównać regoiony
percentyl <- customers %>% group_by(Region) %>% arrange(Channel) %>%
  summarise(percentyl = quantile(rowSums(select(.,c(Channel, Region)), na.rm = TRUE), 0.2)) #sumuje wydatki na wszystkie produkty, a quantile(..., 0.2) oblicza 20. percentyl tych sum.
  percentyl
  
#Zbuduj tabelę przedstawiającą kanały dystrybucji i region. 
  
  # tidyr do przekształcenia danych
  customers %>% pivot_wider(names_from = Channel, values_from = Region)
  
  # Użyj dplyr do grupowania danych
  customers %>% group_by(Channel, Region)
  
#sprawdzić zależnośc pomiędzy wydatkami na różne produkty - korelacje
  cor(customers[,c("Fresh","Milk","Grocery","Frozen","Detergents_Paper","Delicassen")])
>>>>>>> c3612330eee5d2aa64d4d89c0becfa171cc4b9f5
  