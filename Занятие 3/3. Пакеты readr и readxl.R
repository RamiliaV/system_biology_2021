# Установка пакета readr, если вы не установили его в прошлый раз.
# Если не уверены, посмотрите во вкладке Packages в нижнем правом углу.
# Все установленные пакеты видны в этой вкладке.
install.packages("readr")

# Запуск пакета
library(readr)

# Функция импорта таблицы в формате csv
mpg <- read_csv2("mpg.csv")
gapminder <- read_csv("gapminder.csv")

# Как видите, при импорте в консоли отображаются типы данных в прочитанных столбцах.

# Установка пакета readxl
install.packages("readxl")

# Запуск пакета
library(readxl)

# Функция показывает названия листов в файле Excel
excel_sheets("Oral Squamous Cell Carcinoma_Full.xlsx")

# Функция импорта таблицы из файла Excel
# Аргумент sheet - считывае либо номер листа по порядку
table1 <- read_excel("Oral Squamous Cell Carcinoma_Full.xlsx", sheet = 1)
# Либо его название. Название можно скопировать из результата функции excel_sheets()
table1 <- read_excel("Oral Squamous Cell Carcinoma_Full.xlsx", sheet = "Clinical data")

# Вопросы и задания
# Посмотрите на типы данных в таблицах, которые мы импортировали
# Какого типа данных нет?

# Используйте функцию str на таблице mpg
# Какая дополнительная информация отображается?

# Сколько листов находится в файле Oral Squamous Cell Carcinoma_Full.xlsx?
# Напишите функцию импорта для второго листа

