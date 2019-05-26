# zrównoleglenie w R
# 1 opcja - mclapply z pakietu parallel
library(parallel)
library(dplyr)
library(purrr)
split(iris, iris$Species) %>%
  mclapply(function(x) data.frame(Species = unique(x$Species),
                                  Petal.Length = sum(x$Petal.Length)),
           mc.cores = 1) %>%
  bind_rows()

# 2 opcja - furrr
library(furrr)
plan(multiprocess)
split(iris, iris$Species) %>%
  future_map(~data.frame(Species = unique(.x$Species),
                         Petal.Length = sum(.x$Petal.Length))) %>%
  bind_rows()
# bardziej zaawansowana konfiguracja - możemy rozproszyć obliczenia na dowolne
# komputery (workery) do ktorych mamy dostep
# PAMIETAMY o tym, ze na kazdym z tych komputerow powinniśmy zainstalować 
# takie samo środowisko. Najłatwiej zrobić to za pomocą Dockera.
# Tutaj bardzo dobry, nieco bardziej zaawansowany tutorial: 
# https://www.andrewheiss.com/blog/2018/07/30/disposable-supercomputer-future/
# (działa, testowałem)
ips = c("127.0.0.1")
plan(remote, workers = ips)
split(iris, iris$Species) %>%
  future_map(~data.frame(Species = unique(.x$Species),
                         Petal.Length = sum(.x$Petal.Length))) %>%
  bind_rows()
plan(sequential)
# 
cl = makeCluster(4)


# Parallel Machine Learning - H2O
# konieczne jest zainstalowanie JVM i JDK

library(bigrquery)
library(bigQueryR)
project = "bigquery-public-data"
dataset = "google_analytics_sample"
# get all tables names
our_dataset = bq_dataset(project, dataset)
table_list = bq_dataset_tables(our_dataset) %>%
  map_chr(~.x$table)
queryBQ = function(table) {
  bigQueryR::bqr_query(
    "private-lab-218014", 
    "google_analytics_sample", 
    paste0("SELECT * FROM [bigquery-public-data:google_analytics_sample.",
           table, "]")
  )
}


context %>%
  tbl("ga_sessions_20170801") %>%
  group_by(visitorId) %>%
  summarise(n = n())

install.packages("h2o")
library(h2o)
h2o_cl = h2o.init()
path = "C:/DATA/Airlines_87_08/2008.csv"
air2008.hex = h2o.uploadFile(path = path)

