a <- rnorm(30, mean = 3, sd = 1)
b <- rnorm(30, mean = 2, sd = 2)
c <- 1:10
d <- 1:10
while (shapiro.test(c)$p.value > 0.05) {
  c <- sample(seq(from = -2, to = 4, by = 0.01), size = 30, replace = TRUE)
}
while (shapiro.test(d)$p.value > 0.05) {
  d <- sample(seq(from = -3, to = 3, by = 0.01), size = 30, replace = TRUE)
}

data <- data.frame(matrix(nrow = 60, ncol = 6))

names(data) <- c("Sample_ID", "Group", "Sex", "Category", "Gene1_expression", "Gene2_expression")

data$Sample_ID <- paste0("SID_", 1:60)
data$Group <- c(rep("Control", 30), rep("Experiment", 30))
data$Gene1_expression <- c(a,b)
data$Gene2_expression <- c(c,d)
data$Sex <- sample(c("M", "F"), size = 60, replace = TRUE)
data$Category <- rep(c(rep("A",10), rep("B",10), rep("C",10)), n = 2)

write.csv2(data, "forclass8.csv", row.names = F)

