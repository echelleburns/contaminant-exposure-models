##################
#### Packages ####
##################

library(geosphere) # for euclidian distance
library(rgdal) # for shapefile
library(spatstat) # for shapefile
library(maptools) # for shapefile
library(fields) # for colors
library(reshape) # for colsplit
library(moveHMM) # for turning angles and step lengths

# One for all and all for one! 
# Now we get to do it for all the datasets.

files_list<- list.files("data/crawl", pattern='HT')
files_list <- files_list[grep('min', files_list)]

for( file in files_list) { 
  time <- colsplit(file, "_", c("",""))[,2]
  time <- colsplit(time, "min", c("", ""))[,1]
  alldat<-read.csv(paste0("data/crawl/", file))

  df<-alldat
  coordinates(df)<-~mu.x+mu.y # make sure these are read as coordinates
  proj4string(df)<-CRS("+proj=aeqd +lat_0=33.582089 +lon_0=-118.002027 +x_0=5000 +y_0=5000 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs")
  df<-spTransform(df, CRS("+proj=longlat"))
  # define the projection for analyses
  alldat$LON<-coordinates(df)[,1]
  alldat$LAT<-coordinates(df)[,2]
  
  alldat$DATETIME<-as.POSIXct(alldat$DATETIME, tz="UTC")
  
  newalldat<-NULL
  for( i in unique(alldat$DETECTEDID)) { 
    temp<-alldat[which(alldat$DETECTEDID == i), ]
    obs<-temp[which(temp$locType == "o"), ]
    for( j in 2:nrow(obs)) { 
      diff<-as.numeric(difftime(obs$DATETIME[j], obs$DATETIME[j-1], units="hours"))
      if (diff > 2) { 
        temp<-temp[-which(temp$DATETIME > obs$DATETIME[j-1] & temp$DATETIME < obs$DATETIME[j]),]
      }
    }
    newalldat<-rbind(newalldat,temp)
  }
  
  newalldat<-newalldat[-which(newalldat$locType == 'o'),]
  for(it in c(1,3)) {
    step_guard <- NULL
    if (it == 1 & time == 2){ 
      step_guard <- 2}
    if (it == 3 & time == 2){ 
      step_guard <- 6}
    if (it == 1 & time == 5){ 
      step_guard <- 5}
    if (it == 3 & time == 5){ 
      step_guard <- 15}
    hmm<-NULL
    for( h in unique(newalldat$DETECTEDID) ) { # for each listed file...
      dat<-newalldat[which(newalldat$DETECTEDID == h),]
        # read in the dataset
      if( nrow(dat) > 10 ) { # if there are more than 10 rows of data...
       dat$DATETIME<-as.POSIXct(dat$DATETIME, tz="UTC") # make sure the local time is posix
       dat<-dat[order(dat$DATETIME),] # order it by time
       
       obs<-dat[,c("DETECTEDID", "LON", "LAT")] # only keep these columns
       colnames(obs)<-c("ID", "x", "y") # name them this
       prepped<-prepData(obs, type="LL") # get the turning angles and step lengths
       prepped$stepinm<-prepped$step*1000 # convert to meters
       prepped$DATETIME<-dat$DATETIME # add the datetime info
       prepped$angle[is.na(prepped$angle)]<-0 # if the fish has an NA turning angle, it's not moving so assign
         # it 0
       
      # Find what state it's in
       prepped$state<-NULL # set this to null to populate later
       for (i in 2:nrow(prepped)-1) { # for each row (except the first and the last)
         if(prepped$stepinm[i] <= step_guard) { # if the step length is less than or equal to limit
           prepped$state[i]<-"not-moving" # it's not moving
         } # end for if the step length is less than or equal to limit
         if (prepped$stepinm[i] > step_guard ) {  # if the step length is greater than limit
           prepped$state[i]<-"nondirectional_movement" # for now set it to nondirectional movement
           if (i > 3 ) { # if we're on at least the third row
             if (prepped$angle[i] < pi/8 & prepped$angle[i] > - pi/8 & prepped$angle[i-1] < pi/8 & prepped$angle[i-1] > - pi/8 & prepped$angle[i-2] < pi/8 & prepped$angle[i-2] > - pi/8 ) { 
               # check to see if the last three turning angles were between -45 and +45 degrees
               prepped$state[i] <- "directional_movement" # reclassify as directional movement
               prepped$state[i-1]<-"directional_movement" # reclassify as directional movement
               prepped$state[i-2]<-"directional_movement" # reclassify as directional movement
             } # end for if the last three turning angles were between -45 and + 45
           } # end for if we're on at least the third row
         } # end for if step length is greater than limit
       } # end for each row in the dataset
      }
      hmm<-rbind(hmm, prepped)
    } 
    
    
    # remove data from data gaps
    hmm.2<-NULL
    for( i in unique(hmm$ID)) { 
      temp<-hmm[which(hmm$ID == i),]
      temp$timediff<-c(0, difftime(temp$DATETIME[2:nrow(temp)], temp$DATETIME[1:nrow(temp)-1], unit="mins"))
      temp<-temp[which(temp$timediff == time | temp$timediff == 0),]
      hmm.2<-rbind(hmm.2, temp)
    }
    
    write.csv(hmm.2, paste0("data/behaviors/HT_states-",it,"mpermin-",time,"min.csv"), row.names=FALSE)
  } 
}

# ok so now lets plot some distributions here. 

list_completed <- list.files("data/behaviors/", pattern='HT')

for( file in list_completed){ 
  plt <- read.csv(paste0("data/behaviors/", file))
  plt <- as.data.frame(table(plt$state))
  plt$prop <- plt$Freq/sum(plt$Freq)
  plt$labels <- as.character(plt$Var1)
  plt$labels<- gsub("directional_movement", "Directional Movement", plt$labels)
  plt$labels<- gsub("nonDirectional Movement", "Non-Directional\nMovement", plt$labels)
  plt$labels <- gsub("Directional Movement", "Directional\nMovement", plt$labels)
  plt$labels<- gsub("not-moving", "Not Moving\n", plt$labels)
  new_name <- colsplit(file, "[.]", c("",""))[,1]
  par(mar=c(3.5,3.5,2,1), cex=2.6)
  barplot(plt$prop, ylim=c(0,1), ylab='', names.arg=plt$labels, col="darkseagreen3")
  mtext("Proportion of Fish", side=2, line=2, cex=2.8)
  }
