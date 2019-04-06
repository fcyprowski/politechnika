context("simulate function")

# uwaga, nie bedzie dzialac jak sie pozbedziemy obiektow z sesji
# zeby dzialalo powinnismy:
# 1. stworzyc folder "data" w naszym pakiecie
# 2. przekopiowac do tego folderu display_data.RData (ktore juz znajduje sie w repozytorium)
# 
# * zaczynamy od "politechnika/shiny_apps/adExplorer/adExplorerPackage"
input_df = display_data %>%
  group_by(creative_id) %>%
  summarise(n = n())
# a jeszcze lepiej - wywalic ten kod na gorze i zapisac w folderze ..../adExplorerPackage/data
# plik input_df.RData (save(input_df, file = "adExplorerPackage/data/input_df.RData))
test_that("simulate zwraca jedna wartosc i nie moze to byc wartosc ujemna", {
  output = simulate(input_df)
  expect_is(output, "numeric")
  expect_length(output, 1)
  expect_gte(output, 0)
})