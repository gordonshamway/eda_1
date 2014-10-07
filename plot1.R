
#Downloading and unzipping the file
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,dest="hpc.zip")
unzip("hpc.zip", overwrite=TRUE)

#reading in the file
library(lubridate)
columns <- c("character", "character", "numeric", "numeric", "numeric","numeric", "numeric", "numeric", "numeric")

hpc <- read.table(file =  "household_power_consumption.txt",
           sep = ";",
           na.strings = "?",
           colClasses = columns,
           header = TRUE,)

#convert Date and Time
hpc$DateTime <- strptime(paste(hpc$Date, hpc$Time), format="%d/%m/%Y %H:%M:%S")
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")

#subset on 2007-02-01 and 2007-02-02
fhpc <- subset(hpc, Date %in% c(as.Date("2007-02-01", format="%Y-%m-%d"), as.Date("2007-02-02", format="%Y-%m-%d")))

#making the plot1
#######################

#open the device
png(filename = "plot1.png",
    width = 480,
    height = 480)

#creating the plot
hist(fhpc$Global_active_power, 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     main = "Global Active Power",
     col = "red")

#close and save the device (PNG)
dev.off()