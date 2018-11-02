rm(list = ls())

library(dplyr)

# Read in the kickstarted projects dataset
kickdf <- read.csv("ks-projects-201801.csv", na.strings = "")
# Remove rows in kickdf that are have a launch Dates of "1970-01-01"
kickdf <- subset(kickdf, launched != "1970-01-01 01:00:00")

# Read in the CountryCode dataset
countrydf <- read.csv("country_code.csv", na.strings = "")
# Keep only country name and 2-digit country code from countrydf
countrydf <- countrydf[, c("Country_name", "code_2digit")]

  #     COLUMN NAMES          DATA TYPE         DESCRIPTION
  # 1.  ProjectID             integer (7)       Project identifier
  # 2.  ProjectName           character (96)    Name of the project
  # 3.  SubCategory           factor (18)       Sub-category of the project
  # 4.  MainCategory          factor (12)       Main category of the project
  # 5.  OriginalCurrency      factor (3)        Currency of the project
  # 6.  Deadline              Dates (10)        Deadline of the project
  # 7.  goal                  numeric (11)      goal amount in project currency
  # 8.  LaunchDate            Dates (10)        Dates project was launched
  # 9.  pledged               numeric (11)      PledgedAmount amount in project currency
  # 10. ProjectState          factor (10)       Current state of project
  # 11. Backers               integer (6)       Number of Backers
  # 12. CountryCode           character (2)     Country code where the project started
  # 13. CountryName           character (44)    Country name corresponding to country code
  # 14. usd_PledgedAmount     numeric (11)      PledgedAmount amount in USD
  # 15. PledgedAmount         numeric (11)      PledgedAmount amount in USD adjusted for inflation
  # 16. GoalAmount            numeric (12)      goal amount in USD
  # 17. ActiveDays            integer (2)       Number of days the project was active
  # 18. CategoryID            integer (4)       Unique identifier assigned to each SubCategory
  # 19. ProportionReached     numeric (6, 2)    Proportion of goal reached (PledgedAmount/goal)
  # 20. Dates                 Dates (10)         Dates from 01/01/2009 to 12/31/2018
  # 21. Year                  character (4)     Year corresponding to Dates column
  # 22. Month                 character (2)     Month corresponding to Dates column
  # 23. DayOfMonth            character (2)     Day of Month corresponding to Dates column
  # 24. DayOfWeek             factor (3)        Day of week corresponding to Dates colum
  # 25. Weekday               factor (7)        Weekday/weekend corresponding to Dates column

# UpDates column names in kickdf for clarity
names(kickdf)[names(kickdf) == "ID"] <- "ProjectID"
names(kickdf)[names(kickdf) == "name"] <- "ProjectName"
names(kickdf)[names(kickdf) == "main_category"] <- "MainCategory"
names(kickdf)[names(kickdf) == "category"] <- "SubCategory"
names(kickdf)[names(kickdf) == "deadline"] <- "Deadline"
names(kickdf)[names(kickdf) == "currency"] <- "OriginalCurrency"
names(kickdf)[names(kickdf) == "launched"] <- "LaunchDate"
names(kickdf)[names(kickdf) == "usd_pledged_real"] <- "PledgedAmount"
names(kickdf)[names(kickdf) == "backers"] <- "Backers"
names(kickdf)[names(kickdf) == "state"] <- "ProjectState"
names(kickdf)[names(kickdf) == "country"] <- "CountryCode"
names(kickdf)[names(kickdf) == "usd_goal_real"] <- "GoalAmount"

# UpDates column names countrydf for consistency
names(countrydf)[names(countrydf) == "Country_name"] <- "CountryName"
names(countrydf)[names(countrydf) == "code_2digit"] <- "CountryCode"

# UpDates data type for columns in kickdf
kickdf$project_name <- as.character(kickdf$ProjectName)
kickdf$Deadline <- as.Date(kickdf$Deadline)
kickdf$LaunchDate <- as.Date(kickdf$LaunchDate)

# Create a new integer column for number of days the project was active
kickdf$ActiveDays <- kickdf$Deadline - kickdf$LaunchDate
kickdf$ActiveDays <- as.integer(kickdf$ActiveDays)

# Create a new numeric column for proportion of goal reached
kickdf$GoalAmount <- round(kickdf$GoalAmount, 2)
kickdf$PledgedAmount <- round(kickdf$PledgedAmount, 2)
kickdf$ProportionReached <- round(kickdf$PledgedAmount / kickdf$GoalAmount, 2)

# Remove all rows with at least one piece of missing data
kickdf <- kickdf[complete.cases(kickdf), ]

# Create Country Table
countrydf <- countrydf[,c("CountryCode", "CountryName")]
countrydf$CountryCode <- as.character(countrydf$CountryCode)
write.csv(countrydf, file = "Country_T.csv")

# Create Category Table and assign unique CategoryIDs
categoryCol <- c("SubCategory","MainCategory")
categorydf <- kickdf[,categoryCol]
categorydf <- unique(categorydf)
categorydf <- categorydf[order(categorydf$MainCategory, categorydf$SubCategory), ]
categorydf$CategoryID <- 1:nrow(categorydf)
categorydf$CategoryID <- categorydf$CategoryID + 3000
categorydf <- categorydf[,c("CategoryID", "MainCategory", "SubCategory")]
write.csv(categorydf, file = "Category_T.csv")

# Import the CategoryIDs created back into our kickdf
kickdf <- left_join(kickdf, categorydf)

# Reassign and standardize the project ID numbers
kickdf$ProjectID <- 1:nrow(kickdf)
kickdf$ProjectID <- kickdf$ProjectID + 1000000

# Create Project Table
projectCol <- c("ProjectID", "ProjectName", "CategoryID", 
                "CountryCode","OriginalCurrency", "LaunchDate", 
                "Deadline","ActiveDays","GoalAmount", 
                "PledgedAmount", "ProportionReached", "Backers", 
                "ProjectState")
projectdf <- kickdf[,projectCol]
write.csv(projectdf, file = "Project_T.csv")

# Create Calendar Table
calendardf <- data.frame(Dates = 1:3651)
calendardf$Dates <- as.Date("2009-01-01") + calendardf$Dates
calendardf$Year <- format(calendardf$Dates,"%Y")
calendardf$Month <- format(calendardf$Dates,"%m")
calendardf$DayOfMonth <- format(calendardf$Dates,"%d")
calendardf$DayOfWeek <- weekdays(calendardf$Dates, TRUE)
calendardf$Weekday[calendardf$DayOfWeek == "Mon"] <- "Weekday"
calendardf$Weekday[calendardf$DayOfWeek == "Tue"] <- "Weekday"
calendardf$Weekday[calendardf$DayOfWeek == "Wed"] <- "Weekday"
calendardf$Weekday[calendardf$DayOfWeek == "Thu"] <- "Weekday"
calendardf$Weekday[calendardf$DayOfWeek == "Fri"] <- "Weekday"
calendardf$Weekday[calendardf$DayOfWeek == "Sat"] <- "Weekend"
calendardf$Weekday[calendardf$DayOfWeek == "Sun"] <- "Weekend"
calendardf$DayOfWeek <- as.factor(calendardf$DayOfWeek)
calendardf$Weekday <- as.factor(calendardf$Weekday)
write.csv(calendardf, file = "Calendar_T.csv")