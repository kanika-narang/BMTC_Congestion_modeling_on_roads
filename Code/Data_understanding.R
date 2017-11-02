data<- read.csv('/home/kanika/Documents/3rd_Sem/github/Congestion BMTC/bmtc/DATA/device_id_150813052_modified_only_important.csv')
modified_data<- read.csv('/home/kanika/Documents/3rd_Sem/github/Congestion BMTC/bmtc/DATA/device_id_150813052_modified_only_important.csv')

# convert to date-time
modified_data$CREATED_DATE <- paste(modified_data$CREATED_DATE, modified_data$CREATED_TIME, sep=" ")
modified_data<- modified_data[,-2]
date<-as.POSIXct(modified_data$CREATED_DATE, format="%Y-%m-%d %H:%M:%S")
modified_data$CREATED_DATE<- date

# sort based on Creater_date
modified_data<-modified_data[ order(modified_data$CREATED_DATE , decreasing = FALSE ),]

time_series_data<- ts(modified_data)





library(astsa)
#calculating mean
mean<- mean(modified_data$SPPED_KMPH)
# plotint the time series
par(mfrow=c(1,1))
tsplot(modified_data[,c(1,7)],main="time_series Plot",ylab="Speed KMPH")
abline(h = mean,lty=2,col="red")

par(mfrow=c(2,1))
# calculating ACF
acf(modified_data[,c(1,7)],1000,main="Autocorrelation")

#The Ljung-Box test examines whether there is 
#significant evidence for non-zero correlations at lags 1-20. 
#Small p-values (i.e., less than 0.05) suggest that the series
#is stationary.
Box.test(modified_data[,7],lag=20,type="Ljung-Box")

#The Augmented Dickey–Fuller (ADF) t-statistic test: 
#small p-values suggest the data is stationary 
#and doesn’t need to be differenced stationarity.
adf.test(modified_data[,7],alternative="stationary")

#The Kwiatkowski-Phillips-Schmidt-Shin (KPSS) test; 
#here accepting the null hypothesis means that the series 
#is stationarity, and small p-values suggest that the series
#is not stationary and a differencing is required.
kpss.test(modified_data[,7])

# plotting PACF
pacf(modified_data[,c(1,7)],1000,main="Autocorrelation")