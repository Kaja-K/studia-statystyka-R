library(ggplot2)

WholesaleCustomers <- read.table(file = "Zadania/Dane/WholesaleCustomers.txt", sep = ",", dec = ".", header = TRUE)

WC_longer <- pivot_longer(WholesaleCustomers, 
                          cols = c(Fresh, Grocery, Frozen, Detergents_Paper, Delicassen),
                          names_to = "Type", values_to = "Expenses")

# Wykres punktowy korelacji w danych regionach
ggplot(WC_longer, aes(x = Milk, y = Expenses, color = Type)) +
  geom_point(alpha = 0.5) +
  facet_wrap(~ Region) +
  labs(title = "Wykres korelacji między wydatkami na mleko a innymi produktami",
       x = "Wydatki na mleko", y = "Inne wydatki", colour = "Region")