# Dodanie do zadania 5_1 wykresów

library(tidyverse)
library(ggplot2)
  customers <- read.table("Zadania/Dane/WholesaleCustomers.txt",header = TRUE,sep ="," )
  customers_tidy <-  pivot_longer(customers,cols = c(Fresh, Milk, Grocery, Frozen, Detergents_Paper, Delicassen), names_to = "Type", values_to = "Expenses")

#mediana rocznych wydatków dla wszytskich produktów
customers_tidy %>%  group_by(Channel, Region, Type) %>%  summarise(Expenses_median = median(Expenses))%>%
  
  ggplot(aes(x = Type, y = Expenses_median, fill = Channel)) + geom_col() +
  labs(title = "Mediana rocznych wydatków dla wszystkich produktów", y = "Mediana wydatków", x = "Typ produktu") + coord_flip()

#wartości statystyk opisowych, pozwalające powiedzieć cos o rozkładzie wydatków na mleczne i spożywcze
customers_tidy %>% filter(Type == "Milk" | Type == "Grocery") %>%
  group_by(Region, Type) %>% summarise(srednia = mean(Expenses), mediana = median(Expenses)) %>% ungroup() %>%
  
  ggplot(aes(x = Region, y = srednia, fill = Type)) + geom_col() 


#co dwudziesty percentyl wydatków na wszytskie produkty z uwzględnieniem kanały dystrybucji, posortuj aby porównać regoiony
customers_tidy %>% group_by(Channel, Type) %>%
  summarise(percentyl_20 = quantile(Expenses, probs=0.2),
            percentyl_40 = quantile(Expenses, probs=0.4),
            percentyl_60 = quantile(Expenses, probs=0.6),
            percentyl_80 = quantile(Expenses, probs=0.8)) %>% arrange(Channel) %>% ungroup() %>%
  
  ggplot(aes(x = Channel, group = Type)) +
  geom_line(aes(y = percentyl_20, color = "20-ty")) +
  geom_line(aes(y = percentyl_40, color = "40-ty")) +
  geom_line(aes(y = percentyl_60, color = "60-ty")) +
  geom_line(aes(y = percentyl_80, color = "80-ty")) +
  labs(title = "Percentyle wydatków z uwzględnieniem kanałów dystrybucji", y = "Wartość", x = "Kanał dystrybucji", color = "Percentyl")

#Zbuduj tabelę przedstawiającą kanały dystrybucji i region. 

  data1 <- customers_tidy %>% group_by(Channel, Region) %>% summarise(ile = n())
  data2 <- customers_tidy %>% group_by(Channel, Region) %>% summarise(ile = n()) %>% mutate(proc = ile/sum(ile)) 
  
  ggplot(data1, aes(x = Channel, y = ile, fill = Region)) + geom_col() +
    labs(title = "Liczba obserwacji dla kanałów dystrybucji i regionów", y = "Liczba obserwacji", x = "Kanał dystrybucji") + coord_flip()

  ggplot(data2, aes(x = Channel, y = proc, fill = Region)) + geom_col() +
    labs(title = "Liczba obserwacji dla kanałów dystrybucji i regionów", y = "Liczba obserwacji", x = "Kanał dystrybucji")


#sprawdzić zależnośc pomiędzy wydatkami na różne produkty - korelacje
  correlation_matrix <- cor(customers[c("Milk", "Fresh", "Grocery", "Frozen", "Detergents_Paper", "Delicassen")])
  correlation_df <- as.data.frame(as.table(correlation_matrix))

  ggplot(correlation_df, aes(x = Var1, y = Var2, fill = Freq)) +
    geom_col(position = "dodge") +
    labs(title = "Korelacja między Produktami", y = "Wartość korelacji", x = "Produkty")

