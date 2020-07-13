#Install + load ggplot2, readr

#Access .csv via github.
urlfile = "https://raw.githubusercontent.com/AKirol/CARMI/master/Carmi_Buoy_PFL_Step_7-6-20.csv"
carmidata <- read.csv(url(urlfile))

names(carmidata)[1] <- "Date"
names(carmidata)[6] <- "Temp"
names(carmidata)[16] <- "DO"
names(carmidata)[18] <- "Chl"
names(carmidata)[20] <- "PC"
names(carmidata)[21] <- "Depth"

#Remove rows without data.
carmidata <- subset(carmidata, DO !="sensorParms(11)" & DO !="212" & DO !="ODO mg/L" & DO !="Smp")

#Format date column
carmidata$Date <- strptime(carmidata$Date, "%m/%d/%Y %H:%M")
carmidata$Date<- as.POSIXct(carmidata$Date)

#Format Depth, DO, PC to numeric
carmidata$DO <- as.numeric(carmidata$DO)
carmidata$Depth <- as.numeric(carmidata$Depth)
carmidata$Chl <- as.numeric(carmidata$Chl)
carmidata$PC <- as.numeric(carmidata$PC)
carmidata$Temp <- as.numeric(carmidata$Temp)

#Create new dataset with Date, Temp, DO, Depth columns.
CarmiDO <- carmidata[,c(1,6,16,21)]


#Subset surface and bottom DO measurements
DOPlot <- subset(CarmiDO,Depth>8.3 | Depth<0.8)
DOPlot$State <- ifelse(DOPlot$Depth<5, "A", "Z")


#GGPlot Setup (DO)
DO <- ggplot(DOPlot, aes(x=Date,y=DO)) + geom_line(aes(col=State)) + labs(title="Lake Carmi Dissolved Oxygen", y="DO (mg/L)", x="Date") + scale_y_continuous(breaks=seq(0,14,2), expand = c(0, 0), limits = c(0, 12)) + theme(legend.title=element_blank(), legend.position="bottom") + scale_color_manual(labels = c("UVM Buoy Site Surface (0.5 meter depth", "UVM Buoy Site Bottom (8.5 meter depth)"), values=(c("A"="blue", "Z"="red")))
DO

#GGPlot Setup (Temp)
CTemp <- ggplot(DOPlot, aes(x=Date,y=Temp)) + geom_line(aes(col=State)) + labs(title="Lake Carmi Temperature", y=expression("Temperature " ( degree~C)), x="Date") + scale_y_continuous(breaks=seq(0,40,2)) + theme(legend.title=element_blank(), legend.position="bottom") + scale_color_manual(labels = c("UVM Buoy Site Surface (0.5 meter depth", "UVM Buoy Site Bottom (8.5 meter depth)"), values=(c("A"="blue", "Z"="red")))
CTemp

#Create new dataset with Date, BGA PC, Depth columns. Rename columns.
CarmiPC<-carmidata[,c(1,18,20,21)]

#Subset surface BGA PC measurements
PCPlot <- subset(CarmiPC,Depth<0.8)

#GGPlot Setup (PC)
PC <- ggplot(PCPlot, aes(x=Date,y=PC)) + geom_line(colour="blue") + labs(title="Lake Carmi BGA-PC", y="PC (RFU)", x="Date") + scale_y_continuous(breaks=seq(0,2.0,0.5), limits = c(0, 2.0))
PC

#GGPlot Setup (PC)
Chl <- ggplot(PCPlot, aes(x=Date,y=Chl)) + geom_line(colour="blue") + labs(title="Lake Carmi Chlorophyll", y="Chl (RFU)", x="Date") + scale_y_continuous(breaks=seq(0,4.0,1), limits = c(0, 4.0))
Chl