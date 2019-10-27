# gtrendsR
# Original source: https://www.r-bloggers.com/fundatafriday-gtrendsr/

# Installation
#install.packages("gtrendsR") #done

# Load library
library(gtrendsR)

# full usage of "gtrends"
gtrends(keyword = NA, geo = "", time = "today+5-y",
        gprop = c("web", "news", "images", "froogle", "youtube"),
        category = 0, hl = "en-US", low_search_volume = FALSE,
        cookie_url = "http://trends.google.com/Cookies/NID", tz = 0,
        onlyInterest = FALSE)
# See details here: https://cran.r-project.org/web/packages/gtrendsR/gtrendsR.pdf

# To see all countries code
data(countries); countries

# gtrendsR plots gtrends object using ggplot (silently)
# To have a look of how the package plots so easily this complicated objects, run:
getAnywhere(plot.gtrends)

# Retrieve data -----------------------------------------------------------

# Choose keywords
g.keywords <- c("Data science")
#g.keywords <- c("Data science",  "All I want for christmas")

# Retrieve data with function "gtrends"
my.trend <- gtrends(keyword = g.keywords,
                   geo = "",
                   time = "today+5-y")


# Plotting ----------------------------------------------------------------

# Quick plot with R base
plot(my.trend)

# Adv ggplots
library("ggplot2")

# Build dataframe to plot
data.to.plot <- data.frame(date = my.trend$interest_over_time$date,
                           hits = my.trend$interest_over_time$hits,
                           keyword = paste( my.trend$interest_over_time$keyword, " (",  my.trend$interest_over_time$geo, ")", sep = ""))
head(data.to.plot)

# Define a vector that contains xmas days
xmas.dates <- paste("20", c(14:19), "-12-25", sep = ""); xmas.dates
# Or a vector with first day of the year
lastday.dates <- paste("20", c(14:19), "-12-31", sep = ""); lastday.dates
# Or at the end of summer
summerend.dates <- paste("20", c(14:19), "-08-01", sep = ""); summerend.dates
# Plot gtrends
ggplot(data.to.plot, aes(x = date, y = hits, color = keyword)) +
  geom_line() +
  # add lines to mark xmas days
  geom_vline(xintercept = as.integer(as.POSIXct(xmas.dates)), colour = "blue", linetype = 3, size = 0.75) 
  # add lines to mark end of summer (add + in the previous code of line)
  #geom_vline(xintercept = as.integer(as.POSIXct(firstsummer.dates)), colour = "red", linetype = 3, size = 0.75)

str(my.trend)

# How to plot a vertical line when x-axis are dates
my.date <- "2019-08-25"
as.integer(as.POSIXct(my.date))

min(data.to.plot$date)



# Testing area ------------------------------------------------------------

# add legend to xmas lines
ggplot(data.to.plot, aes(x = date, y = hits, lty  = keyword)) +
  geom_line() +
  geom_vline(xintercept = as.integer(as.POSIXct(xmas.dates)), colour = "blue", linetype = 3, size = 0.75) +
  scale_color_manual(name = "statistics", values = c(median = "blue", mean = "red"))


