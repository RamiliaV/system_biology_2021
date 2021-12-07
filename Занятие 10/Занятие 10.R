library(rstatix)
library(readr)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(caret)

data <- read_csv("data_lm.csv")

# Корреляция
corr_all <- data %>% 
  cor_test(method = "spearman")

ggplot(data, aes(EMC2, BRCA1)) +
  geom_point() +
  geom_smooth(method = "lm", se = F)

set.seed(123) 

training.samples <- data$BRCA1 %>% 
  createDataPartition(p = 0.8, list = FALSE) 
train.data <- data[training.samples, ] 
test.data <- data[-training.samples, ]

# Модель
model <- train(BRCA1 ~ EMC2, data = train.data, method = "lm")

# Параметры модели
summary(model)

# Предсказание
predictions <- model %>% predict(test.data)

# Качество модели
# (a) Prediction error, RMSE
RMSE(predictions, test.data$BRCA1)
# (b) R-square
R2(predictions, test.data$BRCA1)
# (c) Mean absolute error, MAE
MAE(predictions, test.data$BRCA1)

# Модель с препроцессингом
model <- train(BRCA1 ~ EMC2, 
               data = train.data, 
               method = "lm",
               preProcess = c('scale', 'center'))

# Cross validation
fitControl <- trainControl(method = "repeatedcv",   
                           number = 10,     # number of folds
                           repeats = 10)

# Модель с перекрестной проверкой
model <- train(BRCA1 ~ EMC2, 
               data = train.data, 
               method = "lm",
               trControl = fitControl,
               preProcess = c('scale', 'center'))

model

# Множественная линейная регрессия
model_mult <- train(BRCA1 ~ EMC2 + BRCA2, 
               data = train.data, 
               method = "lm",
               trControl = fitControl,
               preProcess = c('scale', 'center'))

ggplot(varImp(model_mult))

# Предсказание
predictions2 <- model_mult %>% predict(test.data)

# Качество модели
# (a) Prediction error, RMSE
RMSE(predictions2, test.data$BRCA1)
# (b) R-square
R2(predictions2, test.data$BRCA1)
# (c) Mean absolute error, MAE
MAE(predictions2, test.data$BRCA1)

model_mult