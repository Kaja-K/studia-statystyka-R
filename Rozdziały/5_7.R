# przetwarzaniegrupy zmiennych
    
  across(.cols = everything(), .fns, .names = NULL)
  # cols - wybór kolumn, fns - funkcja albo lista funkcji dla cols, names - nazwy kolumn po przetworzeniu 
  
  bank <- read.csv("Rozdziały/Dane/bankFull.csv", sep = ";", header = TRUE)
  
  bank %>% select(age, job, marital, education, duration)
  bank[1:2, ]
  
  sapply(bank, typeof) 
  
  summarise(bank, across(.cols = where(is.double), .fns = mean))
  
  summarise(bank, across(where(is.double), ~sum(.x)/length(.x)))
  
  summarise(bank, across(.cols = where(is.double), ~quantile(.x, probs = c(0.25, 0.5, 0.75)),
            .names = "kwantyl_{.col}"),
            rzad_kwantyla = c(0.25, 0.5, 0.75))
  
  mutate(bank, across(.cols = c(age, duration), ~(.x - mean(.x))/sd(.x))) %>% head(4)
  
  bankNA <- bank # by nie modyfikować oryginalnego zbioru
  bankNA$age[c(1, 3)] <- NA
  bankNA
  
  summarise(bank, across(.cols = where(is.double), list(srednia = mean, odchStd = sd)))
  
  Mean_SD <- list( srednia = ~mean(.x, na.rm = TRUE),odchStd = ~sd(.x, na.rm = TRUE))
  summarise(bank, across(.cols = where(is.double), Mean_SD))
  
  