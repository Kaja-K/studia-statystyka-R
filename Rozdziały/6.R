library(ggplot2)
library(tidyverse)

ramka <- data.frame(c("pon","wt","sr","cz","pt"),c(20,45,60,48,75),c(30,18,70,50,55))
names(ramka) <- c("dzien","kob","men")

ramka <- pivot_longer(ramka,cols=c("kob","men"),names_to = "plec",values_to = "liczba")

ramka$plec <- recode_factor(ramka$plec,kob="kobieta",men="mezczyzna")
ramka$dzien <- factor(ramka$dzien,levels=c("pon","wt","sr","cz","pt"),labels=c("pon","wt","sr","cz","pt"),ordered=TRUE)
ramka

ggplot(ramka,aes(x=dzien,y=liczba,fill=plec)) + geom_col(position = "dodge") + labs(x="Dzien",y="Liczba klientow",fill="Plec")