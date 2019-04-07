# najelpsza ksiazka:
# http://r-pkgs.had.co.nz/
# cheatsheet:
# https://www.rstudio.com/wp-content/uploads/2015/06/devtools-cheatsheet.pdf

devtools::create("adExplorerPackage")
devtools::use_testthat("adExplorerPackage")
# zeby zainstalowac pakiet
# ZALOZENIE: jestesmy w "politechnika/shiny_apps/adExplorer
devtools::install("adExplorerPackage")
if (!require(roxygen2)) install.packages("roxygen2")
devtools::document("adExplorerPackage")
