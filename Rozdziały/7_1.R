# estymacja przedziałowa średniej i proporcji

library(Hmisc)

  t.test(x, conf.level = 0.95)
  
  wydatki <- c(30, 25, 16, 22, 34, 54, 23, 28, 23, 21)
  t.test(wydatki, conf.level = 0.9)
  
  binconf(150, 300, alpha = 0.05, method = "all")  
  binconf(20, 40, alpha = 0.05, method = "all")