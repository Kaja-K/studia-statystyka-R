# wczytywanie danych do pliku

  #read.table("nazwa_pliku", header = FALSE, sep = "", dec = ".", na.strings = "NA", encoding = "unknown") # wartości domyślne
  read.csv2()
  read.csv()
  
  # read.csv2()
  read.csv2("Zadania/Dane/satysfakcja.csv")
  read.table("Zadania/Dane/satysfakcja.csv", header = TRUE, sep = ";",
             dec = ",")
  # read.csv()
  read.csv("Zadania/Dane/satysfakcja.csv")
  read.table("Zadania/Dane/satysfakcja.csv", header = TRUE, sep = ",")
  
  # read txt
  read.csv2("Zadania/Dane/powiaty.txt")
  
    powiaty <- read.table("Zadania/Dane/powiaty.txt", header=TRUE, dec=",")
    usa <- read.table("Zadania/Dane/P081.dat", header=TRUE)
    zatrud <- read.table("Zadania/Dane/zatrudnienie.dat", header=TRUE, dec=",", na.strings=-1)
    zatrud0 <- read.csv2("Zadania/Dane/zatrudnienie0.csv", encoding = "UTF-8")
    
    usa
    zatrud
    
    read_xls("nazwa_pliku.xls", sheet = NULL) # sheet to numer lub nazwa skoroszytu Excela
    read_xlsx("nazwa_pliku.xlsx", sheet = NULL)