install.packages("dplyr")
install.packages("knitr")
install.packages("styler")
library(dplyr)
library(knitr)
library(styler)

origin_data <- read.csv("grocery_store_data_cleaned.csv")
remove_sec <- origin_data %>%
  mutate(cleaned_date = substr(DATE, 1, 10))

nameToDate <- arrange(remove_sec, REFERENCE) %>%
  filter(UNIT_PRICEBUY != 0)%>%
  select(CATEGORY, cleaned_date, UNITS)%>%
  group_by(CATEGORY, cleaned_date)%>%
  summarize(sumUnit = sum(UNITS))

categories <- c()
for(i in 1 : nrow(nameToDate) - 1) {
  date1 <- as.Date(pull(nameToDate[i,2]))
  date2 <- as.Date(pull(nameToDate[i+1,2]))
  if(toString(nameToDate[i,1]) == toString(nameToDate[i+1, 1]) && difftime(as.POSIXct(date2), as.POSIXct(date1), units="days") > 90)
    categories <- c(categories, nameToDate[i,1])
}

sorted_category <- unique(categories)
  

filtered_categories <- nameToDate %>%
  filter(CATEGORY %in% sorted_category)


sample_plot <- ggplot(data = filtered_categories) +
  geom_point(mapping = aes(x = cleaned_date, y = sumUnit))




