#wyznacz kwantyle rzędu p = 0.85, p = 0.99, p = 0.27.
qnorm(0.85)
qnorm(0.99)
qnorm(0.27)
qt(0.85, 15)
qt(0.99, 15)
qt(0.27, 15)

#oblicz prawdopodobieństwa: Pr(X > 1.8), Pr(X > 2.47)
1 - pnorm(1.8)
1 - pnorm(2.47)
1 - pt(1.8, 15)
1 - pt(2.47, 15)