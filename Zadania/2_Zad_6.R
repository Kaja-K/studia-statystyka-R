reg <- lm(y ~ x, data = data.frame(y=rnorm(100), x=rnorm(100) ))


#Z ilu elementów składa się lista.
length(reg)

#Jak nazywają się elementy listy.
names(reg)

#Oblicz długość wszystkich elementów listy 
lapply(reg, length)

#jakiego są typu
lapply(reg, typeof)

#Wydobądź element listy o nazwie coefficients
reg["coefficients"]
