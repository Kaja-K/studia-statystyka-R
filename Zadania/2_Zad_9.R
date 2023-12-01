#nie sprzeda ani jednej sztuki
ppois(0, lambda = 5)

#sprzeda dokładnie 5 sztuk
ppois(5, lambda = 5)

#sprzeda przynajmniej jedną sztukę
1 - ppois(0, lambda = 5)

#sprzeda przynajmniej 2 sztuki ale mniej niż 5
ppois(5, lambda = 5) - ppois(2, lambda = 5)

#sprzeda 5 sztuk przy założeniu, że sprzedał już ponad 3 sztuki
ppois(3, lambda = 5)