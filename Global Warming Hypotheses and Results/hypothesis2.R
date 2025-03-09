convertDecDate <- function(decdate){
  year <- floor(decdate)
  decday <- decdate-year
  if(((year%%4)==0) & (year!=1900)){
    numdays=366
    months = c(31,60,91,121,152,182,213,244,274,305,335,366)
  } 
  else{
    numdays=365
    months = c(31,59,90,120,151,181,212,243,272,304,334,365)
  }
  day = decday*numdays + 0.5
  month=1
  while((month < 12) & (day>months[month])){
    month <- month+1
  }
  return(c(round(year,0),round(month,0),round(day,0)))
  #code used with data frames
  #> historic_temp$Year <- sapply(historic_temp$Date,FUN=convertDecDate)[1,]
  #> historic_temp$Month <- sapply(historic_temp$Date,FUN=convertDecDate)[2,]
}

historic_temp <- read.csv("C:\\Users\\arugo\\Desktop\\Data101\\assignment6\\historic_temp.csv")
historic_temp = na.omit(historic_temp)
historic_temp<-historic_temp[!(historic_temp$AverageCelsiusTemperature==-99999.0),]

historic_temp$Year <- sapply(historic_temp$Date,FUN=convertDecDate)[1,]
historic_temp$Month <- sapply(historic_temp$Date,FUN=convertDecDate)[2,]

alert_temp = filter(historic_temp, Station.Name == "ALERT, NT                               ")
alert_1960 = subset(alert_temp, alert_temp$Year==1960)
alert_1960_mean = mean(alert_1960$AverageCelsiusTemperature)
alert_2000 = subset(alert_temp, alert_temp$Year==2000)
alert_2000_mean = mean(alert_2000$AverageCelsiusTemperature)

bethel_temp = filter(historic_temp, Station.Name == "BETHEL BETHEL, AK                       ")
bethel_1960 = subset(bethel_temp, bethel_temp$Year==1960)
bethel_1960_mean = mean(bethel_1960$AverageCelsiusTemperature)
bethel_2000 = subset(bethel_temp, bethel_temp$Year==2000)
bethel_2000_mean = mean(bethel_2000$AverageCelsiusTemperature)

sd.alert_1960 = sd(alert_1960$AverageCelsiusTemperature)
sd.bethel_1960 = sd(bethel_1960$AverageCelsiusTemperature)

sd.alert_2000 = sd(alert_2000$AverageCelsiusTemperature)
sd.bethel_2000 = sd(bethel_2000$AverageCelsiusTemperature)

sd.alert.1960.2000 <- sqrt(sd.alert_1960^2/length(alert_temp) + sd.alert_2000^2/length(alert_temp))
sd.bethel.1960.2000 <- sqrt(sd.bethel_1960^2/length(bethel_temp) + sd.bethel_2000^2/length(bethel_temp))

z.score.alert <-(alert_2000_mean-alert_1960_mean)/sd.alert.1960.2000 # 34.3992%
z.score.bethel <-(bethel_2000_mean-bethel_1960_mean)/sd.bethel.1960.2000 # 6.8281%

#plot(x=seq(from = -22, to= 22, by=0.1),y=dnorm(seq(from = -22, to= 22,  by=0.1),mean=0),type='l',xlab = 'mean difference',  ylab='possibility') 
#abline(v=z.score.bethel, col='red')
p.bethel<-1-pnorm(z.score.bethel)
p.bethel

p.alert<-1-pnorm(z.score.alert)
p.alert


