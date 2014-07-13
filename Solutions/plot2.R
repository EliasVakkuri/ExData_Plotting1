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

# Plot data

png(file = "plot2.png")

par(mfrow = c(1,1))

Sys.setlocale(category = "LC_TIME", locale = "C")

plot(y = data$Global_active_power, 
     x = data$DateTime, 
     type = "n", 
     ylab = "Global Active Power (kilowatts)",
     xlab = "")

lines(y = data$Global_active_power, 
      x = data$DateTime, 
      type = "l")

dev.off()