
library(lubridate)
library(dplyr)
library(tidyr)
library(rgdal)
library(sp)
library(ggplot2)

# Read in data
raw_det <- read.csv("D:/Documents/Lowe/OCSD/Data/OCSD-export.csv")
  # Includes detections from PVS that I don't have coordinates for

receiver_locs <- read.csv("D:/Documents/Lowe/OCSD/Data/OCSDReceiverLog_Export-20181004.csv")
  # receiver locations for stations beginning with 'OA'

vps_data <- read.csv("D:/Documents/Lowe/OCSD/Pubs/SETAC/Vermillions/vps-data/all_VR.csv")
  # VPS data that has been filtered for 15 HPE or less (minimize positional error - this file is used
  # for the CEM results)

vps_data <- vps_data[!duplicated(vps_data),]

#tag_names <- read.csv("D:/Documents/Lowe/OCSD/Pubs/SETAC/Barrett's_data/tag-names.csv")

# Alter data

receiver_locs <- aggregate(cbind(Lat, Lng) ~ Station, data = receiver_locs, FUN = mean)
colnames(receiver_locs) <- c("Station.Name", "Lat", "Lng")

# Raw data
OA_only <- raw_det[which(raw_det$Transmitter %in% vps_data$DETECTEDID), ]
OA_only <- merge(OA_only, receiver_locs)
OA_only$Latitude <- OA_only$Lat
OA_only$Longitude <- OA_only$Lng
OA_only <- OA_only[,c(1:10)]

colnames(OA_only)[09:10] <- c('Receiver_Lat', 'Receiver_Lng')
OA_only$DateTime<- as.POSIXct(OA_only$ï..Date.and.Time..UTC., tz='UTC')
OA_only <- OA_only[,c("Station.Name", "DateTime", "Receiver", "Transmitter", "Receiver_Lat", "Receiver_Lng")]

# VPS data
#tag_names$Transmitter <- paste0(tag_names$Channel, '-', tag_names$Coding.ID, '-', tag_names$ID)
#tag_names <- tag_names[,c('Name', 'Transmitter')]
#colnames(tag_names) <- c('TAG', 'Transmitter')
#vps_data <- merge(vps_data, tag_names)
vps_data$DateTime <- as.POSIXct(vps_data$DATETIME, tz='UTC')
vps_data <- vps_data[,c("DateTime", "DETECTEDID", "X", "Y", "LAT", "LON", "D", "HPE")]
colnames(vps_data) <- c("DateTime", "Transmitter", "X", "Y", "LAT", "LON", "D", "HPE")

# 5 minute bins
#OA_only$fivemin <- floor_date(OA_only$DateTime, "5 minutes")
#vps_data$fivemin <- floor_date(vps_data$DateTime, "5 minutes")
#OA_only$tenmin <- floor_date(OA_only$DateTime, "10 minutes")
#vps_data$tenmin <- floor_date(vps_data$DateTime, "10 minutes")
OA_only$fifteenmin <- floor_date(OA_only$DateTime, "15 minutes")
vps_data$fifteenmin <- floor_date(vps_data$DateTime, "15 minutes")

