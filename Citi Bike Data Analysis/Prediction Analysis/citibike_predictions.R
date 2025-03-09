model = lm(tripduration~bikeid + birth.year + usertype, data=citybike.train)
summary(model)

# Residuals:
#   Min     1Q Median     3Q    Max 
# -1518   -447   -198    218  34440 

# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)         4.011e+03  6.640e+02   6.041 1.55e-09 ***
#   bikeid              1.577e-03  6.345e-04   2.485 0.012968 *  
#   birth.year         -1.262e+00  3.354e-01  -3.763 0.000168 ***
#   usertypeSubscriber -7.810e+02  1.125e+01 -69.414  < 2e-16 ***
#
#   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Residual standard error: 901.4 on 49996 degrees of freedom
# Multiple R-squared:  0.08883,	Adjusted R-squared:  0.08877 
# F-statistic:  1625 on 3 and 49996 DF,  p-value: < 2.2e-16

predictions100 = predict(model, citybike.test100)
regr.error(predictions100, citybike.test100withduration$tripduration)

predictions10000A = predict(model, citybike.test10000A)
regr.error(predictions10000A, citybike.test10000Awithduration$tripduration)

# mae          mse         rmse         mape 
# 572.01335 616466.53040    785.15383      1.10202 

predictions10000B = predict(model, citybike.test10000B)
write.csv(predictions10000B, file = "citybikeB10000.csv")
prediction.final <- read.csv("~/citybikeB10000.csv")
colnames(prediction.final) <- c("Id","Predicted")
write.csv(prediction.final,file="citybikeB10000.csv",row.names=FALSE)
