# dist_finder function
library(fitdistrplus)

dist_finder <- function(dataset, meth="mme", save_name="plot", save_location=getwd()) {
  # Raw data plotting
  png(paste0(save_location, "/", save_name, "_dist.png"), height=480, width=480*2)
  plotdist(dataset, histo = TRUE, demp=TRUE)
  dev.off()
  
  # Fitting different density models
  gam <- fitdist(dataset, "gamma", method=meth) 
  norm <- fitdist(dataset, "norm", method=meth)
  exp <- fitdist(dataset, "exp", method=meth)
  logis <- fitdist(dataset, "logis", method=meth)
  
  mod_list<-list(gam, #lnorm, 
                 norm, exp, logis)
  names(mod_list)<-c("gamma", #"log-normal", 
                     "normal", "exponential", "logis")
  
  save_outputs = NULL
  for(mod in 1:length(mod_list)) { 
    assign('model_run', mod_list[[mod]])
    if(!is.null(model_run$sd)) {
      temp_row <- data.frame("distribution" = names(mod_list)[mod], 
                           "parameter" = names(model_run$estimate), 
                           "estimate" = model_run$estimate, 
                           "sd" = model_run$sd,
                           "AIC" = model_run$aic, 
                           "BIC" = model_run$bic, 
                           "loglik" = model_run$loglik)
    } 
    if(is.null(model_run$sd)) {
      temp_row <- data.frame("distribution" = names(mod_list)[mod], 
                             "parameter" = names(model_run$estimate), 
                             "estimate" = model_run$estimate, 
                             "sd" = NA,
                             "AIC" = model_run$aic, 
                             "BIC" = model_run$bic, 
                             "loglik" = model_run$loglik)
    } 
    save_outputs <- rbind(save_outputs, temp_row)
  }
  rownames(save_outputs) <- NULL
  
  write.csv(save_outputs, paste0(save_location,"/", save_name, "_dist-estimates.csv"), 
                                 row.names=FALSE)
  
  # Plotting dist outputs
  png(paste0(save_location, "/", save_name, "_gamma.png"), height=480*2, width=480*2)
  plotdist(dataset, "gamma", para=list(shape = gam$estimate[1], 
                                       rate = gam$estimate[2]), hist=TRUE, demp=TRUE)
  dev.off()
  png(paste0(save_location, "/", save_name, "_norm.png"), height=480*2, width=480*2)
  plotdist(dataset, "norm", para=list(mean = norm$estimate[1], 
                                      sd = norm$estimate[2]), hist=TRUE, demp=TRUE)
  dev.off()
  png(paste0(save_location, "/", save_name, "_exp.png"), height=480*2, width=480*2)
  plotdist(dataset, "exp", para=list(rate= exp$estimate[1]), hist=TRUE, demp=TRUE)
  dev.off()
  png(paste0(save_location, "/", save_name, "_logis.png"), height=480*2, width=480*2)
  plotdist(dataset, "logis", para=list(location = logis$estimate[1], 
                                       scale = logis$estimate[2]), hist=TRUE, demp=TRUE)
  dev.off()
}
