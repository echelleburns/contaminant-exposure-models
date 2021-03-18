# Now let's get me a contaminant exposure model for my tracks. 
# I have minute-by-minute data, right? So let's do it this way... for each location we have, what is the sediment
# tox level? How many minutes is the fish in that tox level? 
# Treat times in which the fish is not actually detected in the field as NAs or as non-detectable levels. 

library(reshape)
library(rgdal)

ddt<-readOGR("data/shapefiles/total_ddt_ocsd.shp")
pcb<-readOGR("data/shapefiles/total_pcb_ocsd.shp")
tox.list<-list(pcb, ddt)
names(tox.list)<-c("pcb","ddt")

list<-list.files("data/behaviors/", pattern="HT")

for (g in list) { 
  all.dat<-read.csv(paste0("data/behaviors/",g))
  for( h in 1:length(tox.list) ){
    tox.dat<-NULL
    for( i in unique(all.dat$ID)) { # for each file in the list of true data...
      dat<-all.dat[which(all.dat$ID == i),]
      id<-dat$ID[1] # save that tag id for saving

      #  The data were generated in XY coordinates, we need them in latlng to match the tox shapefiles...
      temp<-NULL # set this to null 
      temp<-structure(list(longitude=dat$x, latitude=dat$y), .Names=c("Longitude", "Latitude"), class="data.frame", row.names = c(NA, -nrow(dat)))
        # create a structured data frame for lat and longitude
      xy<-temp[,c(1:2)] # subset this so you only have the coordinates
  
      coordinates(xy)<-cbind(xy$Longitude, xy$Latitude) # assign the lat and long as coordinates
      proj4string(xy)<- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") # transform this to longlat format
      relevant<-as.data.frame(cbind(coordinates(xy), paste(dat$DATETIME))) # we want to save the latlongs and the
      # datetime for later
      colnames(relevant)[3]<-"DATETIME"
      relevant$DATETIME<-as.POSIXct(relevant$DATETIME, tz="UTC")
  
      tab<-NULL # this is going to be the main frequency table for each contaminant for that fish
  
      assign('tox', tox.list[[h]])
  
      overlap<-over(xy, tox) # which coordinates are overlapping the tox shapefile?
      overlap$meanval<-(overlap$Value_Max+overlap$Value_Min)/2
  
      dat$tox<-overlap$meanval
      dat$tox[is.na(dat$tox)]<-0
      tox.dat<-rbind(tox.dat, dat)
    } 

  name<-colsplit(g, "[.]", c("",""))[,1]
  write.csv(tox.dat, paste0("data/CEMs/raw_", name, "_CEM_", names(tox.list)[h], ".csv"), row.names=F)
    # save the csv in the CEM folder
  }
} 

  
list<-list.files('data/CEMs', pattern='raw_HT')

for( h in list) { 
  name <- colsplit(h, "[.]", c("",""))[,1]
  name <- colsplit(name, "raw", c(""))[,2]
  
  dat<-read.csv(paste0("data/CEMs/", h))

  scaling<-as.data.frame(c("directional_movement","nondirectional_movement","not-moving"))
  colnames(scaling)<-"state"
  scaling$scaler<-c(0, 0.5, 1)

  this_contam<-colsplit(h, "_", c('','','','',''))[,5]
  this_contam<-colsplit(this_contam, '[.]', c('',''))[,1]
  this_contam<-toupper(paste(this_contam))

  new_name<-colsplit(h, '[.]', c('',''))[,1]

  totals<-NULL

  dat$DATETIME<-as.POSIXct(dat$DATETIME)
  for( i in unique(dat$ID)) { 
    temp<-dat[which(dat$ID == i),]
    temp$date<-as.Date(temp$DATETIME)
    timediff<-as.numeric(max(temp$date, na.rm=T)-min(temp$date, na.rm=T))/365
  
    temp<-merge(temp, scaling, "state")
    temp$level<-temp$tox*temp$scaler
    sum1<-sum(temp$tox)
    sum2<-sum(temp$level)
    if(timediff >= 1) {
    scaled_year<-sum(temp$tox)/timediff
    scaled_moveyear<-sum(temp$level)/timediff
    } else {
    scaled_year <- sum1
    scaled_moveyear <- sum2
    }
  
    totals.temp<-cbind(paste(temp$ID[1]), paste(sum1), paste(sum2), paste(scaled_year), paste(scaled_moveyear))
    totals<-rbind(totals, totals.temp)
  }

  totals<-as.data.frame(totals)
  colnames(totals)<-c("ID", "total_tox", "total_behavioral_tox", "tox_peryear_noscaler", "tox_peryear_scaled")

  write.csv(totals, paste0("data/CEMs/scaled", name, ".csv"), row.names=F)
}
