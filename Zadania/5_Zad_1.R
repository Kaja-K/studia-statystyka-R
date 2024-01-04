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
