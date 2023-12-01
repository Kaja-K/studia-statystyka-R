# tworzenie ramki danych
saty <- read.table("Zadania/Dane/satysfakcja.dat", header = TRUE, sep = "\t")

# podzbiory ramki danych
saty[saty$edukacja < "Policealna", ] 
saty[saty$plec == "Kobieta", ]
saty[saty$naukaLata > 15, ]

#zmienne odnoszące się do edukacji
saty$edukacja

#Wybierz osoby, które wierzą w życie po śmierci i są spod znaku lwa
saty[saty$wiaraZyciePo == "Tak" & saty$zodiak == "Lew", ]

#znak zodiaku zaczynający się od litery B
saty[saty$zodiak == "Baran" | saty$zodiak == "Byk" | saty$zodiak == "Bliznieta",]

#Weź wszystkie zmienne od wieku do płci włącznie, wybierz osoby, któreuczyły się więcej niż 19 lat
wiek_nauka_edu_plec <- saty[c("wiek", "naukaLata", "edukacja", "plec")]
wiek_nauka_edu_plec[wiek_nauka_edu_plec$naukaLata > 19,]

# dodanie poprawnej częstotliwości czytania gazet
saty$gazetyCzesto <- factor( "edukacja", ordered = TRUE)

#wybierz wszystkie zmienne typu numerycznego Dla nich policz sumę i znajdz min max.
numeryczne <- saty[sapply(saty, is.numeric)]
sapply(numeryczne, sum, na.rm = TRUE)
sapply(numeryczne, min, na.rm = TRUE)
sapply(numeryczne, max, na.rm = TRUE)

#funkcje table(), unique(), sum()
sum(zmienne_przyklad$wiek)
table(zmienne_przyklad$zodiak)
unique(zmienne_przyklad$edukacja)