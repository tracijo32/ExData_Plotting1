library(dplyr)
library(lubridate)

## read in the data
df = read.delim("household_power_consumption.txt",header=TRUE,sep=';',na.strings='?')

## Transform the dates and times into POSIX class, combine to one column DateTime
df = transform(df,Date=dmy(Date))

## select only the days of interest
start_date = ymd('2007-02-01')
end_date = ymd('2007-02-02')
df_day = df[df$Date == start_date | df$Date == end_date,]

## create full timestamp
df_day = mutate(df_day,DateTime=ymd_hms(paste(Date,Time)))

## create fourth plot
png("plot4.png")
par(mfrow=c(2,2))

## subplot 1, same as plot 2
with(df_day,plot(DateTime,Global_active_power,type='l',
                 xlab="",ylab='Global Active Power (kilowatts)'))

## subplot2
with(df_day,plot(DateTime,Voltage,type='l',xlab='datetime'))

## subplot 3, same as plot 3
with(df_day,plot(DateTime,Sub_metering_1,type='l',
                 xlab='',ylab='Energy sub metering'))
with(df_day,lines(DateTime,Sub_metering_2,type='l',col='red'))
with(df_day,lines(DateTime,Sub_metering_3,type='l',col='blue'))
legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"))

## subplot 4
with(df_day,plot(DateTime,Global_reactive_power,type='l'),xlabel='datetime')
dev.off()
