## Include Libraries
library(dplyr)
library(tidyr)
library(data.table)
library(ggplot2)
library(lubridate)
library(lattice)

## Data set URL link and data set file name
urlLink <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName <- "household_power_consumption.txt"

## Download and extract zip file from link
if(!file.exists("DataSet.zip"))
{
  download.file(urlLink,"DataSet.zip")
}else if(!file.exists(fileName))
{
  unzip("DataSet.zip")
}

## Read files into Data variable Electric_Consumption_Data
# memory required = no. of column * no. of rows * 8 bytes/numeric
# memory required = 149,418,648 bytes
Electric_Consumption_Data <- fread(fileName, na.strings = "?")
print(object.size(Electric_Consumption_Data)) 
# actual memory used = 150,051,336 bytes
# Approximately 150MB

## Convert Date column from Character to Date class
Electric_Consumption_Data$Date<- dmy(Electric_Consumption_Data$Date)
## Select rows between 2007-02-01 and 2007-02-02
Electric_Consumption_Data <- filter(Electric_Consumption_Data, Date == dmy("1/2/2007") | Date == dmy("2/2/2007")) 
Electric_Consumption_Data$Date <- ymd_hms(paste(Electric_Consumption_Data$Date,Electric_Consumption_Data$Time))

# Energy Sub metering 1
with(Electric_Consumption_Data,
       plot(Sub_metering_1~Date
       , ylab = "Energy sub metering" 
       , xlab = ""
       , type = "l"
       , col = "black"
  )
)

# Energy Sub metering 2
with(Electric_Consumption_Data,
 lines(Sub_metering_2~Date
       , col = "red")    
)

# Energy Sub metering 3
with(Electric_Consumption_Data,
     lines(Sub_metering_3~Date
           , col = "blue")    
)

# Legend
legend("topright"
       ,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col = c("black","red","blue")
       , lt=1,cex = 0.8
)


## Plot 3 with PNG as graphics device
dev.copy(png,"Plot3.png")
dev.off()



