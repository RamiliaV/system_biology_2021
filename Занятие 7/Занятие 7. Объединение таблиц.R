library(readxl)
library(dplyr)

p_info <- read_excel("7_tables.xlsx", sheet = 1)
s_info <- read_excel("7_tables.xlsx", sheet = 2)
m1_info <- read_excel("7_tables.xlsx", sheet = 3)
m2_info <- read_excel("7_tables.xlsx", sheet = 4)

# left_join()
join_1 <- left_join(m1_info, s_info, by = c("Tumor_Sample_Barcode" = "SAMPLE_ID"))

# right_join()
join_2 <- right_join(m1_info, s_info, by = c("Tumor_Sample_Barcode" = "SAMPLE_ID"))

# inner_join()
join_3 <- inner_join(s_info, m1_info, by = c("SAMPLE_ID" = "Tumor_Sample_Barcode"))

# full_join()
join_4 <- full_join(m1_info, s_info, by = c("Tumor_Sample_Barcode" = "SAMPLE_ID"))

# semi_join()
join_5 <- semi_join(s_info, m2_info, by = c("SAMPLE_ID" = "Tumor_Sample_Barcode"))

# anti_join()
join_6 <- anti_join(s_info, m2_info, by = c("SAMPLE_ID" = "Tumor_Sample_Barcode"))

s_info %>%
  filter(SAMPLE_ID %in% unique(m2_info$Tumor_Sample_Barcode))

m_info <- bind_rows(m1_info, m2_info)
