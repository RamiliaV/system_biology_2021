x <- 5
y <- 10

# условное выражение
if (x > 5) {
	print("x greater than 5")
} else if (x < 5) {
	print("x less than 5")
} else {
	print("x equals 5")
}

# циклы
# пока выполняется условие
while (y > 5) {
	print(y)
	y <- y-1
}
# по количеству указанных итераций
for (i in 1:6) {
	a <- x + i
	print(a)
}

# пример простой функции
sum_x_y <- function(arg1, arg2) {
	arg1 + arg2
}
sum_x_y(x,y)

# пример простой функции с аргументом по умолчанию
sum_x_y_default <- function(arg1, arg2 = 2) {
	arg1 + arg2
}
sum_x_y_default(x)
sum_x_y_default(x,y)

# функция return()
two_outcomes_not_work <- function(arg1, arg2) {
	a <- arg1 + arg2
	b <- arg1 - arg2
	a
	b
}
two_outcomes_not_work(x,y)

two_outcomes_work <- function(arg1, arg2) {
	a <- arg1 + arg2
	b <- arg1 - arg2
	return(list(a = a, b = b))
}
two_outcomes_work(x,y)

# локальные переменные
fun_local <- function(x) {
	v <- 1
	v + x
}

fun_local(5)
v # нельзя получить - находится только внутри функции!

# Функция - цель: прочитать файлы, построить график 
path = "for_function/"
files  <- list.files(path )
study_names <- unique(substr(files, start = 1, stop = 4))

#  1. прописать одну итерацию
library(readr)
library(dplyr)
library(ggplot2)

study <- study_names[1]

file_study <- files[grep(pattern = study, files)]
clin_study <- read_csv(paste0(path,file_study[1]))
expression_study <- read_csv(paste0(path,file_study[2]))

full_data <- right_join(clin_study, expression_study)

plot <- ggplot(full_data, aes(x = sex, y = slc34a2)) +
  geom_boxplot() +
  labs(title = paste0(toupper(study), " - SLC34A2 expression vs sex"))

ggsave(filename = paste0(toupper(study), " - SLC34A2 expression vs sex.png"),plot = plot)

# 2. со временными переменными - только одна строка
study <- study_names[i]

# 3. превращение в функции
tables_to_plot <- function(study_names) {
  
  for (i in 1:3) {
    
    study <- study_names[i]
    file_study <- files[grep(pattern = study, files)]
    clin_study <- read_csv(paste0(path,file_study[1]))
    expression_study <- read_csv(paste0(path,file_study[2]))
    
    full_data <- right_join(clin_study, expression_study)
    
    plot <- ggplot(full_data, aes(x = sex, y = slc34a2)) +
      geom_boxplot() +
      labs(title = paste0(toupper(study), " - SLC34A2 expression vs sex"))
    
    ggsave(filename = paste0(toupper(study), " - SLC34A2 expression vs sex.png"),plot = plot)
    
    
  }

}

tables_to_plot(study_names)

# purrr
install.packages("purrr")
library(purrr)

file_clin <- files[grep(pattern = "clin", files)]
file_expr <- files[grep(pattern = "expr", files)]
tables_clin <- map(file_clin, ~ read_csv(paste0(path,.x)))
tables_expr <- map(file_expr, ~ read_csv(paste0(path,.x)))
names(tables_clin) <- file_clin
names(tables_expr) <- file_expr

clin_bind_tables <- bind_rows(tables_clin)
expr_bind_tables <- bind_rows(tables_expr)

full_data <- right_join(clin_bind_tables, expr_bind_tables)

