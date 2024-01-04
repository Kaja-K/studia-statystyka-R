# zbudować przedział ufności 

  data <- read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";")
  
  ci_balance <- t.test(as.numeric(as.character(data$balance)), na.rm = TRUE)$conf.int
  ci_balance


