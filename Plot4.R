##read in table
data_table <- read.table("power_data.csv",header=TRUE,sep=";",na.strings="?",colClasses=c("character","character",rep("numeric",7)))

##convert date field to facilitate subsetting
data_table$Date<-as.Date(data_table$Date,"%d/%m/%Y")

##select two days
select_dates<-subset(data_table,Date=="2007-02-01"|Date=="2007-02-02")

##combine date and time fields
select_dates$new_time<- with(select_dates,paste(select_dates$Date,select_dates$Time,sep=" "))

library(lubridate)

##use lubridate package to convert combined date/time field to POSIXct
select_dates$new_time<-ymd_hms(select_dates$new_time)

png("plot4.png", width = 480, height = 480)

##set rows, columns
par(mfrow = c(2,2))
with(select_dates,{
##global active power plot
  plot(new_time,Global_active_power,type="l",ylab="Global Active Power (Kilowatts)",xlab="")
##voltage plot
  plot(select_dates$new_time,select_dates$Voltage,type="l",ylab="Voltage",xlab="datetime")
##sub metering plot
  plot(new_time,select_dates$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
  lines(select_dates$new_time,select_dates$Sub_metering_2,type="l",col="red")
  lines(select_dates$new_time,select_dates$Sub_metering_3,type="l",col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")
##global reactive power plot
  plot(Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.off()