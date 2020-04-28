filename <- "exdata_data_household_power_consumption.zip"
#Checks if a file called Courseproject.zip exists in the current working directory
if (!file.exists(filename)){
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, filename, method="curl")
}  
#extracts contents of the zip file
if (!file.exists("household_power_consumption.txt")) { 
  unzip(filename) 
}
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
dat<-subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")
dat$Date <- as.Date(dat$Date, format="%d/%m/%Y")
dat$Time <- strptime(dat$Time, format="%H:%M:%S")
dat[1:1440,"Time"] <- format(dat[1:1440,"Time"],"2007-02-01 %H:%M:%S")
dat[1441:2880,"Time"] <- format(dat[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

plot(dat$Time,dat$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(dat,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(dat,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(dat,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))