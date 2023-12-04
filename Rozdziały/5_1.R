# pięć podstawowych funkcji pakietu dplyr

  select(rd, zm1, zm2) #ramka, zmienna1, zmienna2
  filter(rd, war_1, war_2) #ramka, warunek1, warunek2
  mutate(rd, nowaZm = ...) #ramka, nowa zmienna
  arrange(rd, zm2, desc(zm2)) #ramka, sort rosnący dla zmiennej 2, sory malejący dla zmiennej 2
  summarise(rd, statOpis = mean(zm3)) #ramka, statOpis = mean(zm3) - wartość statystyki opisowej funkcji dla zmiennej 3
  group_by(rd, zm1, zm2) #ramka, zmienna1, zmienna2 - dzieli ramke na grupy kombinacji poziomów zmiennych (tylko dla kategorialnych/ilościowwych dyskretnych)
  