install.packages("stringr")

library(stringr)

# Длина
str_length("abc")
str_length("1234567890")

# Объединение
str_c("x", "y")
str_c("x", "y", sep = " - ")
str_c("prefix-", c("a", "b", "c"), "-suffix")
str_c(c("x", "y", "z"), collapse = " - ")

# Выбор части 
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)
str_sub(x, 2, 4)
str_sub("Apple", 2, 4)

# Регистр
str_to_upper(c("i", "l"))
str_to_lower("L")

data2_2 <- data2 %>%
  mutate(MSI_STATUS = str_to_lower(MSI_STATUS))

# Регулярные выражения
x <- c("apple", "banana", "pear")
str_view(x, "p")
str_view(x, ".n.")

# Обозначить специальные символы
str_view(c("abc", "a.c", "bef"), "a.c")
str_view(c("abc", "a.c", "bef"), "a\\.c")

# Якорь
str_view(x, "^a")
str_view(x, "e$") 

x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")

# Классы
str_view(c("abc", "a.c", "a*c", "a c"), "a[.]c")
str_view(c("abc", "a.c", "a*c", "a c"), ".[*]c")
str_view(c("abc", "a.c", "a*c", "a c"), "a[ ]")
str_view(c("abc", "a.c", "a*c", "a c"), "a\\s")

str_view(c("abc", "a1c", "a2c", "a c"), "a\\d")

str_view(c("grey", "gray"), "gr[ea]y")

# Повторения
x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, 'C[LX]+')

str_view(x, "C{2}")
str_view(x, "I{2,}")
str_view(x, "C{2,3}")

# Нахождение паттернов
x <- c("apple", "banana", "pear")
str_subset(x, "an+")

words[str_detect(words, "a+")]
str_subset(words, "x$")

# Разделение
sentences %>%
  head(3) %>% 
  str_split(" ")

data %>%
  filter(str_detect(PATIENT_ID, "\\-35") & str_detect(HISTOLOGICAL_SUBTYPE, "Rect"))