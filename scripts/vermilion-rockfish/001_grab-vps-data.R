# grab raw VPS data after filtering. 
library(reshape)

fish<-read.csv("D:/Documents/Lowe/OCSD/Data/Tagging/Burns_Echelle_fishtagged.csv")
fish<-fish[which(fish$Species == 'S. miniatus' & fish$mortality == ''),]
fish$shortID<-colsplit(fish$ID, '-', c("","",""))[,3]
fish$Date_Released<-as.Date(fish$Date_Released, format='%m/%d/%Y')

list<-as.data.frame(list.files("D:/Documents/Lowe/OCSD/Data/VPS_Rendering/All_Exports/lowHPE", pattern='csv'))
colnames(list)<-'file'
list$id<-colsplit(list$file, '_', c('',''))[,1]

list<-list[which(list$id %in% fish$shortID),]

dat<-NULL
sum_rows <- 0 # to see how much data is lost after parsing
for(i in list$file) { 
  temp<-read.csv(paste0("D:/Documents/Lowe/OCSD/Data/VPS_Rendering/All_Exports/lowHPE/", i))
  temp$local<-as.POSIXct(temp$local, tz='America/Los_Angeles')
  sum_rows <- sum_rows + nrow(temp) # to see how much data is lost after parsing
  temp$date<-as.Date(temp$local)
  id<-paste(temp$DETECTEDID[1])
  tagdate<-fish$Date_Released[which(fish$ID == id)] # removes first day
  temp<-temp[which(temp$date > tagdate),]
  temp <- temp[!grepl("Ref", temp$URX),] # only keep OCSD array data
  if( nrow(temp) > 0) { 
  dat<-rbind(temp, dat)
  }
}

dat<-dat[!duplicated(dat),]

write.csv(dat, row.names = F, "data/all_detections/all_VR.csv")
