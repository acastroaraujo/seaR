## code to prepare `DATASET` dataset goes here

teams <- readxl::read_xls("data-raw/teams.xls")
usethis::use_data(teams, overwrite = TRUE, compress = "xz")

