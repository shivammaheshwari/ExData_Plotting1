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

out$Global_active_power = as.numeric(as.character(out$Global_active_power))

plot(out$fdate,out$Global_active_power,ylab='Global Active Power (kilowatts)',xlab='',type='l')

dev.copy(png,'plot2.png')

dev.off()