# Middle of array
shape <- readOGR("D:/Documents/Lowe/OCSD/Pubs/SETAC/Vermillions/inner_receivers.shp")
shape <- spTransform(shape, "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

OA_locs<-NULL # set this to null 
OA_locs<-structure(list(longitude=OA_only$Receiver_Lng, latitude=OA_only$Receiver_Lat), .Names=c("Longitude", "Latitude"), class="data.frame", row.names = c(NA, -nrow(OA_only)))
  # create a structured data frame for lat and longitude
xy<-OA_locs[,c(1:2)] # subset this so you only have the coordinates

coordinates(xy)<-cbind(xy$Longitude, xy$Latitude) # assign the lat and long as coordinates
proj4string(xy)<- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") # transform this to longlat format

OA_middle<-over(xy, shape) # which coordinates are overlapping the tox shapefile? 
OA_only$Region <- OA_middle$Name

vps_locs<-NULL # set this to null 
vps_locs<-structure(list(longitude=vps_data$LON, latitude=vps_data$LAT), .Names=c("Longitude", "Latitude"), class="data.frame", row.names = c(NA, -nrow(vps_data)))
  # create a structured data frame for lat and longitude
xy<-vps_locs[,c(1:2)] # subset this so you only have the coordinates

coordinates(xy)<-cbind(xy$Longitude, xy$Latitude) # assign the lat and long as coordinates
proj4string(xy)<- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") # transform this to longlat format

vps_middle<-over(xy, shape) # which coordinates are overlapping the tox shapefile? 
vps_data$Region <- vps_middle$Name

# Only keep data in the middle of the array
OA_middle <- OA_only[which(OA_only$Region == 'inner'),]
vps_middle <- vps_data[which(vps_data$Region == 'inner'),]

# Count
OA_counts15 <-  as.data.frame(OA_middle %>%  count(Transmitter, fifteenmin))
colnames(OA_counts15)[3]<- 'raw_counts'
vps_counts15 <- as.data.frame(vps_middle %>% count(Transmitter, fifteenmin))
colnames(vps_counts15)[3] <- 'vps_counts'

all_15 <- merge(OA_counts15, vps_counts15, all=TRUE)
all_15 <- replace_na(all_15, list(raw_counts = 0, vps_counts = 0))

#OA_counts10 <-  as.data.frame(OA_middle %>%  count(Transmitter, tenmin))
#colnames(OA_counts10)[3]<- 'raw_counts'
#vps_counts10 <- as.data.frame(vps_middle %>% count(Transmitter, tenmin))
#colnames(vps_counts10)[3] <- 'vps_counts'
#
#all_10 <- merge(OA_counts10, vps_counts10, all=TRUE)
#all_10 <- replace_na(all_10, list(raw_counts = 0, vps_counts = 0))
#
#OA_counts5 <-  as.data.frame(OA_middle %>%  count(Transmitter, fivemin))
#colnames(OA_counts5)[3]<- 'raw_counts'
#vps_counts5 <- as.data.frame(vps_middle %>% count(Transmitter, fivemin))
#colnames(vps_counts5)[3] <- 'vps_counts'
#
#all_5 <- merge(OA_counts5, vps_counts5, all=TRUE)
#all_5 <- replace_na(all_5, list(raw_counts = 0, vps_counts = 0))

ggplot(all_15, aes(raw_counts, vps_counts, colour = Transmitter)) +
  geom_jitter() + theme(legend.position="none") + xlab("Count of Raw Detections") +
  ylab("Count of VPS Positions") + ggtitle("15 Minute Bins - VR")

nrow(all_15[which(all_15$raw_counts > 0 & all_15$vps_counts == 0),])/nrow(all_15)
  # 0.866 for rockies

# Ok so let's use the COA for each 15 minute interval for the raw detection data. 
OA_coas_15 <- aggregate(cbind(Receiver_Lat, Receiver_Lng) ~ Transmitter + fifteenmin, data = OA_middle, FUN = mean)
#OA_coas_10 <- aggregate(cbind(Receiver_Lat, Receiver_Lng) ~ Transmitter + tenmin, data = OA_middle, FUN = mean)
#OA_coas_5 <- aggregate(cbind(Receiver_Lat, Receiver_Lng) ~ Transmitter + fivemin, data = OA_middle, FUN = mean)

vps_NAs <- as.data.frame(all_15[which(all_15$vps_counts == 0), c("Transmitter", "fifteenmin")])
vps_NA <- merge(vps_NAs, OA_coas_15, all.x=TRUE, all.y=FALSE)

#vps_NAs <- as.data.frame(all_10[which(all_10$vps_counts == 0), c("Transmitter", "tenmin")])
#vps_NA <- merge(vps_NAs, OA_coas_10, all.x=TRUE, all.y=FALSE)

#vps_NAs <- as.data.frame(all_5[which(all_5$vps_counts == 0), c("Transmitter", "fivemin")])
#vps_NA <- merge(vps_NAs, OA_coas_5, all.x=TRUE, all.y=FALSE)

vps_NA$DateTime <- NA
vps_NA$X <- NA
vps_NA$Y <- NA
vps_NA$LAT<- vps_NA$Receiver_Lat
vps_NA$LON <- vps_NA$Receiver_Lng
vps_NA$D <- NA
vps_NA$HPE <- NA
#vps_NA$fivemin <- NA
#vps_NA$tenmin <- NA
#vps_NA$fifteenmin<-NA
vps_NA$Region <- NA
vps_NA <- vps_NA[,colnames(vps_data)]

vps_edited <- rbind(vps_data, vps_NA)

OA_counts <-  as.data.frame(OA_middle %>%  count(Transmitter, fifteenmin))
colnames(OA_counts)[3]<- 'raw_counts'
vps_counts <- as.data.frame(vps_edited %>% count(Transmitter, fifteenmin))
colnames(vps_counts)[3] <- 'vps_counts'

all <- merge(OA_counts, vps_counts, all=TRUE)
all <- replace_na(all, list(raw_counts = 0, vps_counts = 0))

ggplot(all, aes(raw_counts, vps_counts, colour = Transmitter)) +
  geom_jitter() + theme(legend.position="none") + xlab("Count of Raw Detections") +
  ylab("Count of VPS Positions") + ggtitle("15 Minute Bins - VR") + ylim(0, max(all$vps_counts))


# time differences
minmax<-NULL
for( fish in unique(vps_middle$Transmitter)) { 
  temp <- vps_data[which(vps_middle$Transmitter == fish),]
  times<- NULL
  for (row in 2:nrow(temp)-1){ 
    times_temp <- as.data.frame(as.numeric(difftime(temp$DateTime[row], temp$DateTime[row-1], units="mins")))
    times <- rbind(times, times_temp)
  }
  colnames(times) <- 'times'
  temp_row <- data.frame(cbind(min(times$times, na.rm=TRUE), max(times$times, na.rm=TRUE), mean(times$times, na.rm=TRUE), length(times[which(times$times > 60*2),])/nrow(times)))
  minmax<- rbind(minmax, temp_row)
}
colnames(minmax) <- c('min', 'max', 'mean', '2hrsplus')

median(minmax$`2hrsplus`, na.rm=TRUE)*100
