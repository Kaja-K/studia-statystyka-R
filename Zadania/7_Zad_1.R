# zbudować przedział ufności dla średniej

data <- read.csv("Zadania/Dane/bankFull.csv", header=TRUE, sep=";", dec = ",")

table(data$balance)
t.test(data$balance, conf.level = 0.95)

# przedział ufności od 1334.205 do 1390.339 dla średniej pokrywa 95% obserwacji