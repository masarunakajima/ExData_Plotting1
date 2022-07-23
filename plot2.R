library(lubridate)
library(dplyr)

#Read in the data
df<-read.table("household_power_consumption.txt", sep=";", header=TRUE)

#Replace ? with nan
df[df=="?"]<-NaN

#Change to appropriate data type
df$Date<-as.Date(df$Date, format="%d/%m/%Y")
df$Global_active_power<-as.numeric(df$Global_active_power)
df$Global_reactive_power<-as.numeric(df$Global_reactive_power)
df$Voltage<-as.numeric(df$Voltage)
df$Global_intensity<-as.numeric(df$Global_intensity)
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)




#Choose the time frame
start_date <- as.Date("2007-02-01")
end_date <- as.Date("2007-02-02")
data <- subset(df, Date >= start_date & Date <= end_date)

#Merge date and time
data <- data %>% mutate(DateTime = ymd_hms(paste(Date, Time)))

#Make histogram 
xlabel <- ""
ylabel <- "Global Active Power (kilowatts)"
png(file="plot2.png", width=480, height=480)
with(data, plot(DateTime, Global_active_power, type="l", xlab=xlabel, ylab=ylabel))
dev.off()
