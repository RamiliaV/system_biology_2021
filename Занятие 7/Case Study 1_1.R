library(readxl)
library(dplyr)
library(ggplot2)

p_info <- read_excel("7_tables.xlsx", sheet = 1)
s_info <- read_excel("7_tables.xlsx", sheet = 2)
m1_info <- read_excel("7_tables.xlsx", sheet = 3)
m2_info <- read_excel("7_tables.xlsx", sheet = 4)

# Получить таблицу со следующими клиническими данными – Идентификатор образца, 
# Пол, Гистологический подтип (HISTOLOGICAL_SUBTYPE)
clinical_info <- p_info %>%
  left_join(s_info) %>%
  select(SAMPLE_ID, SEX, HISTOLOGICAL_SUBTYPE)

# Получить полную таблицу со всеми мутациями
# Найти мутации по гену APC
m_info <- m1_info %>% 
  bind_rows(m2_info) %>%
  filter(Hugo_Symbol == "APC")

# Построить столбчатую диаграмму по полу и по гистологическому подтипу
full_data <- right_join(clinical_info, m_info, 
                        by = c("SAMPLE_ID" = "Tumor_Sample_Barcode"))

ggplot(full_data, aes(x = SEX)) +
  geom_bar() +
  facet_grid(~ HISTOLOGICAL_SUBTYPE)

# Превратить код в функцию и попробовать на других генах - TP53 и SYNE1
barplot_mutations <- function(gene) {
  
  # Получить полную таблицу со всеми мутациями
  # Найти мутации по гену
  m_info <- m1_info %>% 
    bind_rows(m2_info) %>%
    filter(Hugo_Symbol == gene)
  
  # Построить столбчатую диаграмму по полу и по гистологическому подтипу
  full_data <- right_join(clinical_info, m_info, 
                          by = c("SAMPLE_ID" = "Tumor_Sample_Barcode"))
  
  plot <- ggplot(full_data, aes(x = SEX)) +
    geom_bar() +
    facet_grid(~ HISTOLOGICAL_SUBTYPE)
  
  ggsave(plot = plot, filename = paste0(gene, "_barplot.png"), 
         width = 25, height = 10, units = "cm")
  
}

barplot_mutations("TP53")
barplot_mutations("SYNE1")