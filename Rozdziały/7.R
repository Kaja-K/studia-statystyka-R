#t.test - weryfikacja wartości średniej, grater albo less, dla jednej albo dwoch populacji
#bincof -  struktura,proporcja, frakcja na podstawie próby nie populacji
#chisq.test - badanie proporcji strukturą dwuwymiarową
#prob.test - proporcje, w jednej populacji albo w wielu
#bnom.test - nieasymptotyczny w jednej populacji

#zweryfikować hipoteze że liczba godzin nie przekracza 8
#H0: u = 8 
#H1: u < 8
# alfa = 0.05

t.test(godziny, mu = 8, alternative = "less")

#p-value = 0.003
#decyzja: ponieważ p-wartość <0.05, więc odrzucamy H_o  na korzyść H_1, nie przekracza 7


losuj_id <- sample(1:nrow(df_saty),size = 70)
df.test <- df_saty[losuj_id, ]