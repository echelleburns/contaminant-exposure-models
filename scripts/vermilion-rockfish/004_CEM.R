# Now let's get me a contaminant exposure model for my tracks. 
# I have minute-by-minute data, right? So let's do it this way... for each location we have, what is the sediment
# tox level? How many minutes is the fish in that tox level? 
# Treat times in which the fish is not actually detected in the field as NAs or as non-detectable levels. 

library(reshape)
library(rgdal)

ddt<-readOGR("data/shapefiles/OCSD-ddt_clipped.shp")
pcb<-readOGR("data/shapefiles/OCSD-pcb_clipped.shp")
tox.list<-list(pcb, ddt)
names(tox.list)<-c("pcb","ddt")

list<-list.files("data/behaviors/", pattern="VR")

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

  
list<-list.files('data/CEMs', pattern='raw_VR')

for( h in list) { 
  name <- colsplit(h, "[.]", c("",""))[,1]
  name <- colsplit(name, "raw", c(""))[,2]
  
  dat<-read.csv(paste0("data/CEMs/", h))

  scaling<-as.data.frame(c("directional_movement","nondirectional_movement","not-moving"))
  colnames(scaling)<-"state"
  scaling$scaler<-c(0, 0.5, 1)

  this_contam<-colsplit(h, "_", c('','','',''))[,5]
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

## Lets pause on the code below for now. Might re-do that stats here.
#
#  totals$tox_peryear_noscaler<-as.numeric(paste(totals$tox_peryear_noscaler))
#  totals$tox_peryear_scaled<-as.numeric(paste(totals$tox_peryear_scaled))
#
#  totals$round1<-round(totals$tox_peryear_noscaler/100)*100
#  totals$round2<-round(totals$tox_peryear_scaled/100)*100
#
#  totals$round_no<-round(totals$tox_peryear_noscaler/max(totals$tox_peryear_noscaler)/0.1)*0.1
#  totals$round_sc<-round(totals$tox_peryear_scaled/max(totals$tox_peryear_scaled)/0.1)*0.1
#
#  no<-as.data.frame(table(totals$round_no))
#  sc<-as.data.frame(table(totals$round_sc))
#
#barplot(table(totals$round1))
#barplot(table(totals$round2))
#
## Try plotting now
#plotthis<-as.data.frame(seq(0,1,0.1))
#colnames(plotthis)<-"x"
#plotthis$contam<-0
#for( i in 1:nrow(plotthis)) { 
#  if (plotthis$x[i] %in% no$Var1) {
#    plotthis$contam[i]<-no$Freq[which(no$Var1 == plotthis$x[i])]
#  } 
#}
#
## new
##plotthis<-plotthis[-1,]
#
#plotthis2<-as.data.frame(seq(0,1,0.1))
#colnames(plotthis2)<-"x"
#plotthis2$contam<-0
#for( i in 1:nrow(plotthis2)) { 
#  if (plotthis2$x[i] %in% sc$Var1) {
#    plotthis2$contam[i]<-sc$Freq[which(sc$Var1 == plotthis2$x[i])]
#  } 
#}
#
##plotthis2<-plotthis2[-1,]
#
#cols <- c("lightgray", "dodgerblue4")[(plotthis$x > 0) + 1]
#cols_x2 <- c("lightgray", "dodgerblue4")[(plotthis2$x > 0) + 1]
#
# png(paste0("D:/Documents/Lowe/OCSD/Pubs/SETAC/Hornyhead/figures/", Sys.Date(), new_name, '.png'), height=480*12, width=480*10,  res=72*6)
# par(mfrow=c(2,1), cex=1.5, mar=c(2,3,2,5), cex.axis=2)
# barplot(height=plotthis$contam/sum(plotthis$contam), names.arg=plotthis$x, ylim=c(0,1), col=cols)
# barplot(height=plotthis2$contam/sum(plotthis2$contam), names.arg=plotthis2$x, ylim=c(0,1), col=cols_x2)
# dev.off()
#
#
## Ok what about the dat that were gathered by the sanitation district - eh? 
#collect<-read.csv("D:/Documents/Lowe/OCSD/Pubs/SETAC/Hornyhead/TrawlBioAccum-summary.csv")
#collect<-collect[which(collect$X.SCIENTIFIC.NAME == 'Pleuronichthys verticalis'),]
#collect$DDT<-collect$Total.DDTs..?g.kg.
#collect$PCB<-collect$Total.PCBs..?g.kg.
#collect<-collect[!is.na(collect[,c(this_contam)]),]
#collect$round<-round(collect[,c(this_contam)]/max(collect[,c(this_contam)])/0.1)*0.1
#
#for (tissue in unique(collect$TISSUE)) { 
#collect_t<-collect[which(collect$TISSUE == tissue),]
#
#tb.col<-as.data.frame(table(collect_t$round))
#
#plotthis3<-as.data.frame(seq(0,1,0.1))
#colnames(plotthis3)<-"x"
#plotthis3$contam<-0
#for( i in 1:nrow(plotthis3)) { 
#  if (plotthis3$x[i] %in% tb.col$Var1) {
#    plotthis3$contam[i]<-tb.col$Freq[which(tb.col$Var1 == plotthis3$x[i])]
#  } 
#}
#
#cols <- c("lightgray", "dimgray")[(plotthis3$x > 0) + 1] 
##plotthis3<-plotthis3[-1,]
#
# png(paste0("D:/Documents/Lowe/OCSD/Pubs/SETAC/Hornyhead/figures/", Sys.Date(), "_", this_contam, "_", tissue, "_collected.png"), height=480*6, width=480*10,  res=72*6)
# par(cex=1.5, mar=c(2,3,2,5), cex.axis=2)
# barplot(height=plotthis3$contam/sum(plotthis3$contam), names.arg=plotthis3$x, ylim=c(0,1), col=cols)
# dev.off()
#
## # remove 0
# totals_no_zero<-totals[which(totals$round_no > 0 & totals$round_sc > 0),]
# collect_no_zero<-collect_t[which(collect_t$round > 0),]
#
## Stats tests to the max
#sink(paste0("D:/Documents/Lowe/OCSD/Pubs/SETAC/Hornyhead/", Sys.Date(), "_", new_name, "_", tissue, "_results.txt"))
#print('With Zeros in Dataset')
#print('Unscaled v Scaled')
#print(ks.test(totals$round_no, totals$round_sc))
#print('---------------')
#print('Scaled vs Tissue')
#print(ks.test(totals$round_sc, collect_t$round))
#print('---------------')
#print('Unscaled vs Tissue')
#print(ks.test(totals$round_no, collect_t$round))
#
#print('##################')
#print('Zeros Removed from Dataset')
#if (nrow(totals_no_zero) > 0 & nrow(collect_no_zero) > 0) {
#  print('Unscaled v Scaled')
#  print(ks.test(totals_no_zero$round_no, totals_no_zero$round_sc))
#  print('---------------')
#  print('Scaled vs Tissue')
#  print(ks.test(totals_no_zero$round_sc, collect_no_zero$round))
#  print('---------------')
#  print('Unscaled vs Tissue')
#  print(ks.test(totals_no_zero$round_no, collect_no_zero$round))
#} else {print('Not enough data')}
#sink()
#}
#
#} 
#
