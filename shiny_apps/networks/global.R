if (!require("bigrquery")) install.packages("bigrquery")
if (!require(dbplyr)) install.packages("dbplyr")

set_service_token("private-lab-218014-08f9ea3f03cd.json")
# łączenie z bazami danych
con = dbConnect(bigquery(),
                project = "private-lab-218014")

con %>%
  tbl("PB.mpg") %>%
  select(manufacturer, cyl) %>%
  group_by(manufacturer) %>%
  summarise(mean_cyl = mean(cyl))

