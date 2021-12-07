# Установка пакета ggplot2
install.packages("ggplot2")

# Запуск пакета
library(ggplot2)

# Таблица diamonds загружается вместе с пакетом. Импортировать ее не надо.
# Чтобы посмотреть данные в таблице, можно выполнить эту строку:
diamonds

# Гистограмма
ggplot(diamonds, aes(x = price)) +
  geom_histogram()
# Модификации:
ggplot(diamonds, aes(price)) +
  geom_histogram(binwidth = 10)
ggplot(diamonds, aes(price)) +
  geom_histogram(bins = 1000)

# Стобиковая диаграмма
ggplot(diamonds, aes(x = cut)) +
  geom_bar()
# Модификации:
ggplot(diamonds, aes(x = cut)) +
  geom_bar(width = 0.1)

# Точечная диаграмма
ggplot(diamonds, aes(x=carat, y=price)) +
  geom_point()

# Боксплот
ggplot(diamonds, aes(cut, price)) +
  geom_boxplot()

# Добавление цвета и обводки 
# Легенда создается автоматически
ggplot(diamonds, aes(x=carat, y=price, color=cut)) +
  geom_point()
ggplot(diamonds, aes(x = carat, color = color)) +
  geom_histogram()
ggplot(diamonds, aes(x = carat, fill = color)) +
  geom_histogram()
ggplot(diamonds, aes(x = cut, fill = color)) +
  geom_bar()
ggplot(diamonds, aes(x = cut, y = price, fill = color)) +
  geom_boxplot()
ggplot(diamonds, aes(x = cut, y = price, color = color)) +
  geom_boxplot()

# График по группам
ggplot(diamonds, aes(x = price)) +
  geom_histogram(bins = 1000) +
  facet_grid( ~ color)

# Добавление статистики
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() + 
  geom_smooth(method = lm)

# Координаты
ggplot(diamonds, aes(x = cut, y = price, color = color)) + 
  geom_boxplot() + 
  coord_flip()

# Темы
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() + 
  labs(title="Отношение цены и карата бриллианта", x="Карат", y="Цена", color = "Огранка")

# Составной график
install.packages("ggpubr")
library(ggpubr)
p1 <- ggplot(diamonds, aes(x = price, fill = color)) +
  geom_histogram(bins = 1000) +
  labs(title="Цена бриллиантов по цветам", x="Цена", y="Частота")
p2 <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + 
  geom_point() +
  labs(title="Отношение цены и карата бриллианта", x="Карат", y="Цена", color = "Огранка")
p3 <- ggplot(diamonds, aes(x = cut, y = price)) + 
  geom_boxplot() + 
  coord_flip() +
  labs(title="Цена бриллаинта по огранке", x="Цена", y="Огранка")
p4 <- ggarrange(p1, p2, p3, labels = c("A", "B", "C"), ncol = 3, nrow = 1)

# Сохранение графиков
ggsave("plot1.png", p1, width = 20, height = 20, units = "cm")
ggsave("plot2.png", p4, width = 40, height = 20, units = "cm")