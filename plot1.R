# Read the input file

inp = read.csv('household_power_consumption.txt',sep=';')
cols = colnames(inp)

for(col in cols)
{
	inp[,col][inp[,col]=='?'] = NA	
}

inp$Date = as.Date(inp$Date,'%d/%m/%Y')

out = subset(inp,Date == as.Date('2007-02-01','%Y-%m-%d') | Date == as.Date('2007-02-02','%Y-%m-%d'))

out$Global_active_power = as.numeric(as.character(out$Global_active_power))

hist(out$Global_active_power,main='Global Active Power',xlab='Global Active Power (kilowatts)',col='Red')

dev.copy(png,'plot1.png')

dev.off()

