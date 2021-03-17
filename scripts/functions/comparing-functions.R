# comparison functions

# ks scaling function
scale_for_ks <- function(spp, file, data) { 
  
  # read file and find best option
    dist_file <- read.csv(paste0("../../data/dist-estimates/", file)) %>%
    mutate(distribution = case_when(distribution == "log-normal" ~ "lnorm", 
                                    distribution == "normal" ~ "norm", 
                                    distribution == "exponential" ~ "exp", 
                                    TRUE ~ distribution)) %>% 
    filter(!is.infinite(AIC)) %>% 
    arrange(AIC) %>% 
    filter(distribution == distribution[1])
  
  # calc z score
  # for distribution with just one argument
  if(nrow(dist_file) == 1) { 
    dist_info <- paste0(dist_file$parameter[1], "=",dist_file$estimate[1])
    
    ks_scaled <- zscore(data, dist = dist_file$distribution[1], 
                        eval(parse(text = dist_info)))
  } 
  
  # for distribution with 2 arguments
  if(nrow(dist_file) == 2) { 
    
    dist_info <- paste0(dist_file$parameter[1], "=",dist_file$estimate[1])
    dist_info2 <- paste0(dist_file$parameter[2], "=",dist_file$estimate[2])
    
    ks_scaled <- zscore(data, dist = dist_file$distribution[1], 
                        eval(parse(text = dist_info)), 
                        eval(parse(text = dist_info2)))
  }
  
  return(ks_scaled) 
} 

# Plotting function
create_plots <- function(data, type, contam, color, path, file) { 
  
  # create bins
  lower <- floor(min(data))
  
  if(max(data) == 0) { 
    upper <- 4
  } else {  
    upper <- ceiling(max(data))
  } 
  bins <- (upper-lower)/15
  
  # build histogram table
  field_plot <- data.frame("value"=ceiling(data/bins)*bins)
  field_plot <- as.data.frame(table(field_plot))
  colnames(field_plot)[1] <- "value"
  field_plot$value <- as.numeric(paste(field_plot$value))
  field_plot$Freq <- field_plot$Freq/sum(field_plot$Freq)
  
  # fill in zeros
  plot_this<-as.data.frame(seq(lower, upper, bins))
  colnames(plot_this)<-"x"
  plot_this$value<-0
  for( i in 1:nrow(plot_this)) { 
    if (paste(plot_this$x[i]) %in% paste(field_plot$value)) {
      plot_this$value[i]<-field_plot$Freq[which(paste(field_plot$value) == paste(plot_this$x[i]))]
    } 
  }
  
  # save barplot
  png(paste0(path, file, ".png"),  height=480*8, width=480*11,  res=72*6)
  par(mar=c(3.5,3.5,2,1), cex=3)
  barplot(height=plot_this$value, names.arg = seq(lower, upper, bins), 
          col=color, ylim=c(0,1))
  title(main=bquote("["*Sigma*.(contam)*"]"~.(type)), line=0, font.main=1)
  title(main=paste("n =", length(data)), line=-1.5, font.main=1)
  mtext("Proportion of Fish", side=2, line=2, cex=3)
  if(median(data) == 0) { 
    mtext(bquote("Raw ["*Sigma*.(contam)*"]"), side=1, line=2, cex=3)
    title("*", line = -3)
  } else {
    mtext(bquote("Scaled ["*Sigma*.(contam)*"]"), side=1, line=2, cex=3)
  }
  dev.off()
}