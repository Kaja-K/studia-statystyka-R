
# 3 odrzucone wnioski
dbinom(3, size = 20, prob = 0.35)

#10 wniosków zostanie przyjętych
dbinom(10, size = 20, prob = 0.65)

#przynajmniej 10 wniosków zostanie przyjętych
sum(dbinom(10:20, size = 20, prob = 0.65))