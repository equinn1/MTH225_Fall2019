library(glmnet)
#rm(list=ls())
epa = read.csv("epa.csv")
str(epa)

lambda_seq <- 10^seq(2, -2, by = -.1)

epa2=epa[,c("mpg","etw","cstdwn","cmp","cid","rhp")]
str(epa2)

summary(epa2)

x_vars <- data.matrix(epa2[,
            c("etw","cmp","cid","rhp")])

y_var <- epa2$mpg

lasso_all2 <- glmnet(x_vars, y_var, alpha = 1, 
        lambda = lambda_seq, type.gaussian="naive")

coef(lasso_all2)

# Splitting the data into test and train

train = sample(1:nrow(x_vars), nrow(x_vars)/2)
x_test = (-train)
y_test = y_var[x_test]

cv_output <- cv.glmnet(x_vars[train,], y_var[train], 
                       alpha = 1, lambda = lambda_seq)

# identifying best lamda
best_lam <- cv_output$lambda.min

# Rebuilding the model with best lamda value identified
lasso_best <- glmnet(x_vars[train,], y_var[train], alpha = 1, lambda = best_lam)
pred <- predict(lasso_best, s = best_lam, newx = x_vars[x_test,])

final <- cbind(y_var[x_test], pred)
# Checking the first six obs
head(final)

str(final)

actual <- final[,1]
preds <-  final[,2]
rss <- sum((preds - actual) ^ 2)
tss <- sum((actual - mean(actual)) ^ 2)
rsq <- 1 - rss/tss
rsq

# Inspecting beta coefficients
coef(lasso_best)

# identifying 1 std error above best lamda
lam_1se <- cv_output$lambda.1se
lam_1se

# Rebuilding the model with best lamda value identified
lasso_1se <- glmnet(x_vars[train,], y_var[train], alpha = 1, lambda = best_lam)
pred_1se <- predict(lasso_1se, s = lam_1se, newx = x_vars[x_test,])

final_1se <- cbind(y_var[x_test], pred_1se)
# Checking the first six obs
head(final_1se)

str(final_1se)

actual_1se <- final_1se[,1]
preds_1se <-  final_1se[,2]
rss_1se <- sum((preds_1se - actual_1se) ^ 2)
tss_1se <- sum((actual_1se - mean(actual_1se)) ^ 2)
rsq_1se <- 1 - rss_1se/tss_1se
rsq_1se

# Inspecting beta coefficients
coef(lasso_best)

lm1 = lm(mpg~etw+cmp+cid+rhp,data=epa2)
summary(lm1)

