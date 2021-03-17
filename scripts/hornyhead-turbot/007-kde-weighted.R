# Spatial Kernel Density Estimates with Weights by Tox Value

# Load packages
library(spatialEco)
library(rgdal)
library(raster)
library(reshape)

# Load data
list_files <- list.files("data/CEMs/", pattern="raw_HT")

for( file in list_files ) { 
  
  name <- colsplit(file, ".csv", c(""))[,1]
  name <- paste0("HT_", colsplit(name, "raw_HT_states-", c(""))[,2])
  
  dat <- read.csv(paste0("data/CEMs/", file))
  
  # Convert to spatial points
  df<-dat[,c("x","y")]
  coordinates(df)<-~x+y # make sure these are read as coordinates
  proj4string(df)<- CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
  
  dat <- dat$tox
  
  # Get spatial kde weighted by tox values
  test <- sp.kde(df, y=dat, nr=500, nc=500, bw=0.0015, standardize=TRUE)
  
  writeRaster(test, filename=paste0("data/kde-weighted/", name), format="GTiff", overwrite=TRUE)
  
  remove(df, dat, test)
}

