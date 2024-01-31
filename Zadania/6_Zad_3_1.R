# Dodanie do zadania 5_1 wykresów

library(tidyverse)
library(e1071)
library(ggplot2)

###############################################################################

#dane - dane są wypisane po przecinku, występuje nagłówek

WholesaleCustomers <- read.table("Zadania/Dane/WholesaleCustomers.txt",header = TRUE,sep ="," )

#WYKRES
  ggplot(WholesaleCustomers, aes(x = Channel, y = Region)) +
    geom_col() +
    labs(x = "Kanał", y = "Region", title = "Kanał dla regionu")

###############################################################################

#przekształcanie na tidy - oryginalnie są wartości jako wydatki dla każdego produktu osobno
# w tidy są wydatki jako jedna kolumna a typy produktów są w rzędach

WholesaleCustomers_tidy <-  pivot_longer(WholesaleCustomers,
                                         cols = c(Fresh, Milk, Grocery, Frozen, Detergents_Paper, Delicassen), 
                                         names_to = "Type", values_to = "Expenses")
head(WholesaleCustomers)
head(WholesaleCustomers_tidy)

#WYKRES
  ggplot(WholesaleCustomers_tidy, aes(x = Type, y = Expenses/1000, fill = Type)) +
    geom_col() +
    labs(x = "Typ produktu", y = "Wydatki wydatki w tysiącach", title = "Wydatki w tysiącach na typ produktu") 
    

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

#WYKRES
  wykres <- WholesaleCustomers_tidy %>% 
    group_by(Channel, Region, Type) %>% 
    summarise(Expenses_median = median(Expenses))
  
  ggplot(wykres, aes(x = as.character(Channel), y = Expenses_median, colour = Type, group = Type)) +
    geom_point() + geom_line() + facet_wrap(~ Region, nrow = 1) +
    labs(x = "Channel", y = "Expenses median")

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

#WYKRES
  wydatek <- WholesaleCustomers_tidy %>%
    filter(Type == "Milk" | Type == "Grocery") %>%
    group_by(Region, Type) %>%
    summarise(srednia = mean(Expenses),
              mediana = median(Expenses))
  
  #1
  ggplot(wydatek, aes(x = Type, y = srednia, colour = as.character(Region))) + 
    geom_point()
  #2
  ggplot(wydatek, aes(x = as.character(Region), y = mediana, colour = Type, fill = Type)) + 
    geom_col(position = "dodge") + labs(x = "Region")

###############################################################################

#Co dwudziesty percentyl wydatków na wszytskie produkty z uwzględnieniem kanały 
#dystrybucji, posortuj aby porównać regoiony

  percentyl <- WholesaleCustomers_tidy %>% group_by(Channel, Type) %>%
  summarise(percentyl_20 = quantile(Expenses, probs=0.2),
            percentyl_40 = quantile(Expenses, probs=0.4),
            percentyl_60 = quantile(Expenses, probs=0.6),
            percentyl_80 = quantile(Expenses, probs=0.8)) %>% 
  arrange(Channel)


# dla tidy bo bez Expenses by trzeba było sumować każdy typ osobno 
# i dopiero potem dla sum osobno obliczyć percentyl 

#WYKRES
  percentyl <- pivot_longer(percentyl, cols = c(percentyl_20, percentyl_40, percentyl_60, percentyl_80),
                        names_to = "Percentyl", values_to = "Ile")
  
  ggplot(percentyl, aes(x = Type, y = Ile, fill = Percentyl, colour = Percentyl)) + 
    geom_col(position = "dodge") + facet_wrap(~ Channel, nrow = 1)

###############################################################################

#Zbuduj tabelę przedstawiającą kanały dystrybucji i region. częstości występowania par w zbiorze
kanaly_dys<- WholesaleCustomers_tidy %>% group_by(Channel, Region) %>% 
  summarise(ile = n()) %>% mutate(proc = ile/sum(ile))

# n() - podaje dla każdej grupy liczbę obserwacji
# częstośc to ilość obserwacji w zbiorze dla każdego kanału i regionu 
# podzielona przez ilość obserwacji ogólnie

#WYKRES
  #1
  ggplot(kanaly_dys, aes(x = as.character(Channel), y = ile, fill = as.character(Region), colour = as.character(Region))) + 
    geom_col(position = "dodge") + labs(x = "Channel", colour = "Region", fill = "Region")
  #2
  ggplot(kanaly_dys, aes(x = as.character(Region), y = ile, fill = as.character(Channel), colour = as.character(Channel))) + 
    geom_col(position = "dodge") + labs(x = "Region", colour = "Channel", fill = "Channel")
  

############################################################################### 

#sprawdzić zależnośc pomiędzy wydatkami na różne produkty - korelacje

corel <- cor(WholesaleCustomers[, c("Fresh", "Milk", "Grocery", "Frozen", "Detergents_Paper", "Delicassen")])

# ciężko było by zrobić na tidy - musiało by być pivot_wider aby wyszło

#WYKRES
  Type <- data.frame(Type_1 = c("Milk", "Grocery", "Frozen", "Detergents_Paper", "Delicassen"))
  korelacja <- data.frame(cor(WholesaleCustomers[-c(WholesaleCustomers$Channel, WholesaleCustomers$Region)]))
  korelacja <- cbind(Type, korelacja)
  rownames(korelacja) <- NULL
  
  korelacja <- pivot_longer(korelacja, cols = c(Milk, Grocery, Frozen, Detergents_Paper, Delicassen),
                        names_to = "Type_2", values_to = "Correlation")

  ggplot(korelacja, aes(x = Type_1, y = Correlation, group = Type_2)) + 
    geom_point() + 
    geom_line() + 
    facet_wrap(~ Type_2, nrow = 5)
  
############################################################################### 
