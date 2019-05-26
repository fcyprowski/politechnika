setwd("~/politechnika/shiny_apps/adExplorer/services")
source("build.R")
source("functions.R")  # powinno być w pakiecie
plumber::plumb("funkcja.R")$run(host = "0.0.0.0", port = 5000)