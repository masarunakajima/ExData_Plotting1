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


png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))
xlabel <- ""
ylabel <- "Global Active Power"
with(data, plot(DateTime, Global_active_power, type="l", col="black", xlab=xlabel,
                ylab=ylabel))

xlabel <- "datetime"
ylabel <- "Voltage"
with(data, plot(DateTime, Voltage, type="l", col="black", xlab=xlabel,
                ylab=ylabel))

xlabel <- ""
ylabel <- "Energy sub metering"
with(data, plot(DateTime, Sub_metering_1, type="l", col="black", xlab=xlabel,
                ylab=ylabel))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend(x="topright",legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       col=c("black","red","blue"), lty=c(1,1,1), bty = "n")

xlabel <- "datetime"
ylabel <- "Global_reactive_power"
with(data, plot(DateTime, Global_reactive_power, type="l", col="black", xlab=xlabel,
                ylab=ylabel))

dev.off()

