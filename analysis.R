
library(dplyr)
library(knitr)
library(styler)
library(ggplot2)
library(plotly)

origin_data <- read.csv("grocery_store_data_cleaned.csv", stringsAsFactors = FALSE)
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
  geom_point(mapping = aes(x = cleaned_date, y = sumUnit, color = CATEGORY)) +
  scale_color_brewer(palette = "Set3") + 
  theme(
    axis.ticks.x = element_blank(),
    axis.text.x = element_blank()
  ) +
  labs(
    title = "Total Units Sold, 2016-2019",
    x = "Date",
    y = "Total # of Units"
  )

sample_plot2 <- ggplot(data = filtered_categories) +
  geom_point(mapping = aes(x = cleaned_date, y = sumUnit, color = CATEGORY)) +
  facet_wrap(~CATEGORY) + 
  theme(
    strip.text.x = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.title.y = element_blank()
  ) +
  labs(
    title = "Total Units Sold, 2016-2019",
    x = "Date"
  )

# Final graph: 1 - aggregate, 2 - separate by category (10 small plots)
interactive_plot <- ggplotly(sample_plot)
interactive_plot2 <- ggplotly(sample_plot2)




