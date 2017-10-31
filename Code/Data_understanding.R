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

library(zoo)
zoo_data<- zoo(modified_data)
str(zoo_data)
frequency(zoo_data)
date_time<- modified_data$CREATED_DATE

