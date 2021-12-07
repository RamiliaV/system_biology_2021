library(readxl)
library(dplyr)
library(janitor)
library(rstatix)
library(stringr)
library(purrr)
library(survival)
library(ggfortify)
library(survminer)

# 1. Импорт данных и объединение
mutations <- read_excel("BRCA.xlsx", 1)
clinical <- read_excel("BRCA.xlsx", 2)

full_data <- mutations %>%
  left_join(clinical)

# 2. Обработка
full_data_2 <- full_data %>%
  mutate_at(c("BRCA1", "BRCA2", "TP53", "PTEN"), ~ifelse(. == "no alteration", 0, 1))
full_data_2 <- clean_names(full_data_2)

# 3. Со-встречамость мутаций
full_data_cor <- full_data_2 %>%
  select(2:5)

pairs <- as.data.frame(combn(names(full_data_cor), 2))

fisher_pairs <- function(pair) {
  
  fisher_results <- full_data_cor %>%
    select(pair) %>%
    table() %>%
    fisher_test() %>%
    mutate(genes = str_to_upper(str_c(pair, collapse = ", ")))
  
}

all_fisher_results <- bind_rows(map(pairs, .f = fisher_pairs))

# 4. Выживаемость
full_data_2$overall_survival_months <- as.numeric(full_data_2$overall_survival_months)
km_surv_fit <- survfit(Surv(overall_survival_months, overall_survival_status) ~ tp53, data=full_data_2)
pvalue_surv <- surv_pvalue(km_surv_fit)$pval

surv_plot_o <- ggsurvplot(
  km_surv_fit,
  data = full_data_2,
  size = 1,                 # change line size
  palette =
    c("#E7B800", "#2E9FDF"),# custom color palettes
  conf.int = TRUE,          # Add confidence interval
  pval = T,              # Add p-value
  risk.table = TRUE,        # Add risk table
  risk.table.col = "strata",# Risk table color by groups
  legend.labs =
    c("No alteration", "Alteration"),    # Change legend labels
  risk.table.height = 0.25, # Useful to change when you have multiple groups
  ggtheme = theme_bw(),      # Change ggplot2 theme
  xlab = "Overall Survival (Months)",
  ylab = "Overall Survival",
  title = str_c("TP53 - breast cancer (Overall survival)")
) 

