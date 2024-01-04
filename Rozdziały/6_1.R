# Schemat budowy wykresu

# geom_point() - Punkty
# Opcje: size, shape, colour, fill, alpha

# geom_line() - Linie
# Opcje: size, linetype, colour, alpha

# geom_vline() - Linie pionowe
# Opcje: size, linetype, colour, alpha

# geom_hline() - Linie poziome
# Opcje: size, linetype, colour, alpha

# geom_smooth() - Krzywa wygładzona
# Opcje: method, se, size, linetype, colour, alpha

# geom_segment() - Linie od ... do ...
# Opcje: size, linetype, colour, alpha

# geom_bar(), geom_col() - Słupki
# Opcje: position, linetype, colour, fill, alpha

# geom_histogram() - Histogram
# Opcje: bins, linetype, colour, fill, alpha

# geom_density() - Gęstość
# Opcje: size, linetype, colour, fill, alpha

# geom_boxplot() - Pudełko-wąsy
# Opcje: size, linetype, colour, fill, alpha, coef, outlier.size, outlier.shape,
# outlier.colour, outlier.fill, outlier.alpha

# stat_function() - Funkcja statystyczna
# Opcje: fun, args=list(...), size, linetype, colour, alpha

# stat_ecdf() - Dystrybuanta empiryczna
# Opcje: size, linetype, colour, alpha

# stat_qq() - Punkty kwantyl-kwantyl
# Opcje: size, shape, colour, fill, alpha

# stat_qq_line() - Linie kwantyl-k


# scale_x_continuous()
# scale_x_discrete()
# scale_y_continuous()
# scale_y_discrete()


# coord_cartesian(xlim = NULL, ylim = NULL, expand = TRUE)
# Opis: Zmienia zakres współrzędnych X i Y. Dane poza zakresem są niewidoczne, ale nie tak jak w przypadku skal ustawionych na NA. Argument expand = TRUE dodaje niewielkie wartości do zakresu.

# coord_fixed(ratio = 1, xlim = NULL, ylim = NULL, expand = TRUE)
# Opis: Zmienia proporcje ratio między osiami. Dodatkowo pozwala na zmianę zakresu współrzędnych.

# coord_flip(xlim = NULL, ylim = NULL, expand = TRUE)
# Opis: Zamienia współrzędne miejscami (transponuje). Dodatkowo pozwala na zmianę zakresu współrzędnych.

# facet_wrap(~ zm, nrow = NULL, ncol = NULL, scales = "fixed")
# Opis: Tworzy wielokrotność wykresów (facet) w oparciu o zmienną zm. Liczbę wierszy określa parametr nrow, liczbę kolumn określa ncol. scales = "fixed" oznacza, że skale są stałe dla wszystkich wykresów.

# facet_grid(zm_1 ~ zm_2, scales = "fixed", space = "fixed")
# Opis: Podobnie jak facet_wrap, ale dla dwóch zmiennych zm_1 i zm_2. scales = "fixed" oznacza, że skale są stałe, a space = "fixed" oznacza stałą odległość między wykresami.

