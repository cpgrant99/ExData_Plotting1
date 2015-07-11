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

png("plot3.png", width = 480, height = 480)
##construct sub metering plot
plot(select_dates$new_time,select_dates$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
##add additional graphs
lines(select_dates$new_time,select_dates$Sub_metering_2,type="l",col="red")
lines(select_dates$new_time,select_dates$Sub_metering_3,type="l",col="blue")
##add legend
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="o")
dev.off()
