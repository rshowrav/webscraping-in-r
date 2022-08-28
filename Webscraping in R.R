# Installing Necessary Packages (note: run only if packages not installed)

install.packages("rvest")
install.packages("tidyverse")
install.packages("data.table")

# Loading Packages

library(rvest)
library(tidyverse)
library(data.table)

# Creating empty data table

laptops = data.table()

# Looping through website to gather necessary data

for(pgn in seq(from=1, to=7, by =1 )){
  
  link = paste0("https://www.microcenter.com/search/search_results.aspx?N=4294967288&NTK=all&page=",pgn,"&cat=Laptops/Notebooks-:-MicroCenter")
  page = read_html(link)
  
  info = page %>% html_nodes(".normal a") %>% html_text()
  sku = page %>% html_nodes(".sku") %>% html_text()
  price = page %>% html_nodes(".price > span") %>% html_text()
  ship_time= page %>% html_nodes(".availabilityTrunc") %>% html_text()
  
  
  laptops = rbind(laptops, data.table(info, sku, price, ship_time, stringsAsFactors = FALSE))
}

