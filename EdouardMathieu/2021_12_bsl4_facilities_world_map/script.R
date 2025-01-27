library(data.table)
library(rvest)
library(lubridate)
library(plyr)
rm(list = ls())
setwd("~/git/notebooks/EdouardMathieu/2021_12_bsl4_facilities_world_map/")

page <- read_html("https://en.wikipedia.org/wiki/Biosafety_level#Biosafety_level_4")
tbl <- page %>% html_nodes("table") %>% html_table()

df <- tbl[[4]]
setDT(df)
df <- df[, .(year = year(today()), bsl4_facilities = .N), Country]
setnames(df, "Country", "entity")
df[, entity := mapvalues(entity, "Czech Republic", "Czechia")]

fwrite(df, "Biosafety level 4 facilities.csv")
