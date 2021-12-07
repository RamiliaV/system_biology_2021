# Установка пакета dplyr
install.packages("dplyr")

# Запуск пакета
library(dplyr)

# Импортируйте первый лист из файла Excel. 
# Не забудьте переде этим запустить правильный пакет!
library(readxl)
table1 <- read_excel("Oral Squamous Cell Carcinoma_Full.xlsx", sheet = 1, na = "NA")
# Посмотрите названия столбцов
# Обратите внимание на то, что перед каждым названием 
# в консоли отображается номер столбца.
names(table1)

# Функция select() позволяет нам выбирать отдельные столбцы
# по названию (пишем без кавычек):
table2 <- select(table1, PATIENT_ID, SEX, AGE)
# или по номеру:
table2 <- select(table1, 2, 4, 7)

# Также мы можем выбирать столбцы по порядку через двоеточие
table3 <- select(table1, PATIENT_ID:AGE)
table3 <- select(table1, 2:10)

# Можем выбирать по первому или последнему символу/ам в названиях
table4 <- select(table1, starts_with("P"))
table5 <- select(table1, ends_with("ID"))

# Можем выбирать по содержанию символов в названиях
table6 <- select(table1, contains("STAGE"))

# Другие примеры есть в презентации, а также на сайте пакета

# Функция filter() позволяет нам фильтровать на основе условий
table_male <- filter(table1, SEX == "Male")
table_age_lower_30 <- filter(table1, AGE <= 30)

# Можем фильтровать по нескольким значениям в одном столбце
table_stages <- filter(table1, TUMOR_STAGE %in% c("T4", "T3"))
# Или фильтровать по "не равно"
table_stages <- filter(table1, TUMOR_STAGE != "T2")

# Можем фильтровать по нескольким условиям
table_female_age_lower_65 <- filter(table1, SEX == "Female" & AGE <= 65)
table_lower_30_over_70 <- filter(table1, AGE <= 30 | AGE >= 70)

# Функция arrange() позволяет нам сортировать по столбцам
table_male_sort <- arrange(table_male, AGE)
# Можем сортировать в нисходящем порядке
table_male_sort_reverse <- arrange(table_male, desc(AGE))
# Можем сортировать под двум столбцам
table_male_sort_2 <- arrange(table_male, AGE, DFS_MONTHS)

# Функция mutate() позволяет создать новый столбец на основе данных из других столбцов
table_new_col <- mutate(table1, age_after = AGE + (OS_MONTHS / 12))

# Оператор pipe %>% позволяет использовать несколько функций на одной таблице последовательно
table_pipe <- table1 %>% filter(SEX == "Male") %>% arrange(AGE)
table_pipe_2 <- table1 %>% 
  filter(SEX == "Female" & AGE <= 65) %>%
  mutate(age_after = AGE + (OS_MONTHS / 12)) %>%
  arrange(age_after)
# Те же самые действия без оператора pipe - 3 отдельные таблицы
table_filter <- filter(table1, SEX == "Female" & AGE <= 65)
table_mutate <- mutate(table_filter, age_after = AGE + (OS_MONTHS / 12))
table_arrange <- arrange(table_mutate, age_after)

# Функции group_by() и summarize() используются в связке
# Функция group_by() делит таблицу на группы по указанному столбцу
# Функция summarize() получает новую таблицу по функциям указанным в ней
table_summary_1 <- table1 %>%
  group_by(SEX) %>%
  summarize(count = n())

table_summary_2 <- table1 %>%
  group_by(SEX) %>%
  summarize(min = min(AGE), max = max(AGE))

table_summary_3 <- table1 %>%
  group_by(SEX) %>%
  summarize(percent_free = mean(DFS_STATUS == "Recurred/Progressed")*100)

table_summary_4 <- table1 %>%
  group_by(SEX, DFS_STATUS) %>%
  summarize(count = n())

# ЗАДАНИЕ

# Сохраните из изначальной таблицы в новую только столбцы
# SAMPLE_ID, SEX, AGE, DAILY_ALCOHOL, SMOKER, DFS_MONTHS
new_table
  
# Сделайте фильтр по таблице new_table:
# DAILY_ALCOHOL равно "No" и  SMOKER равно "No":
new_table_2 <- filter()
# Сортируйте таблицу по возрасту

# Сделайте фильтр по таблице new_table:
# DFS_MONTHS больше или равно 45:
new_table_3 <- filter()
# Сортируйте таблицу по полу и возрасту

# Создайте новый столбец real_percent из таблицы table1, 
# умножив стобец PERCENTAGE_TUMOR_PURITY на 100
new_table_4 <- mutate(table1, real_percent = PERCENTAGE_TUMOR_PURITY*100)

# С помощью функций group_by и summarize, найдите минимальный возраст 
# по группам местоположения опухоли (столбец TUMOR_TISSUE_SITE)
new_table_5 <- table1 %>% group_by %>% summarize()

# С помощью функций group_by и summarize, найдите процент женщин 
# по группам стадии рака (столбец TUMOR_STAGE)
new_table_6 <- table1 %>% group_by %>% summarize()

# Создайте таблицу на основе table1 на основе следущих критериев:
# 1. выбрать только столбцы SEX, AGE, TUMOR_TISSUE_SITE, OS_STATUS, OS_MONTHS,
# 2. фильтровать по TUMOR_TISSUE_SITE равен Tongue и возраст больше 45
# 3. создать новый столбец real_age по формуле AGE + (OS_MONTHS / 12)
# 4. группировать по столбцу OS_STATUS
# 5. посчитать минимальный и максимальный возраст по столбцу real_age
# 6. сортировать в нисходящем порядке по максимальному возрасту
# Используйте оператор pipe!

table1 %>%
  select(SEX, AGE, TUMOR_TISSUE_SITE, OS_STATUS, OS_MONTHS) %>%
  filter(TUMOR_TISSUE_SITE == "Tongue" & AGE > 45) %>%
  mutate(real_age = AGE + (OS_MONTHS / 12)) %>%
  group_by(OS_STATUS) %>%
  summarise(min = min(real_age), max = max(real_age)) %>%
  arrange(desc(max))