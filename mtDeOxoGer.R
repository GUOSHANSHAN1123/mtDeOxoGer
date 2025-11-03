# 完整的数据分析和模型评估
# 读取数据
data <- read.table("feature_files.txt", header = TRUE)

# 数据预处理
# 检查数据类型
str(data)

# 处理缺失值（如果有）
data <- na.omit(data)

# 确保标签是因子
data$label <- as.factor(data$label)

# 查看类别分布
table(data$label)
prop.table(table(data$label))

# 数据标准化（对于连续型特征）
numeric_columns <- sapply(data, is.numeric)
data[numeric_columns] <- scale(data[numeric_columns])

# 数据分割
set.seed(123)
train_index <- sample(1:nrow(data), 0.8 * nrow(data))
train_data <- data[train_index, ]
test_data <- data[-train_index, ]

# 构建逻辑回归模型
model <- glm(label ~ ., data = train_data, family = binomial)

# 模型摘要
summary(model)

# 系数和OR值（优势比）
coefficients <- coef(model)
odds_ratios <- exp(coefficients)
results <- data.frame(
  Coefficient = coefficients,
  Odds_Ratio = odds_ratios
)
print(results)

# 预测
probabilities <- predict(model, newdata = test_data, type = "response")
predicted_classes <- ifelse(probabilities > 0.5, 1, 0)

# 详细评估
conf_matrix <- confusionMatrix(as.factor(predicted_classes), test_data$label)
print(conf_matrix)

# ROC曲线和AUC
roc_curve <- roc(test_data$label, probabilities)
plot(roc_curve, main = "ROC Curve")
auc_value <- auc(roc_curve)
cat("AUC值:", auc_value, "\n")

# 保存重要结果
output <- list(
  model = model,
  coefficients = coefficients,
  odds_ratios = odds_ratios,
  confusion_matrix = conf_matrix,
  auc = auc_value
)

# 保存模型（可选）
saveRDS(model, "logistic_regression_model.rds")