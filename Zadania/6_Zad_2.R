library(ggplot2)
# Wczytanie danych
customers <- read.table("Zadania/Dane/WholesaleCustomers.txt", header = TRUE, sep = ",")

# Obliczenie korelacji
correlation_matrix <- cor(customers[c("Milk", "Fresh", "Grocery", "Frozen", "Detergents_Paper", "Delicassen")])

# Przekształcenie macierzy korelacji do postaci dataframe
correlation_df <- as.data.frame(as.table(correlation_matrix))

# Tworzenie wykresu korelacji w ggplot2
ggplot(correlation_df, aes(x = "Milk", y = Var2, fill = Freq)) +
  geom_col(position = "dodge") +
  labs(title = "Korelacja między Mlekiem a Pozostałymi Produktami", y = "Wartość korelacji pomiędzy danym produktem", x = NULL)


