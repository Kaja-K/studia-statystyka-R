# Dodanie do zadania 5_1 wykresów

library(tidyverse)
library(ggplot2)
library(e1071)

  WholesaleCustomers <- read.table("Zadania/Dane/WholesaleCustomers.txt",header = TRUE,sep ="," )
  WholesaleCustomers_tidy <-  pivot_longer(WholesaleCustomers,cols = c(Fresh, Milk, Grocery, Frozen, Detergents_Paper, Delicassen), names_to = "Type", values_to = "Expenses")


################################################################################

#mediana rocznych wydatków dla wszytskich produktów
  med <- WholesaleCustomers_tidy %>%  group_by(Channel, Region, Type) %>% 
    summarise(Expenses_median = median(Expenses))
  
  #wykres 1
  ggplot(med, aes(x = as.character(Channel), y = Expenses_median, colour = Type, group = Type)) +
    geom_point() + geom_line() + facet_wrap(~ Region, nrow = 1) +
    labs(x = "Channel", y = "Expenses median")
  
  
###############################################################################

#wartości statystyk opisowych, pozwalające powiedzieć cos o rozkładzie wydatków
  zadanie1b <- WholesaleCustomers_tidy %>%
    filter(Type == "Milk" | Type == "Grocery") %>%
    group_by(Region, Type) %>%
    summarise(srednia = mean(Expenses), mediana = median(Expenses))
  
  #wykres 1
  ggplot(zadanie1b, aes(x = as.character(Region), y = mediana, colour = Type, fill = Type)) + 
    geom_col(position = "dodge") + labs(x = "Region")
  
  
###############################################################################
  
#co dwudziesty percentyl wydatków na wszytskie produkty z uwzględnieniem kanały 
# dystrybucji, posortuj aby porównać regoiony
  
  perc <- WholesaleCustomers_tidy %>% group_by(Channel, Type) %>%
  summarise(percentyl_20 = quantile(Expenses, probs=0.2),
            percentyl_40 = quantile(Expenses, probs=0.4),
            percentyl_60 = quantile(Expenses, probs=0.6),
            percentyl_80 = quantile(Expenses, probs=0.8)) %>% arrange(Channel) %>% ungroup() 
  
    piv <- pivot_longer(perc, cols = c(percentyl_20, percentyl_40, percentyl_60, percentyl_80),
                          names_to = "Percentyl", values_to = "Ile")
  #wykres 1
  ggplot(piv, aes(x = Percentyl, y = Ile, fill = Type, colour = Type)) + 
    geom_col(position = "dodge") + facet_wrap(~ Channel, nrow = 1)
  
  #wykres 2
  ggplot(piv, aes(x = Type, y = Ile, fill = Percentyl, colour = Percentyl)) + 
    geom_col(position = "dodge") + facet_wrap(~ Channel, nrow = 1)
  

###############################################################################
  
#Zbuduj tabelę przedstawiającą kanały dystrybucji i region. 
  data1 <- WholesaleCustomers_tidy %>% group_by(Channel, Region) %>% summarise(ile = n())
  data2 <- WholesaleCustomers_tidy %>% group_by(Channel, Region) %>% summarise(ile = n()) %>% mutate(proc = ile/sum(ile)) 
  
  #wykres 1
  ggplot(data1, aes(x = as.character(Channel), y = ile, fill = as.character(Region), colour = as.character(Region))) + 
    geom_col(position = "dodge") + labs(x = "Channel", colour = "Region", fill = "Region")
  
  #wykres 2
  ggplot(data2, aes(x = as.character(Region), y = ile, fill = as.character(Channel), colour = as.character(Channel))) + 
    geom_col(position = "dodge") + labs(x = "Region", colour = "Channel", fill = "Channel")

  
###############################################################################
  
#sprawdzić zależnośc pomiędzy wydatkami na różne produkty - korelacje
  correlation_matrix <- cor(WholesaleCustomers[c("Milk", "Fresh", "Grocery", "Frozen", "Detergents_Paper", "Delicassen")])
  correlation_df <- as.data.frame(as.table(correlation_matrix))

  #wykres 1
  ggplot(correlation_df, aes(x = Var1, y = Var2, fill = Freq)) +
    geom_col(position = "dodge") +
    labs(title = "Korelacja między Produktami", y = "Wartość korelacji", x = "Produkty")
  
###############################################################################