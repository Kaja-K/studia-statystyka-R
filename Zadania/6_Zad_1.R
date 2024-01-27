#Porównaj kształt funkcji gęstości rozkładu normalnego i rozkładu t-studenta,
#dla różnych stopni swobody, np. 3, 8, 20. W tym celu narysuj na jednym
# wykresie odpowiednie funkcje gęstości.

  library(ggplot2)
  
  ramka <- data.frame(osX = c(-5, 5))
  
  ggplot(ramka, aes(x = osX)) +
    labs(x = "x", y = "f(x)") +
    stat_function(fun = dt, colour ="#459000", args = list(df = 3)) +
    stat_function(fun = dt, colour = "#303090", args = list(df = 8)) +
    stat_function(fun = dt, colour = "#0021FF", args = list(df = 20)) +
    stat_function(fun = dnorm, colour = "#9000FF") 