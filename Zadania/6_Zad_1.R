library(ggplot2)

x <- seq(-4, 4, length = 1000)
df_values <- c(3, 8, 20)  # Stopnie swobody

# Tworzenie wykresu
plot_data <- data.frame(x = rep(x, times = length(df_values)), 
                        df = rep(df_values, each = length(x)),
                        y_normal = dnorm(rep(x, each = length(df_values))),
                        y_t = dt(rep(x, each = length(df_values)), df = rep(df_values, each = length(x))))

ggplot(plot_data, aes(x = x, y = y_normal, color = "Normal")) +
  geom_line() + geom_line(aes(y = y_t, color = as.factor(df)), linetype = "dashed") +
  labs(title = "Porównanie gęstości rozkładu normalnego i t-studenta", x = "Wartości", y = "Gęstość")
