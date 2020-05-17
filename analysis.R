install.packages("dplyr")
install.packages("knitr")
install.packages("styler")
library(dplyr)
library(knitr)
library(styler)

store <- read.csv("grocery_store_data_cleaned.csv")


# Unique product names
product_name <- unique(store$NAME)


# Units, reference, name, unit_pricesell/buy, category, total_pricesell/buy, margin, profit
name_col <- store %>%
  filter(REFERENCE == 1079) %>%
  select(NAME)

profit_col <- store %>%
  filter(REFERENCE == 1079) %>%
  select(PROFIT)

product_info <- list(name = name_col, profit = profit_col)




function1 <- function(ref){
  name <- paste0("product", ref, "_info")
  name <- list(name = name_col, profit = profit_col)
}


