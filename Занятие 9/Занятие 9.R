library(rstatix)
library(readxl)
library(dplyr)
library(ggplot2)
library(ggpubr)

data <- read_excel(
  "gene_expression.xlsx",
  na = "NA",
  col_types = c(
    "text",
    "text",
    "numeric",
    "numeric",
    "numeric",
    "numeric",
    "numeric"
  )
)

# Корреляция Пирсона
ggplot(data, aes(ATM, BRCA1)) +
  geom_point()

ggplot(data, aes(ATM, BRCA1)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

corr1 <- data %>%
  cor_test(ATM, BRCA1, method = "pearson")

# Корреляция Спирмана
ggplot(data, aes(BRCA1, BRCA2)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

corr2 <- data %>%
  cor_test(BRCA1, BRCA2, method = "spearman")

# Корреляция - всё со всем
corr_all <- data %>% 
  select(BRCA1, BRCA2, ATM, TP53, NBN) %>%
  cor_test(method = "spearman")

# Корреляционные матрицы
cor.mat <- data %>% 
  select(BRCA1, BRCA2, ATM, TP53, NBN) %>% 
  cor_mat()

cor.mat %>% cor_get_pval()

cor.mat %>%
  cor_as_symbols() %>%
  pull_lower_triangle()

# Коррелограммы
cor.mat %>%
  cor_reorder() %>%
  pull_lower_triangle() %>% 
  cor_plot()

# Регрессия
data1 <- data[-264,]

ggplot(data1, aes(BRCA1, BRCA2)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

corr2 <- data1 %>%
  cor_test(BRCA1, BRCA2, method = "spearman")

model <- lm(BRCA1 ~ BRCA2, data = data1)

summary(model)

layout(matrix(1:4,2,2))
plot(model)