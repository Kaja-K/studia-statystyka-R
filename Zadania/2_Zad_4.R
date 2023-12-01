medic <- data.frame(
  c(82.5, 65.1, 90.5, 80.9, 74, 74.4, 73.5, 75.6, 70.1, 61.8, 80.6, 82.2, 54.1, 60),
  c(181, 169, 178, 189, 178, 175, 173, 187, 175, 165, 185, 178, 162, 185))

#zmień domyślne nazwy kolumn na: masa i wysokosc
names(medic) <- c("masa","wysokosc") # dodanie nazw kolumn

#Utwórz dodatkową kolumnę (o nazwie BMI), której wartościami będzie
medic$BMI <- medic$masa / (medic$wysokosc / 100)^2

#zrobienie wektora BMI
waga <- c((medic$BMI > 18.5) + (medic$BMI > 24.99) + 1)

#zrobienie czynnika z danymi słownymi 
medic$waga <- factor(waga, levels = 1:3, labels = c("niedowaga", "prawidłowa", "nadwaga"), ordered = TRUE)

#Dodaj wiersz do ramki danych, który będzie odnosił się do jakiejś osoby
nowy_wiersz <- data.frame(masa = 70.0, wysokosc = 175, BMI = 70.0 / (1.75)^2, waga = "prawidlowa")
medic <- rbind(medic, nowy_wiersz)
medic

# wybierz kolumnę masa, a następnie dowolne 2 kolumny.
medic$masa
medic["BMI"]
medic[c("masa", "BMI")]
medic[c("masa", "BMI", "waga")]

# wiersze gdzie bmi jest większe od 23
medic[medic$BMI > 23, ] 

#Które osoby (nr wiersza) mają wagę prawidłową?
medic[medic$waga == "prawidłowa",]

#ile osób ma wagę prawidłową?
which(medic$waga == "prawidlowa")


