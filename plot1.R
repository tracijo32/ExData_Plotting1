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

## make the first plot
png("plot1.png")
hist(df_day$Global_active_power,main='Global Active Power',
    xlab="Global Active Power (kilowatts)",
    ylab="Frequency",col='red')
dev.off()