# przedział ufności dla zmiennej mówiącej o nieregulowaniu należności

  data <- read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";")
  
  ci_default <- prop.test(table(data$default))$conf.int
  ci_default
