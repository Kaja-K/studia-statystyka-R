# wybór przypadków i zmiennych do analizy
library('dplyr')  
rd <- data.frame(plec, wiek, mieszka, papierosy, wwwGodziny)
  
  select(rd, plec, wiek) # tylko dwie zmienne
  select(rd, -wiek) # wszystkie zmienne oprócz: wiek
  select(rd, plec:wiek) # od płci do wieku (w kolejnosci)
  select(rd, -(plec:wiek)) # wszystkie oprócz zm: od płci do wieku
  select(rd, contains("m")) # nazwy zawierajace m
  select(rd, starts_with("m")) # zmienne zaczynajace sie m
  select(rd, ends_with("o")) # zmienne konczace sie na o
  select(rd, num_range("m", 1:4)) # od m1 do m4 (bez kolejnosci)
  select(rd, matches("m")) # pasujace do wyrazenia regularnego
  select(rd, wiek, everything()) # zmiana kolejności zmiennych: najpierw wiek później pozostałe
  select(rd, all_of(1)) # wszystkie zmienne o nazwach w wektorze wek
  select(rd, any_of(4)) # jak all_of(), ale nie zwraca błędu, gdy zm. nie istnieją
  select(rd, where(is.numeric())) # zmienne, dla których fun zwraca TRUE, np. fun = is.numeric
  

    filter(rd, plec == "k", mieszka == "wies", papierosy == 0)#niepalące kobiety ze wsi
    filter(rd, wiek > 50 | wiek < 30, plec == "m") # (wiek > 50 | wiek < 30) & plec == "m"
    select(rd, wiek, papierosy, wwwGodziny) #wybierz wiek papierosy i godziny
    select(rd, wiek:papierosy) #wybierz zmienne od wiek do papierosy
    select(rd, plec, mieszka:wwwGodziny) #wybierz pierwszą zmienną oraz od mieszka do godziny
    
    # - wybierz zmienne płęc i papierosy i kobiety co palą mniej niż 5 papierosów
      #1 opcja 
      krok1 <- select(rd, plec, papierosy) # wybierz najpierw zmienne (zobacz jak wygląda krok1)
      krok2 <- filter(krok1, plec == "k", papierosy < 5) # później przypadki
      krok2
      
      #2 opcja
      filter(select(rd, plec, papierosy), plec == "k", papierosy < 5)
      
      #3 opcja
      rm %>% select(plec, papierosy) %>%
             filter(plec == "k", papierosy < 5)
      
      # nowy operator potoku
      deparse(substitute( 1:5 |> mean() ))
      deparse(substitute( 1:5 %>% mean() ))