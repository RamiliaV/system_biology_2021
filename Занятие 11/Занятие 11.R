library(rstatix)
library(readxl)
library(dplyr)
library(ggplot2)
library(ggpubr)

data <- read_excel("7_tables.xlsx", na = "NA")

# Таблица сопряженности
cont_table <- data %>%
  select(OS_STATUS, PRIMARY_TUMOR_PATHOLOGIC_SPREAD) %>%
  table()

# Тест Хи-квадрат Пирсона
chi_test_result <- cont_table %>%
  chisq_test()

# Визуальное представление
mosaicplot(cont_table)

# Тест Фишера
f_test_result <- cont_table %>%
  fisher_test()

# Тесты на таблице больше 2х2
chi_test_result_big <- data %>%
  select(OS_STATUS, PRIMARY_TUMOR_PATHOLOGIC_SPREAD) %>%
  table() %>%
  chisq_test()

data %>%
  select(OS_STATUS, PRIMARY_TUMOR_PATHOLOGIC_SPREAD) %>%
  table() %>%
  mosaicplot()
