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


# 2. Обработка


# 3. Со-встречамость мутаций


# 4. Выживаемость
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

