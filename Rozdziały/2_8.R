# funkcje R w rachunku prawdopodobieństwa
  
 # Rozkład normalny
  # dnorm(x, mean = 0, sd = 1)
  # pnorm(x, mean = 0, sd = 1)
  # qnorm(p, mean = 0, sd = 1)
  # rnorm(n, mean = 0, sd = 1)

    dnorm(0) # średnia i odch. standardowe domyślne, czyli 0 i 1
    dnorm(0, mean = 10, sd = 15)
    pnorm(0) # Pr(X <= 0), gdzie X - N(0, 1)
    pnorm(3, 6, 10) # Pr(X <= 3), gdzie X - N(6, 10^2)
    qnorm(0.7) # Oblicz a, by F(a) = 0.7
    qnorm(0.7, 50, 25) # Oblicz a, by F(a) = 0.7 ale X - N(50, 25^2)
    
  # Rozkład t-Studenta
    # dt(x, df)
    # pt(x, df)
    # qt(p, df)
    # rt(n, df)
    
  # Rozkład jednostajny
    # dunif(x, min = 0, max = 1)
    # punif(x, min = 0, max = 1)
    # qunif(p, min = 0, max = 1)
    # runif(n, min = 0, max = 1)
    
  # Rozkład wykładniczy
    # dexp(x, rate = 1)
    # pexp(x, rate = 1)
    # qexp(p, rate = 1)
    # rexp(n, rate = 1)
  
    # Rozkład dwumianowy
    # dbinom(x, size, prob)
    # pbinom(x, size, prob)
    # qbinom(p, size, prob)
    # rbinom(n, size, prob)
    
    # Obliczmy prawdopodobieństwo tego, że w grupie 20 studentów przynajmniej 7 wyjedzie na wakacje za granicę. Przyjmujmy, że prawdopodobieństwo tego zdarzenia dla losowo wybranego studenta wynosi 0.3
      
      # 1 sposób
        dbinom(7, size = 20, prob = 0.3) # Obliczamy Pr(X=7), a chcemy Pr(X>=7)
        (prawd <- dbinom(7:20, size = 20, prob = 0.3)) # Pr(X=7), Pr(X=8), ..., Pr(X=20)
        sum(prawd) # Sumujemy - to jest nasza odpowiedź
        
      # 2 sposób
        1 - pbinom(6, 20, 0.3) # z dystrybuantą
        
    # Rozkład Poissona
      # dpois(x, lambda)
      # ppois(x, lambda)
      # qpois(p, lambda)
      # rpois(n, lambda)