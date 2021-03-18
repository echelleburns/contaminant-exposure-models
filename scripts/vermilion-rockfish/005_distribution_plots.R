# Run some plots and analyses on the distributions of CEMs

library(fitdistrplus)
library(tidyverse)

source("scripts/functions/func-dist_finder.R")

# Contaminant Data
collect<-read.csv("data/true-contaminants/vermilion_rockfish_contaminants.csv")

## DDT
### Tissue
filtered <- collect %>%
  filter(!is.na(DDT))

dataset <- filtered$DDT

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT", save_location = "data/dist-estimates")
  
} 

## PCB
### Tissue
filtered <- collect %>%
  filter(!is.na(PCB)) 

dataset <- filtered$PCB

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=dataset, save_name="VR-PCB", save_location = "data/dist-estimates")
  
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
  
  dist_finder(dataset=scaled, save_name="VR-PCB-3mpermin-5min-scaled", save_location = "data/dist-estimates")
} 

filtered <- dat  

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-PCB-3mpermin-5min-notscaled", save_location = "data/dist-estimates")
} 

## 3 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-5min_CEM_ddt.csv")

filtered <- dat  

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT-3mpermin-5min-scaled", save_location = "data/dist-estimates")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT-3mpermin-5min-notscaled", save_location = "data/dist-estimates")
} 

## 1 m/min - 5 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-5min_CEM_pcb.csv")

filtered <- dat  

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-PCB-1mpermin-5min-scaled", save_location = "data/dist-estimates")
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-PCB-1mpermin-5min-notscaled", save_location = "data/dist-estimates")
} 

## 1 m/min - 5 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-5min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT-1mpermin-5min-scaled", save_location = "data/dist-estimates")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT-1mpermin-5min-notscaled", save_location = "data/dist-estimates")
  
} 

## 3 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-2min_CEM_pcb.csv")

filtered <- dat

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-PCB-3mpermin-2min-scaled", save_location = "data/dist-estimates")
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-PCB-3mpermin-2min-notscaled", save_location = "data/dist-estimates")
  
} 

## 3 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-3mpermin-2min_CEM_ddt.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT-3mpermin-2min-scaled", save_location = "data/dist-estimates")
  
} 

filtered <- dat 

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT-3mpermin-2min-notscaled", save_location = "data/dist-estimates")
  
} 

## 1 m/min - 2 min - PCB
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-2min_CEM_pcb.csv")

filtered <- dat 

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-PCB-1mpermin-2min-scaled", save_location = "data/dist-estimates")
  
} 

filtered <- dat

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-PCB-1mpermin-2min-notscaled", save_location = "data/dist-estimates")
  
} 
## 1 m/min - 2 min - DDT
dat <- read.csv("data/CEMs/scaled_VR_states-1mpermin-2min_CEM_ddt.csv")

filtered <- dat

dataset <- filtered$total_behavioral_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT-1mpermin-2min-scaled", save_location = "data/dist-estimates")
} 

filtered <- dat

dataset <- filtered$total_tox

if(median(dataset) != 0) {
  
  # Scale to median
  scaled <- dataset/median(dataset)
  
  dist_finder(dataset=scaled, save_name="VR-DDT-1mpermin-2min-notscaled", save_location = "data/dist-estimates")
} 
