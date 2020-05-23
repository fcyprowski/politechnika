library(checkpoint)
checkpoint::checkpoint("2020-05-01", R.version = "3.6.3")


if (!require("DBI")) install.packages("DBI")
if (!require("RPostgreSQL")) install.packages("RPostgreSQL")

# jesli nie dziala - sprawdzic:
# 1. Czy nie zmienilo nam się IP (wowczas dopisac do whitelisty)
# 2. Czy baza w ogole istnieje
# 3. Literowki!
con = DBI::dbConnect(
  RPostgreSQL::PostgreSQL(),
  host = 'politechnika.postgres.database.azure.com',
  db = "postgres",
  user = "filipcyprowski@politechnika",
  password = rstudioapi::askForPassword(),
  port = 5432
)
# PAMIETAJ O ZAMKNIECIU POLACZENIA PO SKONCZENIU SESJI!!!
# dla pewnosci zawsze puszczaj:
DBI::dbListConnections(RPostgreSQL::PostgreSQL()) %>%
  lapply(DBI::dbDisconnect)

select_all_from = function(from) {
  paste("SELECT * FROM", from)
}
show_tables = function(con) {
  DBI::dbGetQuery(con, select_all_from("pg_catalog.pg_tables"))
}
show_databases = function(con) {
  DBI::dbGetQuery(con, "SELECT datname FROM pg_database")
}





# A teraz wrzucamy do bazy nasze dane: ------------------------------------

# w bardziej produkcyjnym rozwiazaniu musielibysmy stworzy osobna baze danych:
# DBI::dbSendQuery(con, "CREATE DATABASE shinyapp")
# oraz nowego uzytkownika z dostepem wylacznie do tej bazy danych
# 
# PONIEWAZ TO TYLKO PRZYKLAD skracamy droge i wrzucamy tabele do 
data_to_upload =  read.csv("data/dummy_transactions.csv")
DBI::dbWriteTable(con, "facts_sourcepath", data_to_upload)
# sprawdzamy:
dane = DBI::dbGetQuery(con, "SELECT * FROM facts_sourcepath LIMIT 5")


