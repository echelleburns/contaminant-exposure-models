# Run some plots and analyses on the distributions of CEMs

library(fitdistrplus)
library(tidyverse)
library(readxl)

source("scripts/functions/func-dist_finder.R")

# Contaminant Data
collect<-read_xlsx("data/true-contaminants/white_croaker_contaminants.xlsx")
collect<-collect %>% 
  filter(Spcode == "WC" & region == "PV")
colnames(collect)[11:12] <- c("DDT","PCB")

## DDT
### Tissue
filtered <- collect %>%
  filter(!is.na(DDT))

dataset <- filtered$DDT

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT", save_location = "data/dist-estimates/")
  
} 

######################
# For scaled values
#####################

## 3 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_WC_states-3mpermin-5min_CEM_ddt.csv")

filtered <- dat  

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-3mpermin-5min-scaled", save_location = "data/dist-estimates/")
  
} 

filtered <- dat

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-3mpermin-5min-notscaled", save_location = "data/dist-estimates/")
} 

## 1 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_WC_states-1mpermin-5min_CEM_ddt.csv")

filtered <- dat

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-1mpermin-5min-scaled", save_location = "data/dist-estimates/")
} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-1mpermin-5min-notscaled", save_location = "data/dist-estimates/")
} 


## 3 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_WC_states-3mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-3mpermin-2min-scaled", save_location = "data/dist-estimates/")
} 

filtered <- dat  

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-3mpermin-2min-notscaled", save_location = "data/dist-estimates/")
} 


## 1 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_WC_states-1mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-1mpermin-2min-scaled", save_location = "data/dist-estimates/")
} 

filtered <- dat

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-1mpermin-2min-notscaled", save_location = "data/dist-estimates/")
} 

#################################
# For not time scaled 
################################
# Our generated data

## 3 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_WC_states-3mpermin-5min_CEM_ddt.csv")

filtered <- dat  

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-3mpermin-5min-scaled", save_location = "data/dist-estimates/")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-3mpermin-5min-notscaled", save_location = "data/dist-estimates/")
} 


## 1 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_WC_states-1mpermin-5min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-1mpermin-5min-scaled", save_location = "data/dist-estimates/")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-1mpermin-5min-notscaled", save_location = "data/dist-estimates/")
  
} 

## 3 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_WC_states-3mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-3mpermin-2min-scaled", save_location = "data/dist-estimates/")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-3mpermin-2min-notscaled", save_location = "data/dist-estimates/")
  
} 

## 1 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_WC_states-1mpermin-2min_CEM_ddt.csv")

filtered <- dat

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-1mpermin-2min-scaled", save_location = "data/dist-estimates/")
} 

filtered <- dat

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="WC-DDT-1mpermin-2min-notscaled", save_location = "data/dist-estimates/")
} 
