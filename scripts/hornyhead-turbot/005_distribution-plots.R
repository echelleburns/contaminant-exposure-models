# Run some plots and analyses on the distributions of CEMs

library(fitdistrplus)
library(tidyverse)

source("scripts/func-cde_finder.R")

# Contaminant Data
collect<-read.csv("data/true_contam/TrawlBioAccum-summary.csv") 
collect<-collect[which(collect$X.SCIENTIFIC.NAME == 'Pleuronichthys verticalis' & 
                         collect$SAMPLING.POINT == "T1"),]
colnames(collect)[14:15] <- c("DDT","PCB")

## DDT
### Tissue
filtered <- collect %>%
  filter(TISSUE == "TISSUE" & !is.na(DDT))

dataset <- filtered$DDT

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-tissueDDT", save_location = "data/cde_estimates/HT")

} 
### Liver
filtered <- collect %>%
  filter(TISSUE == "LIVER" & !is.na(DDT))

dataset <- filtered$DDT

if(median(dataset) != 0) {

# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-liverDDT", save_location = "data/cde_estimates/HT")
} 

## PCB
### Tissue
filtered <- collect %>%
  filter(TISSUE == "TISSUE" & !is.na(PCB)) 

dataset <- filtered$PCB

if(median(dataset) != 0) {

  # Scale to median
  scaled <- dataset/median(dataset)
  
cde_finder(dataset=dataset, save_name="HT-tissuePCB", save_location = "data/cde_estimates/HT")

} 
### Liver
filtered <- collect %>%
  filter(TISSUE == "LIVER" & !is.na(PCB))

dataset <- filtered$PCB

if(median(dataset) != 0) {

# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-liverPCB", save_location = "data/cde_estimates/HT")

} 

######################
# For scaled values
#####################
# Our generated data
## 3 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_HT_states-3mpermin-5min_CEM_pcb.csv")

filtered <- dat

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {

# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-3mpermin-5min-scaled", save_location = "data/cde_estimates/HT/peryear/")

} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-3mpermin-5min-notscaled", save_location = "data/cde_estimates/HT/peryear/")

} 

## 3 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_HT_states-3mpermin-5min_CEM_ddt.csv")

filtered <- dat  

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-3mpermin-5min-scaled", save_location = "data/cde_estimates/HT/peryear/")

} 

filtered <- dat

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-3mpermin-5min-notscaled", save_location = "data/cde_estimates/HT/peryear/")
} 

## 1 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_HT_states-1mpermin-5min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-1mpermin-5min-scaled", save_location = "data/cde_estimates/HT/peryear/")
} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-1mpermin-5min-notscaled", save_location = "data/cde_estimates/HT/peryear/")
} 

## 1 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_HT_states-1mpermin-5min_CEM_ddt.csv")

filtered <- dat

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-1mpermin-5min-scaled", save_location = "data/cde_estimates/HT/peryear/")
} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {

  # Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-1mpermin-5min-notscaled", save_location = "data/cde_estimates/HT/peryear/")
} 

## 3 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_HT_states-3mpermin-2min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-3mpermin-2min-scaled", save_location = "data/cde_estimates/HT/peryear/")
} 

filtered <- dat

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
   
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-3mpermin-2min-notscaled", save_location = "data/cde_estimates/HT/peryear/")
} 

## 3 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_HT_states-3mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-3mpermin-2min-scaled", save_location = "data/cde_estimates/HT/peryear/")
} 

filtered <- dat  

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-3mpermin-2min-notscaled", save_location = "data/cde_estimates/HT/peryear/")
} 

## 1 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_HT_states-1mpermin-2min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-1mpermin-2min-scaled", save_location = "data/cde_estimates/HT/peryear/")
} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-1mpermin-2min-notscaled", save_location = "data/cde_estimates/HT/peryear/")
} 

## 1 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_HT_states-1mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-1mpermin-2min-scaled", save_location = "data/cde_estimates/HT/peryear/")
} 

filtered <- dat

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-1mpermin-2min-notscaled", save_location = "data/cde_estimates/HT/peryear/")
} 

#################################
# For not time scaled 
################################
# Our generated data
## 3 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_HT_states-3mpermin-5min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {

  # Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-3mpermin-5min-scaled", save_location = "data/cde_estimates/HT")
} 

filtered <- dat  

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-3mpermin-5min-notscaled", save_location = "data/cde_estimates/HT")
} 

## 3 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_HT_states-3mpermin-5min_CEM_ddt.csv")

filtered <- dat  

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {

  # Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-3mpermin-5min-scaled", save_location = "data/cde_estimates/HT")

} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-3mpermin-5min-notscaled", save_location = "data/cde_estimates/HT")
} 

## 1 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_HT_states-1mpermin-5min_CEM_pcb.csv")

filtered <- dat  

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-1mpermin-5min-scaled", save_location = "data/cde_estimates/HT")
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-1mpermin-5min-notscaled", save_location = "data/cde_estimates/HT")
} 

## 1 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_HT_states-1mpermin-5min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-1mpermin-5min-scaled", save_location = "data/cde_estimates/HT")

} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-1mpermin-5min-notscaled", save_location = "data/cde_estimates/HT")

} 

## 3 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_HT_states-3mpermin-2min_CEM_pcb.csv")

filtered <- dat

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-3mpermin-2min-scaled", save_location = "data/cde_estimates/HT")
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-3mpermin-2min-notscaled", save_location = "data/cde_estimates/HT")

} 

## 3 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_HT_states-3mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-3mpermin-2min-scaled", save_location = "data/cde_estimates/HT")

} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-3mpermin-2min-notscaled", save_location = "data/cde_estimates/HT")

} 

## 1 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_HT_states-1mpermin-2min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-1mpermin-2min-scaled", save_location = "data/cde_estimates/HT")

} 

filtered <- dat

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-PCB-1mpermin-2min-notscaled", save_location = "data/cde_estimates/HT")

} 
## 1 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_HT_states-1mpermin-2min_CEM_ddt.csv")

filtered <- dat

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
# Scale to median
scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-1mpermin-2min-scaled", save_location = "data/cde_estimates/HT")
} 

filtered <- dat

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)

cde_finder(dataset=scaled, save_name="HT-DDT-1mpermin-2min-notscaled", save_location = "data/cde_estimates/HT")
} 
