if (!require(plumber)) install.packages("plumber")
setwd("~/politechnika/shiny_apps/adExplorer/services")
plumber::plumb("funkcja.R")$run(host = "0.0.0.0", port = 5000)