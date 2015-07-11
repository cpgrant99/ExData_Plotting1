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

png("plot1.png", width = 480, height = 480)
##construct global active power historgram
hist(select_dates$Global_active_power,col="red", main="Global Active Power",xlab="Global Active Power (Kilowatts)")
dev.off()