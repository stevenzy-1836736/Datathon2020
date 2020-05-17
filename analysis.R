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



#####

product_info <- list(name = name_col, profit = profit_col)

var <- for(i in 1:5){
    store %>%
    filter(NAME == product_name[i]) %>%
    
  #create_list(product_name[i])
}

sample_product <- store %>%
  filter(REFERENCE == 1079)
sample_profit <- select(sample_product, PROFIT)
sample_total_sell <- select(sample_product, TOTAL_PRICESELL)
sample_unit <- select(sample_product, UNITS)

sample_plot <- ggplot(data = sample_product) +
  geom_point(mapping = aes(x = UNIT_PRICESELL, y = ))


create_list <- function(name, df){
  result <- paste0(name, "_info")
  result <- list(profit = profit_col)
}


