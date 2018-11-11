# 2018-MSCI-6050-Kickstarter-Projects-Analysis

## Description
Analyzing data on Kickstarter Projects as a class project for MSCI:6050 Data Management and Visual Analytics

## Credits
  1) Mickaël Mouillé (https://www.kaggle.com/kemical) for the dataset on Kickstarter Projects (https://www.kaggle.com/kemical/kickstarter-projects)
  2) Koki Ando (https://www.kaggle.com/koki25ando) for the dataset on Country Codes (https://www.kaggle.com/koki25ando/country-code)

## Contributors 
  1) Clarisse Chia 
  2) Olivia Nauman
  3) David Langley
  4) Oluwasayo Taiwo
  5) Hutan Vahdat

## Process
  1) Collect data on both Kickstarter Projects and Country Codes from Kaggle.com 
  2) Build an Entity Relationship (ER) Diagrams to visualize the relationship between the datapoints
  3) Clean and build upon the dataset on R
  4) Split the dataset into smaller subsets on R before importing them into Oracle SQL
  5) Query the datasets on Oracle SQL
  6) Visualize our findings on Tableau
  7) Present our results
  8) Write a report on our lessons learned

## Data Dictionary
      COLUMN NAMES              DATA TYPE (len)   DESCRIPTION
      project_ID                integer (7)       Project identifier
      name                      character (96)    Name of the project
      category                  factor (18)       Sub-category of the project
      main_category             factor (12)       Main category of the project
      original_currency         factor (3)        Currency of the project
      deadline                  date (10)         Deadline of the project
      goal                      numeric (11)      Goal amount in project currency
      launch_date               date (10)         Date project was launched
      pledged_amount            numeric (11)      Pledged amount in project currency
      project_state             factor (10)       Current state of project
      backers                   integer (6)       Number of backers
      country_code              factor (2)        Country in which the project started
      usd_pledged               numeric (11)      Pledged amount in USD
      usd_pledged_real          numeric (11)      Pledged amount in USD adjusted for inflation
      usd_goal_real             numeric (12)      Goal amount in USD
      active_days               integer (2)       Number of days the project was active
      category_ID               integer (4)       Category IDs uniquely assigned to each subcategory
      proportion_goal_reached   numeric (6, 2)    Proportion of goals reached (Pledged/goal)
      date                      date (10)         Collection of all dates from 2009 to 2018
      day_of_week               character (3)     Day of the week for "date" column
      weekday                   character (7)     Indicates "date" column is a weekday
      
## Tables Created
  1) Project_T
  2) Category_T
  3) Country_T
  4) Calendar_T
