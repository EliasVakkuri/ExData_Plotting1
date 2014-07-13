# Read data

colCls <- rep("character",9)

data <- read.table(file = "./household_power_consumption.txt", 
                   colClasses = colCls,
                   header = TRUE,
                   comment.char = "",
                   sep = ";")

# We will only be using data from the dates 2007-02-01 and 2007-02-02
data <- data[data$Date == "2/2/2007" | data$Date == "1/2/2007",]

data <- as.data.frame(lapply(data, function(x){replace(x,x == "?", NA)}))

data[,3:9] <- as.data.frame(lapply(data[,3:9], 
                                   function(x){as.numeric(as.character(x))}))

data$DateTime <- paste(data$Date, data$Time, " ")

data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Produce plot

png("plot4.png")

par(mfcol= c(2,2))

Sys.setlocale(category = "LC_TIME", locale = "C")

# Row 1, col 1

plot(y = data$Global_active_power, 
     x = data$DateTime, 
     type = "n", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

lines(y = data$Global_active_power, 
      x = data$DateTime, 
      type = "l")

# Row 2, col 1

plot(x = data$DateTime, 
     y = data$Sub_metering_1, 
     type = "n",
     ylab = "Energy sub metering",
     xlab = "")

points(data$DateTime, 
       data$Sub_metering_1, 
       type = "l")

points(data$DateTime, 
       data$Sub_metering_2, 
       type = "l",
       col = "red")

points(data$DateTime, 
       data$Sub_metering_3, 
       type = "l",
       col = "blue")

legend ("topright", 
        legend = c("Sub_metering_1",
                   "Sub_metering_2",
                   "Sub_metering_3"),
        lty = "solid",
        col = c("black", "red", "blue"),
        bty = "n")

# Row 1, col 2

plot (x = data$DateTime, 
      y = data$Voltage,
      type = "l",
      xlab = "datetime",
      ylab = "Voltage")

# Row 2, col 2

plot (x = data$DateTime, 
      y = data$Global_reactive_power,
      type = "l",
      xlab = "datetime",
      ylab = "Global_reactive_power")

dev.off()
