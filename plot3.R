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


plot(out$fdate,out$Sub_metering_1,type='l',ylab='Energy Sub Metering',xlab='')
points(out$fdate,out$Sub_metering_2,col='Red',type='l')
points(out$fdate,out$Sub_metering_3,col='Blue',type='l')


legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1))

dev.copy(png,'plot3.png')

dev.off()
