# Read the input file

inp = read.csv('household_power_consumption.txt',sep=';')
cols = colnames(inp)

for(col in cols)
{
        inp[,col][inp[,col]=='?'] = NA
}

inp$Date = as.Date(inp$Date,'%d/%m/%Y')

out = subset(inp,Date == as.Date('2007-02-01','%Y-%m-%d') | Date == as.Date('2007-02-02','%Y-%m-%d'))

out$fdate = paste(out$Date,out$Time,sep=',')

out$fdate = strptime((out$fdate),'%Y-%m-%d,%H:%M:%S')

out = out[order(out$fdate),]


out$Sub_metering_1 = as.numeric(as.character(out$Sub_metering_1))
out$Sub_metering_2 = as.numeric(as.character(out$Sub_metering_2))
out$Sub_metering_3 = as.numeric(as.character(out$Sub_metering_3))
out$Voltage = as.numeric(as.character(out$Voltage))
out$Global_active_power = as.numeric(as.character(out$Global_active_power))
out$Global_reactive_power = as.numeric(as.character(out$Global_reactive_power))

par(mfrow=c(2,2))

plot(out$fdate,out$Global_active_power,ylab='Global Active Power',xlab='',type='l')
plot(out$fdate,out$Voltage,ylab='Voltage',xlab='datetime',type='l')

plot(out$fdate,out$Sub_metering_1,type='l',ylab='Energy Sub Metering',xlab='')
points(out$fdate,out$Sub_metering_2,col='Red',type='l')
points(out$fdate,out$Sub_metering_3,col='Blue',type='l')
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))
plot(out$fdate,out$Global_reactive_power,ylab='Global_reactive_power',xlab='datetime',type='l')

dev.copy(png,'plot4.png')

dev.off()
