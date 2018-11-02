rm(list = ls())

library(dplyr)

# Read in the kickstarted projects dataset
kickdf <- read.csv("ks-projects-201801.csv")
# Remove rows in kickdf that are have a launch date of "1970-01-01"
kickdf <- subset(kickdf, launched != "1970-01-01 01:00:00")

# Read in the country_code dataset
countrydf <- read.csv("country_code.csv")
# Keep only country name and 2-digit country code from countrydf
countrydf <- countrydf[, c("Country_name", "code_2digit")]

#       COLUMN NAMES              DATA TYPE         DESCRIPTION
#   1.  project_ID                integer (7)       Project identifier
#   2.  name                      character (96)    Name of the project
#   3.  category                  factor (18)       Sub-category of the project
#   4.  main_category             factor (12)       Main category of the project
#   5.  original_currency         factor (3)        Currency of the project
#   6.  deadline                  date (10)         Deadline of the project
#   7.  goal                      numeric (11)      Goal amount in project currency
#   8.  launch_date               date (10)         Date project was launched
#   9.  pledged_amount            numeric (11)      Pledged amount in project currency
#   10. project_state             factor (10)       Current state of project
#   11. backers                   integer (6)       Number of backers
#   12. country_code              factor (2)        Country in which the project started
#   13. usd_pledged               numeric (11)      Pledged amount in USD
#   14. usd_pledged_real          numeric (11)      Pledged amount in USD adjusted for inflation
#   15. usd_goal_real             numeric (12)      Goal amount in USD
#   16. active_days               integer (2)       Number of days the project was active
#   16. category_ID               integer (4)       Number of days the project was active
#   17. proportion_goal_reached   numeric (6.2)

#   18. date                      date(10)
#   19. day_of_week               character (3)
#   20. weekday                   character (7)


# Update column names in kickdf for clarity
names(kickdf)[names(kickdf) == "ID"] <- "project_ID"
names(kickdf)[names(kickdf) == "name"] <- "project_name"
names(kickdf)[names(kickdf) == "category"] <- "subcategory"
names(kickdf)[names(kickdf) == "currency"] <- "original_currency"
names(kickdf)[names(kickdf) == "launched"] <- "launch_date"
names(kickdf)[names(kickdf) == "pledged"] <- "pledged_amount"
names(kickdf)[names(kickdf) == "state"] <- "project_state"
names(kickdf)[names(kickdf) == "country"] <- "country_code"
names(kickdf)[names(kickdf) == "usd.pledged"] <- "usd_pledged"

# Update column names countrydf for consistency
names(countrydf)[names(countrydf) == "Country_name"] <- "country_name"
names(countrydf)[names(countrydf) == "code_2digit"] <- "country_code"

# Update data type for columns in kickdf
kickdf$project_name <- as.character(kickdf$project_name)
kickdf$deadline <- as.Date(kickdf$deadline)
kickdf$launch_date <- as.Date(kickdf$launch_date)

# Create a new integer column for number of days the project was active
kickdf$active_days <- kickdf$deadline - kickdf$launch_date
kickdf$active_days <- as.integer(kickdf$active_days)

# Create a new numeric column for proportion of goal reached
kickdf$proportion_goal_reached <- round(kickdf$usd_pledged_real / kickdf$usd_goal_real, 2)

# Remove all rows with at least one piece of missing data
kickdf <- kickdf[complete.cases(kickdf), ]

# Create Country Table
countrydf <- countrydf[,c("country_code", "country_name")]
write.csv(countrydf, file = "Country_T.csv")

# Create Category Table and assign unique category_IDs
categoryCol <- c("subcategory","main_category")
categorydf <- kickdf[,categoryCol]
categorydf <- unique(categorydf)
categorydf <- categorydf[order(categorydf$main_category, categorydf$subcategory), ]
categorydf$category_ID <- 1:nrow(categorydf)
categorydf$category_ID <- categorydf$category_ID + 3000
categorydf <- categorydf[,c("category_ID", "main_category", "subcategory")]
write.csv(categorydf, file = "Category_T.csv")

# Import the category_IDs created back into our kickdf
kickdf <- left_join(kickdf, categorydf)

# Reassign and standardize the project ID numbers
kickdf$project_ID <- 1:nrow(kickdf)
kickdf$project_ID <- kickdf$project_ID + 1000000

# Create Project Table
projectCol <- c("project_ID","project_name","category_ID", "country_code","original_currency", "launch_date", "deadline","active_days","usd_goal_real", "usd_pledged_real", "proportion_goal_reached", "backers", "project_state")
projectdf <- kickdf[,projectCol]
write.csv(projectdf, file = "Project_T.csv")

# Create Calendar Table
calendardf <- data.frame(date = 1:3651)
calendardf$date <- as.Date("2009-01-01") + calendardf$date
calendardf$day_of_week <- weekdays(calendardf$date, TRUE)
calendardf$weekday[calendardf$day_of_week == "Mon"] <- "Weekday"
calendardf$weekday[calendardf$day_of_week == "Tue"] <- "Weekday"
calendardf$weekday[calendardf$day_of_week == "Wed"] <- "Weekday"
calendardf$weekday[calendardf$day_of_week == "Thu"] <- "Weekday"
calendardf$weekday[calendardf$day_of_week == "Fri"] <- "Weekday"
calendardf$weekday[calendardf$day_of_week == "Sat"] <- "Weekend"
calendardf$weekday[calendardf$day_of_week == "Sun"] <- "Weekend"
calendardf$day_of_week <- as.factor(calendardf$day_of_week)
calendardf$weekday <- as.factor(calendardf$weekday)
write.csv(calendardf, file = "Calendar_T.csv")