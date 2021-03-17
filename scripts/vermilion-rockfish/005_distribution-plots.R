# Run some plots and analyses on the distributions of CEMs

library(fitdistrplus)
library(tidyverse)

source("scripts/func-cde_finder.R")

# Contaminant Data
collect<-read.csv("data/true_contam/RigFishBioAccum-summary.csv")
collect<-collect[which(collect$X.SCIENTIFIC.NAME == 'Sebastes miniatus' & 
                         collect$SAMPLING.POINT == "RF1"),]
colnames(collect)[16:17] <- c("DDT","PCB")


## DDT
### Tissue
filtered <- collect %>%
  filter(!is.na(DDT))

dataset <- filtered$DDT

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT", save_location = "data/cde_estimates/VR")
  
} 

## PCB
### Tissue
filtered <- collect %>%
  filter(!is.na(PCB)) 

dataset <- filtered$PCB

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=dataset, save_name="VR-PCB", save_location = "data/cde_estimates/VR")
  
} 

######################
# For scaled values
#####################
# Our generated data
## 3 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-5min_CEM_pcb.csv")

filtered <- dat

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-3mpermin-5min-scaled", save_location = "data/cde_estimates/VR/peryear/")
  
} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-3mpermin-5min-notscaled", save_location = "data/cde_estimates/VR/peryear/")
  
} 

## 3 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-5min_CEM_ddt.csv")

filtered <- dat  

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-3mpermin-5min-scaled", save_location = "data/cde_estimates/VR/peryear/")
  
} 

filtered <- dat

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-3mpermin-5min-notscaled", save_location = "data/cde_estimates/VR/peryear/")
} 

## 1 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-5min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-1mpermin-5min-scaled", save_location = "data/cde_estimates/VR/peryear/")
} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-1mpermin-5min-notscaled", save_location = "data/cde_estimates/VR/peryear/")
} 

## 1 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-5min_CEM_ddt.csv")

filtered <- dat

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-1mpermin-5min-scaled", save_location = "data/cde_estimates/VR/peryear/")
} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-1mpermin-5min-notscaled", save_location = "data/cde_estimates/VR/peryear/")
} 

## 3 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-2min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-3mpermin-2min-scaled", save_location = "data/cde_estimates/VR/peryear/")
} 

filtered <- dat

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-3mpermin-2min-notscaled", save_location = "data/cde_estimates/VR/peryear/")
} 

## 3 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-3mpermin-2min-scaled", save_location = "data/cde_estimates/VR/peryear/")
} 

filtered <- dat  

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-3mpermin-2min-notscaled", save_location = "data/cde_estimates/VR/peryear/")
} 

## 1 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-2min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-1mpermin-2min-scaled", save_location = "data/cde_estimates/VR/peryear/")
} 

filtered <- dat 

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-1mpermin-2min-notscaled", save_location = "data/cde_estimates/VR/peryear/")
} 

## 1 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$tox_peryear_scaled

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-1mpermin-2min-scaled", save_location = "data/cde_estimates/VR/peryear/")
} 

filtered <- dat

dataset <- filtered$tox_peryear_noscaler

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-1mpermin-2min-notscaled", save_location = "data/cde_estimates/VR/peryear/")
} 

#################################
# For not time scaled 
################################
# Our generated data
## 3 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-5min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-3mpermin-5min-scaled", save_location = "data/cde_estimates/VR")
} 

filtered <- dat  

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-3mpermin-5min-notscaled", save_location = "data/cde_estimates/VR")
} 

## 3 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-5min_CEM_ddt.csv")

filtered <- dat  

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-3mpermin-5min-scaled", save_location = "data/cde_estimates/VR")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-3mpermin-5min-notscaled", save_location = "data/cde_estimates/VR")
} 

## 1 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-5min_CEM_pcb.csv")

filtered <- dat  

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-1mpermin-5min-scaled", save_location = "data/cde_estimates/VR")
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-1mpermin-5min-notscaled", save_location = "data/cde_estimates/VR")
} 

## 1 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-5min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-1mpermin-5min-scaled", save_location = "data/cde_estimates/VR")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-1mpermin-5min-notscaled", save_location = "data/cde_estimates/VR")
  
} 

## 3 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-2min_CEM_pcb.csv")

filtered <- dat

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-3mpermin-2min-scaled", save_location = "data/cde_estimates/VR")
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-3mpermin-2min-notscaled", save_location = "data/cde_estimates/VR")
  
} 

## 3 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-3mpermin-2min-scaled", save_location = "data/cde_estimates/VR")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-3mpermin-2min-notscaled", save_location = "data/cde_estimates/VR")
  
} 

## 1 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-2min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-1mpermin-2min-scaled", save_location = "data/cde_estimates/VR")
  
} 

filtered <- dat

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-PCB-1mpermin-2min-notscaled", save_location = "data/cde_estimates/VR")
  
} 
## 1 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-2min_CEM_ddt.csv")

filtered <- dat

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-1mpermin-2min-scaled", save_location = "data/cde_estimates/VR")
} 

filtered <- dat

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  cde_finder(dataset=scaled, save_name="VR-DDT-1mpermin-2min-notscaled", save_location = "data/cde_estimates/VR")
} 
