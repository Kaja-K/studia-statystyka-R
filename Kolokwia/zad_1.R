library(tidyverse)
library(ggplot2)

  # napisz funkcje która dla wektora numerycznego x zwróci te jego wartości,
  # które będą większe od pierwszego kwartyla, ale też mniejsze od 3 kwartyla 
  # Nazwij ją Między_Q1Q3.
  
  Miedzy_Q1Q3 <- function(x){
    wek <- x[x > quantile(x, probs = 0.25) & x < quantile(x, probs = 0.75)] 
    return(wek)}
  
    Miedzy_Q1Q3(1:10)
  
  
    # tworzymy funkcję która przyjmuje x i zwraca nowy wektor, który zawiera tylko 
    # wartości odpowiadające warunkowi logicznemu - 1 kwartyl - 0.25 3 kwartyl  - 0,75
    
    # x[warunek] - wybiera tylko te wartości z wektora x, które spełniają warunek