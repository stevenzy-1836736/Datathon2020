install.packages("dplyr")
install.packages("knitr")
install.packages("styler")
library(dplyr)
library(knitr)
library(styler)

origin_data <- read.csv("grocery_store_data_cleaned.csv")

nameToDate <- arrange(store, REFERENCE) %>%
  filter(UNIT_PRICEBUY != 0)%>%
  select(NAME, DATE)

for(i in 1 : 10000) {
  date1 <- as.Date(sorted_all_data[i,2])
  date2 <- as.Date(sorted_all_data[i+1,2])
  if(sorted_all_data[i,1] == sorted_all_data[i+1, 1] && difftime(as.POSIXct(date2), as.POSIXct(date1), units="days") > 30)
    print(sorted_all_data[i,1])
}


sample_product <- store %>%
  filter(REFERENCE == 1001)
sample_DATE <- select(sample_product, DATE)
sample_UNITS <- select(sample_product, UNITS)


sample_plot <- ggplot(data = sample_product) +
  geom_point(mapping = aes(x = UNITS, y = DATE))




