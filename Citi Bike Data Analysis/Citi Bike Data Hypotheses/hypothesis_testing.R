citibike.May20.50K.csv = read.csv("C:\\Users\\arugo\\Desktop\\CS111\\assignment5\\citibike.May20.50K.csv")
citibike.May21.50K.csv = read.csv("C:\\Users\\arugo\\Desktop\\CS111\\assignment5\\citibike.May21.50K.csv")

citi20 = citibike.May20.50K.csv
citi21 = citibike.May21.50K.csv

View(citi20)
View(citi21)


table.2020 = c(table(citi20$usertype))
customers.2020 = table.2020[1]
subscribers.2020 = table.2020[2]

table.2021 = c(table(citi21$member_casual))
customers.2021 = table.2021[1]
subscribers.2021 = table.2021[2]

# rm(table.2020)
# rm(table.2021)

num.citi20 = length(citi20$usertype)
num.citi21 = length(citi21$member_casual)

mean.citi20 = (subscribers.2020)
mean.citi21 = (subscribers.2021)
# average number of subscribers

#convert strings to numbers, where 1 means customer and 2 means subscriber
citi20$usertype = replace(citi20$usertype[50000], "Customer" , 1)
citi20$usertype = replace(citi20$usertype[50000], "Subscriber" , 2)


citi21$member_casual = replace(citi21$member_casual[50000], "Customer" , 1)
citi21$member_casual = replace(citi21$member_casual[50000], "Subscriber" , 2)

sd.citi2020 = sd(as.numeric(unlist(citi20$usertype)))
sd.citi2021 = sd(as.numeric(unlist(citi21$member_casual)))

sd.2020.2021 <- sqrt(sd.citi2020^2/num.citi20 + sd.citi2021^2/num.citi21)
z.score <-(mean.citi20-mean.citi21)/sd.2020.2021

plot(x=seq(from = -22, to= 22, by=0.1),y=dnorm(seq(from = -22, to= 22,  by=0.1),mean=0),type='l',xlab = 'mean difference',  ylab='possibility') 
abline(v=z.score, col='red')
p<-1-pnorm(z.score)
p
