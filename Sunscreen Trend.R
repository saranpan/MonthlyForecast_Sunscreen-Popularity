#Setup

library(forecast);
library(tseries);
library(glue);

setwd("C:/Users/Wallik/Desktop/Sunscreen Trend project")

df <- read.csv('Sunscreen.csv',
               header=TRUE)

# Size
nrow(df) # = 156 # 13 years
ncol(df) # = 2

attach(df)

#start=c(2019,1,13); end=c(2021,12,5)

df.ts = ts(Sunscreen..Thailand. , 
           start=c(2009,1),freq=12)

summary(df.ts)


plot(df.ts,main ='Monthly searches "Sunscreen" (2009-2021) ',
     xlab="Year",ylab="Popularity",) 

# yearly mean report
plot(aggregate(df.ts,FUN='mean'),main ='Annual mean of searches "Sunscreen" (2009-2021) ',
     xlab="Year",ylab="Popularity",)

# No seasonality detected (at the July seems to have less)
boxplot(df.ts ~ cycle(df.ts),main ='Popularity of each month',
        xlab="Month",ylab="Popularity",)

# time series
layout(1:3)
df0913=window(df.ts, start=c(2009,1), end=c(2013,12))
df1418=window(df.ts, start=c(2014,1), end=c(2018,12))
df1822=window(df.ts, start=c(2018,1), end=c(2022,12))
plot(df0913,main="Time series of each time periods")
plot(df1418)
plot(df1822)

# Boxplot
layout(1:3)
boxplot(df0913~cycle(df0913),main="2009-2013",ylim = c(0, 100))
boxplot(df1418~cycle(df1418),main="2014-2018",ylim = c(0, 100))
boxplot(df1822~cycle(df1822),main="2018-2022",ylim = c(0, 100))

#                    #                       #
layout(1:2)
Acf(df.ts,main='ACF',lag.max=156/4)
Pacf(df.ts,main='PACF',lag.max=156/4)


# Try A. Dickey Fuller
adf.test(df.ts,k = 6)
adf.test(df.ts,k = 5)
adf.test(df.ts,k = 4) #high p values = not stationary
adf.test(df.ts,k = 3)


# ? Augmented Dickey Fuller suggest that the 2nd order is more likely to be more stationary than 1st order
adf.test(diff(df.ts,differences = 1))
adf.test(diff(df.ts,differences = 2))

# 1st & 2nd differencing
layout(1:2)
plot(diff(df.ts,differences = 1),main='1st order differencing')
abline(h=0,lty = 2,col='red')
plot(diff(df.ts,differences = 2),main='2nd order differencing')
abline(h=0,lty = 2,col='red')
# 1st order is enough
df.ts.diff = diff(df.ts,differences = 1)
layout(1:2)
Acf(df.ts.diff,main='[1st diff] ACF',lag.max=156/4)
Pacf(df.ts.diff,main='[1st diff] PACF',lag.max=156/4)

# SARIMA

#auto.arima(df.ts,stationary = FALSE,seasonal=TRUE,ic = 'aic',stepwise = FALSE, trace=TRUE,
#           approximation = FALSE)

SARIMA.012.011.12 = Arima(df.ts, order = c(0,1,2),
                       seas = list(order = c(0,1,1), 12))

summary(SARIMA.012.011.12)

# Calculate CI 95% by +- SE

#     #     #

# Diagnose
model <- SARIMA.012.011.12

tsdiag(model)
checkresiduals(model)

layout(1)
plot(model$residuals,main='Residual plot by SARIMA(0,1,2)(2,1,0)(12)')
abline(h=0,lty = 2,col='red')

# histogram
hist(model$residuals)

Acf(model$residuals,lag.max = 156/4,main='ACF plot of residual')

# Forecast the next 6 months in 2022
predict(model,n.ahead = 6)


# Rolling back to how the model is fitted in the past
plot(df.ts,main='Fitted SARIMA(0,1,2)(0,1,1)(12)')
lines(fitted(model),col ='green',lwd=2)
legend(2010, 90, legend=c("Actual", "Prediction"),
       col=c("black", "green"), lty=1:1, lwd=1:2,cex=0.8)


forc = forecast(model , h = 6)
plot(forc, main='Forecast in next 6 months by SARIMA(0,1,2)(0,1,1)(12)')
forc
# The dark area : 80% , light area : 95%


