model = lm(tripduration~bikeid + birth.year + usertype, data=citybike.train)
summary(model)



predictions100 = predict(model, citybike.test100)
regr.error(predictions100, citybike.test100withduration$tripduration)

predictions10000A = predict(model, citybike.test10000A)
regr.error(predictions10000A, citybike.test10000Awithduration$tripduration)

predictions10000B = predict(model, citybike.test10000B)
write.csv(predictions10000B, file = "citybikeB10000.csv")
prediction.final <- read.csv("~/citybikeB10000.csv")
colnames(prediction.final) <- c("Id","Predicted")
write.csv(prediction.final,file="citybikeB10000.csv",row.names=FALSE)
