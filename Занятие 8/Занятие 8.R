# пакет rstatix
install.packages(c("rstatix", "ggpubr"))

library(rstatix)
library(readr)
library(dplyr)
library(ggplot2)
library(ggpubr)

data <- read_csv2("forclass8.csv")

# Описательная статистика
data_summary <- data %>%
  group_by(Group) %>%
  get_summary_stats(type = "common")

# Нормальное распределение
data_norm <- data %>%
  group_by(Group) %>%
  shapiro_test(Gene1_expression, Gene2_expression)

# Сравнение с теоретическим средним - НР
data_exp <- data %>%
  filter(Group == "Experiment") 

bxp1 <- ggboxplot(
  data_exp, y = "Gene1_expression", width = 0.5, add = c("mean", "jitter"), 
  ylab = "Gene 1", xlab = FALSE
)
bxp1

ggqqplot(data_exp, x = "Gene1_expression")

ttest_theor <- data_exp %>%
  t_test(Gene1_expression ~ 1, mu = 3)

bxp1 + labs(
  subtitle = get_test_label(ttest_theor, detailed = TRUE)
)

# Сравнение 2 групп - НР
bxp2 <- ggboxplot(
  data, x = "Group", y = "Gene1_expression", 
  ylab = "Gene 1", xlab = "Groups", add = "jitter"
)
bxp2

ggqqplot(data, x = "Gene1_expression", facet.by = "Group")

ttest_2g <- data %>% 
  t_test(Gene1_expression ~ Group) %>%
  add_significance()

ttest_2g <- ttest_2g %>% add_xy_position(x = "Group")
bxp2 + 
  stat_pvalue_manual(ttest_2g, tip.length = 0) +
  labs(subtitle = get_test_label(ttest_2g, detailed = TRUE))

# Сравнение с теоретическим средним - ННР
bxp3 <- ggboxplot(
  data = data_exp, y = "Gene2_expression", width = 0.5, add = c("mean", "jitter"), 
  ylab = "Gene 2", xlab = FALSE
)
bxp3

wilcox_test_theor <- data_exp %>% 
  wilcox_test(Gene2_expression ~ 1, mu = 0.9)
bxp3 + 
  labs(subtitle = get_test_label(wilcox_test_theor, detailed = TRUE))

# Сравнение 2 групп - ННР
bxp4 <- ggboxplot(
  data, x = "Group", y = "Gene2_expression", 
  ylab = "Gene 2", xlab = "Groups", add = "jitter"
)
bxp4

wilcox_test_2g <- data %>% 
  wilcox_test(Gene2_expression ~ Group) %>%
  add_significance()

wilcox_test_2g <- wilcox_test_2g %>% add_xy_position(x = "Group")
bxp4 + 
  stat_pvalue_manual(wilcox_test_2g, tip.length = 0) +
  labs(subtitle = get_test_label(wilcox_test_2g, detailed = TRUE))

# Сравнение 3 и более групп
# Описательная статистика
data_summary1 <- data %>%
  group_by(Category) %>%
  get_summary_stats(type = "common")

# Нормальное распределение
data_norm1 <- data %>%
  group_by(Category) %>%
  shapiro_test(Gene1_expression, Gene2_expression)

ggboxplot(data, x = "Category", y = "Gene2_expression")

ggqqplot(data, "Gene2_expression", facet.by = "Category")

anova_1 <- data %>% anova_test(Gene2_expression ~ Category)
# Не достоверно!

pwc1 <- data %>% tukey_hsd(Gene2_expression ~ Category)

pwc1 <- pwc1 %>% add_xy_position(x = "Category")
ggboxplot(data, x = "Category", y = "Gene2_expression") +
  stat_pvalue_manual(pwc1, hide.ns = TRUE) +
  labs(
    subtitle = get_test_label(anova_1, detailed = TRUE),
    caption = get_pwc_label(pwc1)
  )

# Ненормальное распределение
ggboxplot(data, x = "Category", y = "Gene1_expression")

ggqqplot(data, "Gene1_expression", facet.by = "Category")

kruskal <- data %>% kruskal_test(Gene1_expression ~ Category)
# Не достоверно!

pwc2 <- data %>% 
  dunn_test(Gene1_expression ~ Category, p.adjust.method = "bonferroni") 

pwc2 <- pwc2 %>% add_xy_position(x = "Category")
ggboxplot(data, x = "Category", y = "Gene1_expression") +
  stat_pvalue_manual(pwc2) +
  labs(
    subtitle = get_test_label(kruskal, detailed = TRUE),
    caption = get_pwc_label(pwc2)
  )