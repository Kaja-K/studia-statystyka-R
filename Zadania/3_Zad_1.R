car <- mtcars[, 1:7]

#oblicz średnią w kolumnie używając pętli
sredniafor <- 0
for (i in 1:ncol(car)) {sredniafor[i] <- mean(car[, i])}
srednia

#oblicz średnią w kolumnie używając apply
apply(car, 2, mean) 