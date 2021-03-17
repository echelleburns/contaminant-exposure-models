# Folder Schema
Please ensure that your folder schema is the same as described below to ensure that all codes run appropriately.

+ `data`: should include all datasets used and created for this project
  - `shapefiles`: contains the shapefiles for the sediment-bound contaminant layers
    - `total_ddt_pv.shp` (and associated shapefiles): DDT concentrations at the LACSD study site
  - `true-contaminants`: includes contaminant data collected from field samples
     - `white_croaker.xlsx`: for white croaker
  - `all-detections`: all VPS rendered positions for species used in the study, truncated to HPE > 15 and the first 24-hours post-tagging removed
    - `all_WC.csv`: for white croaker
  - `crawl`: contains the outputs for all model runs (2 min and 5 min interpolations) from the crawl simulation for all species (files created in code `001_continuous-time_correlated_random_walk.R` in each respective species script folder)
    - `*_model_estimates.csv`: the estimated output of tau, sigma, and beta for each iteration (n = 6) of each tagged individual, where * indicates the species (WC, HT, VR)
    - `*_2min-interpolations.csv`: the estimated locations of the third simluation for each individual at 2 min intervals, where * indicates the species (WC, HT, VR)
    - `*_5min-interpolations.csv`: the estimated locations of the third simluation for each individual at 5 min intervals, where * indicates the species (WC, HT, VR)
  - `behaviors`: contains the output for behavioral movement classifications that are defined using the `crawl` data outputs within the `003_movement-models.R`
    - `*_states-**mpermin-***min.csv`: the estimated behavioral state estimated at each location at each time step, where * indicates the species (WC, HT, VR), ** indicates the rate of movement threshold (1 m/min or 3 m/min), and *** indicates the crawl temporal resolution (2 or 5 min)
  - `CEMs`: contains the output for the CEM models using the data from the `behaviors` folder within the `004_CEM.R`
    - `raw_*_CEM_**.csv`: the raw output for the CEM models, where * indicates the species (WC, HT, VR) and ** indicates the contaminant (DDT or PCB)
    - `scaled_*_CEM_**.csv: the sum of the output for the CEM models, for both unscaled (no behavioral scaling) and scaled (scaled by behavioral state) scenarios, where * indicates the species (WC, HT, VR) and ** indicates the contaminant (DDT or PCB)
  - `dist-estimates`: contains the estimates of the underlying distributions for the true contaminant data (`data/true-contaminants/`) and the generated contaminant exposure models (`data/CEMs/scaled*`) from `005_distribution-plots.R`
  - `kde-weighted`: contains the outputs of KDEs generated from the data in `007_kde-weighted.R`
+ `scripts`: includes all codes
  - `general`: includes all codes run for the collective groups of species
  - `functions`: includes all functions created
    - `func-dist_finder.R`: function create to find the best fit distribution for the datasets
    - `comparing-functions.R`: contains functions `scale_for_ks()` which calculates a z-score from the best fitting underlying distribution for scaling prior to putting the data into a KS test; and `create_plots()` which generates a series of distribution plots for the data specified
  - `white-croaker`: includes all codes run for white croaker analyses
    - `001_crawl.R`: takes the raw data from `all-detections` and creates crawl outputs at 2 and 5 min intervals
    - `002_model_fitting.Rmd/002_model_fitting.nb.html`: plots the third simulation from the crawl dataset to ensure results look appropriate
    - `003_movement_models`: categorizes the data from the `data/crawl` into non-moving, random movement, or directional movement and saves the outputs to the `data/behaviors/` folder
    - `004_CEM.R`: uses the combination of the shapefiles containing sediment-bound contaminant concentrations, `data/crawl` and `data/behavior` outputs to calculate the potential for contaminant exposure using time-area metrics
    - `005_distribution_plots.R`: calculates the underlying distributions for true contaminant data (`data/true-contaminants/`) and the generated contaminant exposure models (`data/CEMs/scaled*`)
    - `006_plots_stats.Rmd/006_plots_stats.nb.html`: conducts KS tests for the resulting datasets
    - `007_kde_weighted.R`: creates spatial kernel density estimates for all data, weighted by underlying sediment contaminant concentration
  - `vermilion-rockfish`: includes all codes run for vermilion rockfish analyses
  - `hornyhead-turbot`: includes all codes run for hornyhead turbot analyses
+ `figures`: contains output figures
  - `white-croaker`: includes output figures for white croaker
 
# R Version
All code was run using RStudio version 1.1.463, R version 4.0.1 on a device running Windows 10 Home.

# Required Libraries
+ Data Cleaning and Visualization
  - tidyverse (version 1.3.0)
  - readxl (version 1.3.1)
  - reshape (version 0.8.8)
  - fields (version 11.6)
+ Geospatial Data Ingestion
  - rgdal (version 1.5-18)
  - spatstat (version 1.64-1)
  - geosphere (version 1.5-10)
  - maptools (version 1.0-2)
  - raster (version 3.3-13)
+ Distribution Fitting/Analyses
  - fitdistrplus (version 1.1-1)
  - limma (version 3.46.0)
+ Track Interpolation
  - crawl (version 2.2.1)
+ Movement Models
  - moveHMM (version 1.7)
+ Kernel Density Estimates
  - spatialEco (version 1.3-2)
