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
hist(as.numeric(as.character(dat$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
dev.copy(png,file="plot1.png")
dev.off()