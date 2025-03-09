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

bei_temp = filter(historic_temp, Station.Name == "BEIJING                                 ")
bei_1960 = subset(bei_temp, bei_temp$Year==1960)
bei_1960_mean = mean(bei_1960$AverageCelsiusTemperature)
bei_2000 = subset(bei_temp, bei_temp$Year==2001)
bei_2000_mean = mean(bei_2000$AverageCelsiusTemperature)

lind_temp = filter(historic_temp, Station.Name == "LINDENBERG                              ")
lind_1960 = subset(lind_temp, lind_temp$Year==1960)
lind_1960_mean = mean(lind_1960$AverageCelsiusTemperature)
lind_2000 = subset(lind_temp, lind_temp$Year==1995)
lind_2000_mean = mean(lind_2000$AverageCelsiusTemperature)

sd.bei_1960 = sd(bei_1960$AverageCelsiusTemperature)
sd.lind_1960 = sd(lind_1960$AverageCelsiusTemperature)

sd.bei_2000 = sd(bei_2000$AverageCelsiusTemperature)
sd.lind_2000 = sd(lind_2000$AverageCelsiusTemperature)

sd.bei.1960.2000 <- sqrt(sd.bei_1960^2/length(bei_temp) + sd.bei_2000^2/length(bei_temp))
sd.lind.1960.2000 <- sqrt(sd.lind_1960^2/length(lind_temp) + sd.lind_2000^2/length(lind_temp))

z.score.bei <-(bei_2000_mean-bei_1960_mean)/sd.bei.1960.2000 # 34.3992%
z.score.lind <-(lind_2000_mean-lind_1960_mean)/sd.lind.1960.2000 # 6.8281%

#plot(x=seq(from = -22, to= 22, by=0.1),y=dnorm(seq(from = -22, to= 22,  by=0.1),mean=0),type='l',xlab = 'mean difference',  ylab='possibility') 
#abline(v=z.score.lind, col='red')
p.lind<-1-pnorm(z.score.lind)
p.lind

p.bei<-1-pnorm(z.score.bei)
p.bei


