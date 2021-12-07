library(readxl)
library(dplyr)
library(ggplot2)

p_info <- read_excel("7_tables.xlsx", sheet = 1)
s_info <- read_excel("7_tables.xlsx", sheet = 2)
m1_info <- read_excel("7_tables.xlsx", sheet = 3)
m2_info <- read_excel("7_tables.xlsx", sheet = 4)

full_clinical <- p_info %>%
  left_join(s_info) %>%
  select(SAMPLE_ID, SEX, HISTOLOGICAL_SUBTYPE)

mutations <- bind_rows(m1_info, m2_info)

mutations_gene <- mutations %>%
  filter(Hugo_Symbol == "APC")

full_table <- mutations_gene %>%
  left_join(full_clinical, by = c("Tumor_Sample_Barcode" = "SAMPLE_ID"))

plot <- ggplot(full_table, aes(x = SEX)) +
  geom_bar() +
  facet_grid(~ HISTOLOGICAL_SUBTYPE) +
  labs(title = "APC mutations")

ggsave(filename = "APC mutations.png", plot, width = 25, height = 10, units = "cm")

barplot_mutations <- function(gene) {
  
  gene <- gene
  name <- paste0(gene, " mutations")
  
  mutations_gene <- mutations %>%
    filter(Hugo_Symbol == gene)
  
  full_table <- mutations_gene %>%
    left_join(full_clinical, by = c("Tumor_Sample_Barcode" = "SAMPLE_ID"))
  
  ggplot(full_table, aes(x = SEX)) +
    geom_bar() +
    facet_grid(~ HISTOLOGICAL_SUBTYPE) +
    labs(title = name)
  
  ggsave(filename = paste0(name, ".png"), plot, width = 25, height = 10, units = "cm")
  
}

barplot_mutations("TP53")
